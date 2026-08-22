import 'package:flutter/material.dart';
import 'historico_estoque_screen.dart';
import '../../core/database/app_database.dart';
import '../../repositories/estoque_repository.dart';

enum NivelEstoque { critico, baixo, normal }

class EstoqueScreen extends StatefulWidget {
  const EstoqueScreen({super.key});

  @override
  State<EstoqueScreen> createState() => _EstoqueScreenState();
}

class _EstoqueScreenState extends State<EstoqueScreen> {
  final EstoqueRepository repository = EstoqueRepository();

  NivelEstoque nivelEstoque(Produto produto) {
    if (produto.estoqueInicial <= 0) {
      return produto.estoqueAtual <= 0
          ? NivelEstoque.critico
          : NivelEstoque.normal;
    }

    final percentual = produto.estoqueAtual / produto.estoqueInicial;

    if (percentual <= 0.10) {
      return NivelEstoque.critico;
    }

    if (percentual <= 0.25) {
      return NivelEstoque.baixo;
    }

    return NivelEstoque.normal;
  }

  bool estoqueEmAlerta(Produto produto) {
    final nivel = nivelEstoque(produto);

    return nivel == NivelEstoque.critico || nivel == NivelEstoque.baixo;
  }

  int ordemNivelEstoque(NivelEstoque nivel) {
    switch (nivel) {
      case NivelEstoque.critico:
        return 0;

      case NivelEstoque.baixo:
        return 1;

      case NivelEstoque.normal:
        return 2;
    }
  }

  double percentualEstoque(Produto produto) {
    if (produto.estoqueInicial <= 0) {
      return 0;
    }

    final percentual = produto.estoqueAtual / produto.estoqueInicial;

    return percentual.clamp(0.0, 1.0);
  }

  Future<void> abrirListaCompras(List<Produto> produtos) async {
    final produtosParaComprar = produtos
        .where(
          (produto) =>
              produto.estoqueInicial > 0 &&
              produto.estoqueAtual < produto.estoqueInicial,
        )
        .toList();

    produtosParaComprar.sort((produtoA, produtoB) {
      final faltaA = produtoA.estoqueInicial - produtoA.estoqueAtual;

      final faltaB = produtoB.estoqueInicial - produtoB.estoqueAtual;

      return faltaB.compareTo(faltaA);
    });

    final totalUnidades = produtosParaComprar.fold<int>(0, (total, produto) {
      final quantidade = produto.estoqueInicial - produto.estoqueAtual;

      return total + quantidade;
    });

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.shopping_cart_outlined, color: Color(0xFF0B1F3A)),
              SizedBox(width: 10),
              Expanded(child: Text('Lista de compras')),
            ],
          ),
          content: SizedBox(
            width: 580,
            height: 480,
            child: produtosParaComprar.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          size: 70,
                          color: Colors.green,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Nenhuma reposição necessária.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Todos os produtos estão no estoque inicial.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8EDF4),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Wrap(
                          spacing: 24,
                          runSpacing: 8,
                          children: [
                            Text(
                              '${produtosParaComprar.length} produto(s)',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0B1F3A),
                              ),
                            ),
                            Text(
                              '$totalUnidades unidade(s) para comprar',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0B1F3A),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      Expanded(
                        child: ListView.separated(
                          itemCount: produtosParaComprar.length,
                          separatorBuilder: (_, __) {
                            return const Divider(height: 1);
                          },
                          itemBuilder: (context, index) {
                            final produto = produtosParaComprar[index];

                            final quantidadeComprar =
                                produto.estoqueInicial - produto.estoqueAtual;

                            final nivel = nivelEstoque(produto);

                            final Color corNivel;

                            switch (nivel) {
                              case NivelEstoque.critico:
                                corNivel = Colors.red.shade700;
                                break;

                              case NivelEstoque.baixo:
                                corNivel = Colors.orange.shade800;
                                break;

                              case NivelEstoque.normal:
                                corNivel = Colors.green.shade700;
                                break;
                            }

                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 6,
                              ),
                              leading: CircleAvatar(
                                backgroundColor: corNivel.withOpacity(
                                  0.12,
                                ),
                                child: Icon(
                                  Icons.inventory_2_outlined,
                                  color: corNivel,
                                ),
                              ),
                              title: Text(
                                produto.nome,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                '${produto.categoria} • '
                                'Atual: ${produto.estoqueAtual} • '
                                'Ideal: ${produto.estoqueInicial}',
                              ),
                              trailing: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: corNivel.withOpacity( 0.12),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'Comprar $quantidadeComprar',
                                  style: TextStyle(
                                    color: corNivel,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          ),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> abrirEntradaEstoque(Produto produto) async {
    final quantidadeController = TextEditingController();

    final observacaoController = TextEditingController();

    final quantidade = await showDialog<int>(
      context: context,
      builder: (dialogContext) {
        String? mensagemErro;

        return StatefulBuilder(
          builder: (context, atualizarDialog) {
            return AlertDialog(
              title: Text('Adicionar estoque\n${produto.nome}'),
              content: SizedBox(
                width: 420,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Estoque atual: '
                      '${produto.estoqueAtual}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 18),
                    TextField(
                      controller: quantidadeController,
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Quantidade',
                        hintText: 'Quantidade recebida',
                        border: const OutlineInputBorder(),
                        errorText: mensagemErro,
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: observacaoController,
                      maxLength: 150,
                      decoration: const InputDecoration(
                        labelText: 'Observação (opcional)',
                        hintText: 'Ex.: compra mensal',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
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
                    final valor = int.tryParse(
                      quantidadeController.text.trim(),
                    );

                    if (valor == null || valor <= 0) {
                      atualizarDialog(() {
                        mensagemErro = 'Informe uma quantidade válida.';
                      });

                      return;
                    }

                    Navigator.pop(dialogContext, valor);
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Adicionar'),
                ),
              ],
            );
          },
        );
      },
    );

    if (quantidade == null) {
      quantidadeController.dispose();
      observacaoController.dispose();
      return;
    }

    final observacao = observacaoController.text.trim();

    quantidadeController.dispose();
    observacaoController.dispose();

    final messenger = ScaffoldMessenger.of(context);

    try {
      await repository.registrarEntrada(
        produtoId: produto.id,
        quantidade: quantidade,
        observacao: observacao.isEmpty ? null : observacao,
      );

      if (!mounted) {
        return;
      }

      messenger.showSnackBar(
        SnackBar(
          content: Text(
            'Entrada de $quantidade unidade(s) '
            'registrada para ${produto.nome}.',
          ),
          backgroundColor: Colors.green,
        ),
      );
    } catch (erro) {
      if (!mounted) {
        return;
      }

      messenger.showSnackBar(
        SnackBar(
          content: Text(
            'Não foi possível registrar a entrada: '
            '$erro',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> abrirAjusteEstoque(Produto produto) async {
    final quantidadeController = TextEditingController(
      text: produto.estoqueAtual.toString(),
    );
    final observacaoController = TextEditingController();
    final chaveFormulario = GlobalKey<FormState>();

    final novoEstoque = await showDialog<int>(
      context: context,
      builder: (dialogContext) {
        String? mensagemErro;

        return StatefulBuilder(
          builder: (context, atualizarDialog) {
            return AlertDialog(
              title: Row(
                children: [
                  const Icon(Icons.tune_outlined),
                  const SizedBox(width: 10),
                  Expanded(child: Text('Ajustar estoque\n${produto.nome}')),
                ],
              ),
              content: SizedBox(
                width: 420,
                child: Form(
                  key: chaveFormulario,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade50,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.amber.shade200),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.info_outline, color: Colors.amber),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Estoque atual do sistema: ${produto.estoqueAtual} unidade(s).\n'
                                'Informe a quantidade correta.',
                                style: TextStyle(
                                  color: Colors.amber.shade900,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: quantidadeController,
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Novo estoque',
                          hintText: 'Quantidade correta',
                          border: const OutlineInputBorder(),
                          errorText: mensagemErro,
                          prefixIcon: const Icon(Icons.inventory_2_outlined),
                        ),
                        validator: (valor) {
                          final numero = int.tryParse(valor?.trim() ?? '');
                          if (numero == null || numero < 0) {
                            return 'Informe uma quantidade válida.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),
                      TextFormField(
                        controller: observacaoController,
                        maxLength: 150,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          labelText: 'Motivo do ajuste',
                          hintText: 'Ex.: Correção após contagem física',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.notes_outlined),
                        ),
                        validator: (valor) {
                          if (valor == null || valor.trim().length < 3) {
                            return 'Informe o motivo do ajuste.';
                          }
                          return null;
                        },
                      ),
                    ],
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
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC107),
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    if (chaveFormulario.currentState?.validate() != true) {
                      return;
                    }
                    final valor = int.tryParse(
                      quantidadeController.text.trim(),
                    );
                    if (valor == null || valor < 0) {
                      atualizarDialog(() {
                        mensagemErro = 'Informe uma quantidade válida.';
                      });
                      return;
                    }
                    Navigator.pop(dialogContext, valor);
                  },
                  icon: const Icon(Icons.save),
                  label: const Text('Confirmar ajuste'),
                ),
              ],
            );
          },
        );
      },
    );

    if (novoEstoque == null) {
      quantidadeController.dispose();
      observacaoController.dispose();
      return;
    }

    final observacao = observacaoController.text.trim();

    quantidadeController.dispose();
    observacaoController.dispose();

    final messenger = ScaffoldMessenger.of(context);

    try {
      await repository.ajustarEstoque(
        produtoId: produto.id,
        novoEstoque: novoEstoque,
        observacao: observacao,
      );

      if (!mounted) {
        return;
      }

      messenger.showSnackBar(
        SnackBar(
          content: Text(
            'Estoque de ${produto.nome} ajustado para $novoEstoque unidade(s).',
          ),
          backgroundColor: Colors.green,
        ),
      );
    } catch (erro) {
      if (!mounted) {
        return;
      }

      messenger.showSnackBar(
        SnackBar(
          content: Text(
            'Não foi possível ajustar o estoque: $erro',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        title: const Text('Estoque'),
        backgroundColor: const Color(0xFF0B1F3A),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Histórico',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HistoricoEstoqueScreen(),
                ),
              );
            },
            icon: const Icon(Icons.history),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 950),
            child: StreamBuilder<List<Produto>>(
              stream: repository.observarProdutos(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return _EstadoErro(erro: snapshot.error.toString());
                }

                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final produtos = snapshot.data!;

                if (produtos.isEmpty) {
                  return const _EstadoVazio();
                }

                final produtosAtivos = produtos
                    .where((produto) => produto.ativo)
                    .toList();

                produtosAtivos.sort((produtoA, produtoB) {
                  final ordemA = ordemNivelEstoque(nivelEstoque(produtoA));

                  final ordemB = ordemNivelEstoque(nivelEstoque(produtoB));

                  final comparacaoNivel = ordemA.compareTo(ordemB);

                  if (comparacaoNivel != 0) {
                    return comparacaoNivel;
                  }

                  final percentualA = percentualEstoque(produtoA);
                  final percentualB = percentualEstoque(produtoB);

                  final comparacaoPercentual = percentualA.compareTo(
                    percentualB,
                  );

                  if (comparacaoPercentual != 0) {
                    return comparacaoPercentual;
                  }

                  return produtoA.nome.toLowerCase().compareTo(
                    produtoB.nome.toLowerCase(),
                  );
                });

                final quantidadeCritico = produtosAtivos
                    .where(
                      (produto) =>
                          nivelEstoque(produto) == NivelEstoque.critico,
                    )
                    .length;

                final quantidadeBaixo = produtosAtivos
                    .where(
                      (produto) => nivelEstoque(produto) == NivelEstoque.baixo,
                    )
                    .length;

                final quantidadeNormal = produtosAtivos
                    .where(
                      (produto) => nivelEstoque(produto) == NivelEstoque.normal,
                    )
                    .length;

                return Column(
                  children: [
                    _CabecalhoEstoque(
                      totalProdutos: produtosAtivos.length,
                      produtosCriticos: quantidadeCritico,
                      produtosBaixos: quantidadeBaixo,
                      produtosNormais: quantidadeNormal,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: () {
                            abrirListaCompras(produtosAtivos);
                          },
                          icon: const Icon(Icons.shopping_cart_outlined),
                          label: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 13),
                            child: Text(
                              'Gerar lista de compras',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        itemCount: produtosAtivos.length,
                        separatorBuilder: (_, __) {
                          return const SizedBox(height: 12);
                        },
                        itemBuilder: (context, index) {
                          final produto = produtosAtivos[index];

                          return _ProdutoEstoqueCard(
                            produto: produto,
                            nivel: nivelEstoque(produto),
                            percentual: percentualEstoque(produto),
                            aoAdicionar: () {
                              abrirEntradaEstoque(produto);
                            },
                            aoAjustar: () {
                              abrirAjusteEstoque(produto);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _CabecalhoEstoque extends StatelessWidget {
  const _CabecalhoEstoque({
    required this.totalProdutos,
    required this.produtosCriticos,
    required this.produtosBaixos,
    required this.produtosNormais,
  });

  final int totalProdutos;
  final int produtosCriticos;
  final int produtosBaixos;
  final int produtosNormais;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final quantidadeColunas = constraints.maxWidth < 650 ? 2 : 4;

          final larguraDisponivel = constraints.maxWidth;

          final espacamentoTotal = 12.0 * (quantidadeColunas - 1);

          final larguraCard =
              (larguraDisponivel - espacamentoTotal) / quantidadeColunas;

          final cards = [
            _ResumoEstoqueCard(
              titulo: 'Produtos ativos',
              valor: totalProdutos.toString(),
              icone: Icons.inventory_2_outlined,
              cor: const Color(0xFF0B1F3A),
            ),
            _ResumoEstoqueCard(
              titulo: 'Críticos',
              valor: produtosCriticos.toString(),
              icone: Icons.error_outline,
              cor: Colors.red.shade700,
            ),
            _ResumoEstoqueCard(
              titulo: 'Baixos',
              valor: produtosBaixos.toString(),
              icone: Icons.warning_amber_rounded,
              cor: Colors.orange.shade800,
            ),
            _ResumoEstoqueCard(
              titulo: 'Normais',
              valor: produtosNormais.toString(),
              icone: Icons.check_circle_outline,
              cor: Colors.green.shade700,
            ),
          ];

          return Wrap(
            spacing: 12,
            runSpacing: 12,
            children: cards.map((card) {
              return SizedBox(width: larguraCard, child: card);
            }).toList(),
          );
        },
      ),
    );
  }
}

class _ResumoEstoqueCard extends StatelessWidget {
  const _ResumoEstoqueCard({
    required this.titulo,
    required this.valor,
    required this.icone,
    required this.cor,
  });

  final String titulo;
  final String valor;
  final IconData icone;
  final Color cor;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: cor.withOpacity( 0.12),
              child: Icon(icone, color: cor),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(titulo, style: const TextStyle(color: Colors.black54)),
                  const SizedBox(height: 4),
                  Text(
                    valor,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: cor,
                    ),
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

class _ProdutoEstoqueCard extends StatelessWidget {
  const _ProdutoEstoqueCard({
    required this.produto,
    required this.nivel,
    required this.percentual,
    required this.aoAdicionar,
    required this.aoAjustar,
  });

  final Produto produto;
  final NivelEstoque nivel;
  final double percentual;
  final VoidCallback aoAdicionar;
  final VoidCallback aoAjustar;

  Color get corNivel {
    switch (nivel) {
      case NivelEstoque.critico:
        return Colors.red.shade700;

      case NivelEstoque.baixo:
        return Colors.orange.shade800;

      case NivelEstoque.normal:
        return Colors.green.shade700;
    }
  }

  String get textoNivel {
    switch (nivel) {
      case NivelEstoque.critico:
        return 'CRÍTICO';

      case NivelEstoque.baixo:
        return 'BAIXO';

      case NivelEstoque.normal:
        return 'NORMAL';
    }
  }

  IconData get iconeNivel {
    switch (nivel) {
      case NivelEstoque.critico:
        return Icons.error_outline;

      case NivelEstoque.baixo:
        return Icons.warning_amber_rounded;

      case NivelEstoque.normal:
        return Icons.check_circle_outline;
    }
  }

  String get descricaoNivel {
    switch (nivel) {
      case NivelEstoque.critico:
        return 'Reposição urgente';

      case NivelEstoque.baixo:
        return 'Providenciar reposição';

      case NivelEstoque.normal:
        return 'Quantidade adequada';
    }
  }

  @override
  Widget build(BuildContext context) {
    final percentualExibido = (percentual * 100).round();

    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          border: Border(left: BorderSide(color: corNivel, width: 6)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 27,
                    backgroundColor: corNivel.withOpacity( 0.12),
                    child: Icon(iconeNivel, color: corNivel, size: 29),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          produto.nome,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0B1F3A),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          produto.categoria,
                          style: const TextStyle(color: Colors.black54),
                        ),
                        const SizedBox(height: 9),
                        Wrap(
                          spacing: 8,
                          runSpacing: 6,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: corNivel.withOpacity( 0.12),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: corNivel.withOpacity( 0.40),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(iconeNivel, size: 16, color: corNivel),
                                  const SizedBox(width: 5),
                                  Text(
                                    textoNivel,
                                    style: TextStyle(
                                      color: corNivel,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              descricaoNivel,
                              style: TextStyle(
                                color: corNivel,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    alignment: WrapAlignment.end,
                    children: [
                      OutlinedButton.icon(
                        onPressed: aoAjustar,
                        icon: const Icon(Icons.tune_outlined),
                        label: const Text('Ajustar'),
                      ),
                      FilledButton.icon(
                        onPressed: aoAdicionar,
                        icon: const Icon(Icons.add),
                        label: const Text('Adicionar'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _InformacaoEstoque(
                      titulo: 'Estoque atual',
                      valor: produto.estoqueAtual.toString(),
                      cor: corNivel,
                      destaque: true,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _InformacaoEstoque(
                      titulo: 'Estoque inicial',
                      valor: produto.estoqueInicial.toString(),
                      cor: const Color(0xFF0B1F3A),
                      destaque: false,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _InformacaoEstoque(
                      titulo: 'Restante',
                      valor: '$percentualExibido%',
                      cor: corNivel,
                      destaque: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: percentual,
                  minHeight: 10,
                  color: corNivel,
                  backgroundColor: corNivel.withOpacity( 0.15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InformacaoEstoque extends StatelessWidget {
  const _InformacaoEstoque({
    required this.titulo,
    required this.valor,
    required this.cor,
    required this.destaque,
  });

  final String titulo;
  final String valor;
  final Color cor;
  final bool destaque;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: destaque ? cor.withOpacity( 0.08) : const Color(0xFFF4F6F8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
          const SizedBox(height: 4),
          Text(
            valor,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: cor,
            ),
          ),
        ],
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
            'Nenhum produto cadastrado.',
            style: TextStyle(fontSize: 20, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class _EstadoErro extends StatelessWidget {
  const _EstadoErro({required this.erro});

  final String erro;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          'Não foi possível carregar o estoque.\n\n'
          '$erro',
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
