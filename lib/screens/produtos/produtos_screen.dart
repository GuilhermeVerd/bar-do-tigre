import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/database/app_database.dart';
import '../../repositories/produto_repository.dart';

class ProdutosScreen extends StatefulWidget {
  const ProdutosScreen({super.key});

  @override
  State<ProdutosScreen> createState() => _ProdutosScreenState();
}

class _ProdutosScreenState extends State<ProdutosScreen> {
  final ProdutoRepository repository = ProdutoRepository();

  final TextEditingController pesquisaController = TextEditingController();

  String pesquisa = '';

  bool estoqueBaixo(Produto produto) {
    if (produto.estoqueInicial <= 0) {
      return false;
    }

    return produto.estoqueAtual <= produto.estoqueInicial * 0.10;
  }

  Future<void> abrirFormulario({Produto? produto}) async {
    final resultado = await showDialog<_DadosProduto>(
      context: context,
      builder: (dialogContext) {
        return _FormularioProdutoDialog(produto: produto);
      },
    );

    if (resultado == null || !mounted) {
      return;
    }

    try {
      if (produto == null) {
        await repository.cadastrarProduto(
          nome: resultado.nome,
          categoria: resultado.categoria,
          precoCentavos: resultado.precoCentavos,
          estoqueInicial: resultado.estoqueInicial,
          fotoPath: resultado.fotoPath,
        );
      } else {
        await repository.atualizarProduto(
          id: produto.id,
          nome: resultado.nome,
          categoria: resultado.categoria,
          precoCentavos: resultado.precoCentavos,
          estoqueInicial: resultado.estoqueInicial,
          estoqueAtual: resultado.estoqueAtual,
          fotoPath: resultado.fotoPath,
          ativo: produto.ativo,
        );
      }

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            produto == null
                ? 'Produto cadastrado com sucesso.'
                : 'Produto atualizado com sucesso.',
          ),
        ),
      );
    } catch (erro) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Não foi possível salvar o produto: $erro')),
      );
    }
  }

  Future<void> alterarSituacao(Produto produto, bool ativo) async {
    try {
      await repository.alterarSituacaoProduto(id: produto.id, ativo: ativo);
    } catch (erro) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Não foi possível alterar o produto: $erro')),
      );
    }
  }

  IconData iconeDaCategoria(String categoria) {
    switch (categoria.toLowerCase()) {
      case 'doces':
        return Icons.cake;
      case 'biscoitos':
        return Icons.cookie;
      default:
        return Icons.local_drink;
    }
  }

  String formatarPreco(int precoCentavos) {
    final valor = precoCentavos / 100;

    return valor.toStringAsFixed(2).replaceAll('.', ',');
  }

  @override
  void dispose() {
    pesquisaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        title: const Text('Produtos'),
        backgroundColor: const Color(0xFF0B1F3A),
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          abrirFormulario();
        },
        backgroundColor: const Color(0xFFFFC107),
        foregroundColor: Colors.black,
        icon: const Icon(Icons.add),
        label: const Text('NOVO PRODUTO'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: StreamBuilder<List<Produto>>(
              stream: repository.observarProdutos(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        'Erro ao carregar produtos:\n'
                        '${snapshot.error}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final produtos = snapshot.data!;

                final textoPesquisa = pesquisa.toLowerCase();

                final produtosFiltrados =
                    produtos.where((produto) {
                      return produto.nome.toLowerCase().contains(
                            textoPesquisa,
                          ) ||
                          produto.categoria.toLowerCase().contains(
                            textoPesquisa,
                          );
                    }).toList()..sort((produtoA, produtoB) {
                      final estoqueBaixoA = estoqueBaixo(produtoA);
                      final estoqueBaixoB = estoqueBaixo(produtoB);

                      if (estoqueBaixoA && !estoqueBaixoB) {
                        return -1;
                      }

                      if (!estoqueBaixoA && estoqueBaixoB) {
                        return 1;
                      }

                      return produtoA.nome.toLowerCase().compareTo(
                        produtoB.nome.toLowerCase(),
                      );
                    });

                if (produtos.isEmpty) {
                  return const Center(
                    child: Text(
                      'Nenhum produto cadastrado.',
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  );
                }

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                      child: TextField(
                        controller: pesquisaController,
                        decoration: InputDecoration(
                          hintText: 'Pesquisar produto...',
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: pesquisa.isEmpty
                              ? null
                              : IconButton(
                                  tooltip: 'Limpar pesquisa',
                                  onPressed: () {
                                    pesquisaController.clear();

                                    setState(() {
                                      pesquisa = '';
                                    });
                                  },
                                  icon: const Icon(Icons.close),
                                ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        onChanged: (valor) {
                          setState(() {
                            pesquisa = valor.trim();
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: produtosFiltrados.isEmpty
                          ? const Center(
                              child: Text(
                                'Nenhum produto encontrado.',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black54,
                                ),
                              ),
                            )
                          : ListView.separated(
                              padding: const EdgeInsets.fromLTRB(
                                20,
                                4,
                                20,
                                100,
                              ),
                              itemCount: produtosFiltrados.length,
                              separatorBuilder: (_, __) {
                                return const SizedBox(height: 12);
                              },
                              itemBuilder: (context, index) {
                                final produto = produtosFiltrados[index];

                                final baixo = estoqueBaixo(produto);

                                return Card(
                                  elevation: 2,
                                  clipBehavior: Clip.antiAlias,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundColor: const Color(
                                            0xFFE8EDF4,
                                          ),
                                          backgroundImage:
                                              produto.fotoPath != null &&
                                                  produto.fotoPath!.isNotEmpty
                                              ? MemoryImage(
                                                  base64Decode(
                                                    produto.fotoPath!,
                                                  ),
                                                )
                                              : null,
                                          child:
                                              produto.fotoPath == null ||
                                                  produto.fotoPath!.isEmpty
                                              ? Icon(
                                                  iconeDaCategoria(
                                                    produto.categoria,
                                                  ),
                                                  size: 32,
                                                  color: const Color(
                                                    0xFF0B1F3A,
                                                  ),
                                                )
                                              : null,
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                produto.nome,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: produto.ativo
                                                      ? Colors.black
                                                      : Colors.black38,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                '${produto.categoria} • '
                                                'R\$ ${formatarPreco(produto.precoCentavos)}',
                                                style: const TextStyle(
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Wrap(
                                                spacing: 8,
                                                runSpacing: 6,
                                                crossAxisAlignment:
                                                    WrapCrossAlignment.center,
                                                children: [
                                                  Text(
                                                    'Estoque: '
                                                    '${produto.estoqueAtual}',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: baixo
                                                          ? Colors.red
                                                          : const Color(
                                                              0xFF0B1F3A,
                                                            ),
                                                    ),
                                                  ),
                                                  if (baixo)
                                                    const Chip(
                                                      avatar: Icon(
                                                        Icons.warning_amber,
                                                        size: 18,
                                                        color: Colors.red,
                                                      ),
                                                      label: Text(
                                                        'Estoque baixo',
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          tooltip: 'Editar',
                                          onPressed: () {
                                            abrirFormulario(produto: produto);
                                          },
                                          icon: const Icon(Icons.edit),
                                        ),
                                        Switch(
                                          value: produto.ativo,
                                          onChanged: (valor) {
                                            alterarSituacao(produto, valor);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
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

class _FormularioProdutoDialog extends StatefulWidget {
  const _FormularioProdutoDialog({this.produto});

  final Produto? produto;

  @override
  State<_FormularioProdutoDialog> createState() =>
      _FormularioProdutoDialogState();
}

class _FormularioProdutoDialogState extends State<_FormularioProdutoDialog> {
  final formularioKey = GlobalKey<FormState>();

  final ImagePicker imagePicker = ImagePicker();

  late String nome;
  late String categoria;
  late String preco;
  late String estoqueInicial;
  late String estoqueAtual;
  late String? fotoPath;

  @override
  void initState() {
    super.initState();

    nome = widget.produto?.nome ?? '';

    categoria = widget.produto?.categoria ?? 'Bebidas';

    preco = widget.produto == null
        ? ''
        : (widget.produto!.precoCentavos / 100).toStringAsFixed(2);

    estoqueInicial = widget.produto?.estoqueInicial.toString() ?? '';

    estoqueAtual = widget.produto?.estoqueAtual.toString() ?? '';

    fotoPath = widget.produto?.fotoPath;
  }

  String? validarEstoque(String? valor) {
    final quantidade = int.tryParse(valor?.trim() ?? '');

    if (quantidade == null || quantidade < 0) {
      return 'Informe uma quantidade válida.';
    }

    return null;
  }

  Future<void> escolherFoto() async {
    final imagem = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
      maxWidth: 900,
    );

    if (imagem == null) {
      return;
    }

    final bytes = await imagem.readAsBytes();

    if (!mounted) {
      return;
    }

    setState(() {
      fotoPath = base64Encode(bytes);
    });
  }

  void removerFoto() {
    setState(() {
      fotoPath = null;
    });
  }

  void salvar() {
    if (formularioKey.currentState?.validate() != true) {
      return;
    }

    formularioKey.currentState?.save();

    final precoConvertido = double.parse(preco.replaceAll(',', '.'));

    final precoCentavos = (precoConvertido * 100).round();

    final estoqueInicialConvertido = int.parse(estoqueInicial);

    final estoqueAtualConvertido = widget.produto == null
        ? estoqueInicialConvertido
        : int.parse(estoqueAtual);

    Navigator.pop(
      context,
      _DadosProduto(
        nome: nome.trim(),
        categoria: categoria,
        precoCentavos: precoCentavos,
        estoqueInicial: estoqueInicialConvertido,
        estoqueAtual: estoqueAtualConvertido,
        fotoPath: fotoPath,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.produto == null ? 'Cadastrar produto' : 'Editar produto',
      ),
      content: SizedBox(
        width: 460,
        child: Form(
          key: formularioKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (fotoPath != null) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.memory(
                      base64Decode(fotoPath!),
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                      gaplessPlayback: true,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                FilledButton.icon(
                  onPressed: escolherFoto,
                  icon: const Icon(Icons.photo),
                  label: Text(
                    fotoPath == null ? 'Escolher foto' : 'Trocar foto',
                  ),
                ),
                if (fotoPath != null)
                  TextButton.icon(
                    onPressed: removerFoto,
                    icon: const Icon(Icons.delete),
                    label: const Text('Remover foto'),
                  ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: nome,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'Nome do produto',
                    prefixIcon: Icon(Icons.inventory_2),
                    border: OutlineInputBorder(),
                  ),
                  validator: (valor) {
                    if (valor == null || valor.trim().length < 2) {
                      return 'Informe o nome do produto.';
                    }

                    return null;
                  },
                  onSaved: (valor) {
                    nome = valor?.trim() ?? '';
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: categoria,
                  decoration: const InputDecoration(
                    labelText: 'Categoria',
                    prefixIcon: Icon(Icons.category),
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'Bebidas', child: Text('Bebidas')),
                    DropdownMenuItem(value: 'Doces', child: Text('Doces')),
                    DropdownMenuItem(
                      value: 'Biscoitos',
                      child: Text('Biscoitos'),
                    ),
                  ],
                  onChanged: (valor) {
                    if (valor != null) {
                      setState(() {
                        categoria = valor;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: preco,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Preço',
                    prefixText: 'R\$ ',
                    prefixIcon: Icon(Icons.attach_money),
                    border: OutlineInputBorder(),
                  ),
                  validator: (valor) {
                    final precoConvertido = double.tryParse(
                      (valor ?? '').replaceAll(',', '.'),
                    );

                    if (precoConvertido == null || precoConvertido <= 0) {
                      return 'Informe um preço válido.';
                    }

                    return null;
                  },
                  onSaved: (valor) {
                    preco = valor?.trim() ?? '';
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: estoqueInicial,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Estoque inicial',
                    prefixIcon: Icon(Icons.inventory),
                    border: OutlineInputBorder(),
                  ),
                  validator: validarEstoque,
                  onSaved: (valor) {
                    estoqueInicial = valor?.trim() ?? '';
                  },
                ),
                if (widget.produto != null) ...[
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: estoqueAtual,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Estoque atual',
                      prefixIcon: Icon(Icons.warehouse_outlined),
                      border: OutlineInputBorder(),
                    ),
                    validator: validarEstoque,
                    onSaved: (valor) {
                      estoqueAtual = valor?.trim() ?? '';
                    },
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('CANCELAR'),
        ),
        ElevatedButton(
          onPressed: salvar,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFC107),
            foregroundColor: Colors.black,
          ),
          child: const Text('SALVAR'),
        ),
      ],
    );
  }
}

class _DadosProduto {
  const _DadosProduto({
    required this.nome,
    required this.categoria,
    required this.precoCentavos,
    required this.estoqueInicial,
    required this.estoqueAtual,
    required this.fotoPath,
  });

  final String nome;
  final String categoria;
  final int precoCentavos;
  final int estoqueInicial;
  final int estoqueAtual;
  final String? fotoPath;
}
