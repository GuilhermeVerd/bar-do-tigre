import 'package:flutter/material.dart';

import '../../core/database/app_database.dart';
import '../../repositories/estoque_repository.dart';
import '../../services/pdf_service.dart';

class InventarioScreen extends StatefulWidget {
  const InventarioScreen({super.key});

  @override
  State<InventarioScreen> createState() => _InventarioScreenState();
}

class _InventarioScreenState extends State<InventarioScreen> {
  final EstoqueRepository repository = EstoqueRepository();

  final Map<int, TextEditingController> controladores = {};

  bool salvando = false;

  @override
  void dispose() {
    for (final controlador in controladores.values) {
      controlador.dispose();
    }

    super.dispose();
  }

  void prepararControladores(List<Produto> produtos) {
    for (final produto in produtos) {
      if (!controladores.containsKey(produto.id)) {
        controladores[produto.id] = TextEditingController(
          text: produto.estoqueAtual.toString(),
        );
      }
    }
  }

  int? obterContagemFisica(Produto produto) {
    final texto = controladores[produto.id]?.text.trim();

    if (texto == null || texto.isEmpty) {
      return null;
    }

    return int.tryParse(texto);
  }

  int obterDiferenca(Produto produto) {
    final contagemFisica = obterContagemFisica(produto);

    if (contagemFisica == null) {
      return 0;
    }

    return contagemFisica - produto.estoqueAtual;
  }

  String textoDiferenca(int diferenca) {
    if (diferenca > 0) {
      return '+$diferenca';
    }

    return diferenca.toString();
  }

  Color corDiferenca(int diferenca) {
    if (diferenca > 0) {
      return Colors.green.shade700;
    }

    if (diferenca < 0) {
      return Colors.red.shade700;
    }

    return Colors.black54;
  }

  int totalProdutosComDiferenca(List<Produto> produtos) {
    return produtos.where((produto) {
      return obterDiferenca(produto) != 0;
    }).length;
  }

  int totalAumentos(List<Produto> produtos) {
    return produtos.where((produto) {
      return obterDiferenca(produto) > 0;
    }).length;
  }

  int totalReducoes(List<Produto> produtos) {
    return produtos.where((produto) {
      return obterDiferenca(produto) < 0;
    }).length;
  }

  Widget resumoInventario(List<Produto> produtos) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resumo do Inventário',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0B1F3A),
              ),
            ),
            const SizedBox(height: 12),
            Text('Produtos conferidos: ${produtos.length}'),
            Text(
              'Produtos com diferença: '
              '${totalProdutosComDiferenca(produtos)}',
            ),
            Text(
              'Aumentos de estoque: '
              '${totalAumentos(produtos)}',
              style: const TextStyle(color: Colors.green),
            ),
            Text(
              'Reduções de estoque: '
              '${totalReducoes(produtos)}',
              style: const TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> gerarPdfInventario(List<Produto> produtos) async {
    final itens = produtos.map((produto) {
      final contagemFisica =
          obterContagemFisica(produto) ?? produto.estoqueAtual;

      return ItemInventarioPdf(
        nome: produto.nome,
        categoria: produto.categoria,
        estoqueSistema: produto.estoqueAtual,
        contagemFisica: contagemFisica,
      );
    }).toList();

    await PdfService.gerarInventario(itens: itens);
  }

  Future<_DadosInventario?> pedirDadosInventario() async {
    final responsavelController = TextEditingController();
    final observacaoController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    final dados = await showDialog<_DadosInventario>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.fact_check_outlined),
              SizedBox(width: 10),
              Expanded(child: Text('Dados do inventário')),
            ],
          ),
          content: SizedBox(
            width: 460,
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: responsavelController,
                      textCapitalization: TextCapitalization.words,
                      autofocus: true,
                      decoration: const InputDecoration(
                        labelText: 'Responsável pelo inventário',
                        prefixIcon: Icon(Icons.badge_outlined),
                        border: OutlineInputBorder(),
                      ),
                      validator: (valor) {
                        if (valor == null || valor.trim().length < 2) {
                          return 'Informe o nome do responsável.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: observacaoController,
                      maxLength: 200,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Observação (opcional)',
                        hintText: 'Ex.: Inventário de final de mês',
                        prefixIcon: Icon(Icons.notes_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancelar'),
            ),
            FilledButton.icon(
              onPressed: () {
                if (formKey.currentState?.validate() != true) {
                  return;
                }
                Navigator.pop(
                  dialogContext,
                  _DadosInventario(
                    responsavel: responsavelController.text.trim(),
                    observacao: observacaoController.text.trim().isEmpty
                        ? null
                        : observacaoController.text.trim(),
                  ),
                );
              },
              icon: const Icon(Icons.check),
              label: const Text('Continuar'),
            ),
          ],
        );
      },
    );

    responsavelController.dispose();
    observacaoController.dispose();

    return dados;
  }

  Future<void> confirmarInventario(List<Produto> produtos) async {
    final itensRegistro = <ItemInventarioRegistro>[];
    var temDiferenca = false;

    for (final produto in produtos) {
      final contagemFisica = obterContagemFisica(produto);
      if (contagemFisica == null || contagemFisica < 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Informe uma contagem válida para ${produto.nome}.',
            ),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      itensRegistro.add(
        ItemInventarioRegistro(
          produtoId: produto.id,
          estoqueContado: contagemFisica,
        ),
      );

      if (contagemFisica != produto.estoqueAtual) {
        temDiferenca = true;
      }
    }

    if (!temDiferenca) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nenhuma diferença foi encontrada no inventário.'),
        ),
      );
    }

    final dados = await pedirDadosInventario();

    if (dados == null || !mounted) {
      return;
    }

    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmar inventário'),
          content: Text(
            'Responsável: ${dados.responsavel}\n\n'
            '${itensRegistro.length} produto(s) serão registrados.\n\n'
            'Deseja confirmar o inventário e corrigir os estoques?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancelar'),
            ),
            FilledButton.icon(
              onPressed: () {
                Navigator.pop(context, true);
              },
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFFFC107),
                foregroundColor: Colors.black,
              ),
              icon: const Icon(Icons.check),
              label: const Text('Confirmar inventário'),
            ),
          ],
        );
      },
    );

    if (confirmar != true || !mounted) {
      return;
    }

    setState(() {
      salvando = true;
    });

    final messenger = ScaffoldMessenger.of(context);

    try {
      await repository.registrarInventario(
        responsavel: dados.responsavel,
        itens: itensRegistro,
        observacao: dados.observacao,
      );

      if (!mounted) {
        return;
      }

      messenger.showSnackBar(
        const SnackBar(
          content: Text('Inventário confirmado com sucesso.'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );
    } catch (erro) {
      if (!mounted) {
        return;
      }

      final mensagem = erro
          .toString()
          .replaceFirst('Bad state: ', '')
          .replaceFirst('StateError: ', '')
          .replaceFirst('Invalid argument(s): ', '');

      messenger.showSnackBar(
        SnackBar(content: Text(mensagem), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) {
        setState(() {
          salvando = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        title: const Text('Inventário'),
        backgroundColor: const Color(0xFF0B1F3A),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: StreamBuilder<List<Produto>>(
          stream: repository.observarProdutos(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return _EstadoErro(mensagem: snapshot.error.toString());
            }

            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final produtos = snapshot.data!
                .where((produto) => produto.ativo)
                .toList();

            prepararControladores(produtos);

            if (produtos.isEmpty) {
              return const _EstadoVazio();
            }

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
                      child: _CabecalhoInventario(),
                    ),
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                        itemCount: produtos.length,
                        separatorBuilder: (_, __) {
                          return const SizedBox(height: 12);
                        },
                        itemBuilder: (context, index) {
                          final produto = produtos[index];

                          return _ProdutoInventarioCard(
                            produto: produto,
                            controlador: controladores[produto.id]!,
                            obterDiferenca: () {
                              return obterDiferenca(produto);
                            },
                            textoDiferenca: textoDiferenca,
                            corDiferenca: corDiferenca,
                            aoAlterar: () {
                              setState(() {});
                            },
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: resumoInventario(produtos),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                      child: SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () async {
                            await gerarPdfInventario(produtos);
                          },
                          icon: const Icon(Icons.picture_as_pdf_outlined),
                          label: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              'Gerar PDF do inventário',
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                      child: SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: salvando
                              ? null
                              : () {
                                  confirmarInventario(produtos);
                                },
                          icon: salvando
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Icon(Icons.fact_check_outlined),
                          label: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              salvando
                                  ? 'Salvando inventário...'
                                  : 'Confirmar inventário',
                              style: const TextStyle(fontSize: 17),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CabecalhoInventario extends StatelessWidget {
  const _CabecalhoInventario();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(18),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: Color(0xFFE8EDF4),
              child: Icon(Icons.fact_check_outlined, color: Color(0xFF0B1F3A)),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contagem física do estoque',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0B1F3A),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Informe a quantidade encontrada fisicamente para cada '
                    'produto. As diferenças serão calculadas automaticamente.',
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProdutoInventarioCard extends StatelessWidget {
  const _ProdutoInventarioCard({
    required this.produto,
    required this.controlador,
    required this.obterDiferenca,
    required this.textoDiferenca,
    required this.corDiferenca,
    required this.aoAlterar,
  });

  final Produto produto;
  final TextEditingController controlador;
  final int Function() obterDiferenca;
  final String Function(int) textoDiferenca;
  final Color Function(int) corDiferenca;
  final VoidCallback aoAlterar;

  @override
  Widget build(BuildContext context) {
    final diferenca = obterDiferenca();

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final usarColuna = constraints.maxWidth < 600;

            final informacoes = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  produto.nome,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0B1F3A),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  produto.categoria,
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 12),
                Text(
                  'Estoque no sistema: ${produto.estoqueAtual}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            );

            final campoContagem = SizedBox(
              width: usarColuna ? double.infinity : 180,
              child: TextField(
                controller: controlador,
                keyboardType: TextInputType.number,
                onChanged: (_) {
                  aoAlterar();
                },
                decoration: const InputDecoration(
                  labelText: 'Contagem física',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.inventory_outlined),
                ),
              ),
            );

            final indicadorDiferenca = Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: corDiferenca(diferenca).withOpacity( 0.10),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Text(
                    'Diferença',
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    textoDiferenca(diferenca),
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: corDiferenca(diferenca),
                    ),
                  ),
                ],
              ),
            );

            if (usarColuna) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  informacoes,
                  const SizedBox(height: 16),
                  campoContagem,
                  const SizedBox(height: 12),
                  indicadorDiferenca,
                ],
              );
            }

            return Row(
              children: [
                Expanded(child: informacoes),
                const SizedBox(width: 16),
                campoContagem,
                const SizedBox(width: 16),
                indicadorDiferenca,
              ],
            );
          },
        ),
      ),
    );
  }
}

class _EstadoVazio extends StatelessWidget {
  const _EstadoVazio();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.inventory_2_outlined, size: 90, color: Colors.black26),
          SizedBox(height: 16),
          Text(
            'Nenhum produto ativo foi encontrado.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class _EstadoErro extends StatelessWidget {
  const _EstadoErro({required this.mensagem});

  final String mensagem;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 70, color: Colors.redAccent),
            const SizedBox(height: 16),
            const Text(
              'Não foi possível carregar o inventário.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              mensagem,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

class _DadosInventario {
  _DadosInventario({required this.responsavel, this.observacao});

  final String responsavel;
  final String? observacao;
}
