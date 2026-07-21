import 'dart:convert';

import 'package:flutter/material.dart';

import '../../core/database/app_database.dart';
import '../../repositories/produto_repository.dart';
import '../../repositories/retirada_repository.dart';

class ConsumoScreen extends StatefulWidget {
  const ConsumoScreen({
    super.key,
    required this.usuarioId,
    required this.nomeUsuario,
  });

  final int usuarioId;
  final String nomeUsuario;

  @override
  State<ConsumoScreen> createState() => _ConsumoScreenState();
}

class _ConsumoScreenState extends State<ConsumoScreen> {
  final ProdutoRepository produtoRepository = ProdutoRepository();
  final RetiradaRepository retiradaRepository = RetiradaRepository();

  final Map<int, int> quantidades = {};
  final Map<String, bool> categoriasExpandidas = {};

  bool registrando = false;

  int quantidadeDoProduto(int produtoId) {
    return quantidades[produtoId] ?? 0;
  }

  int calcularTotalCentavos(List<Produto> produtos) {
    var total = 0;

    for (final produto in produtos) {
      total += produto.precoCentavos * quantidadeDoProduto(produto.id);
    }

    return total;
  }

  void aumentarQuantidade(Produto produto) {
    final quantidadeAtual = quantidadeDoProduto(produto.id);

    if (quantidadeAtual >= produto.estoqueAtual) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Estoque insuficiente para ${produto.nome}.',
          ),
        ),
      );

      return;
    }

    setState(() {
      quantidades[produto.id] = quantidadeAtual + 1;
    });
  }

  void diminuirQuantidade(Produto produto) {
    final quantidadeAtual = quantidadeDoProduto(produto.id);

    if (quantidadeAtual <= 0) {
      return;
    }

    setState(() {
      final novaQuantidade = quantidadeAtual - 1;

      if (novaQuantidade == 0) {
        quantidades.remove(produto.id);
      } else {
        quantidades[produto.id] = novaQuantidade;
      }
    });
  }

  String formatarPreco(int valorCentavos) {
    final valor = valorCentavos / 100;

    return valor.toStringAsFixed(2).replaceAll('.', ',');
  }

  IconData iconeDaCategoria(String categoria) {
    switch (categoria.toLowerCase()) {
      case 'doces':
        return Icons.cake;

      case 'biscoitos':
        return Icons.cookie;

      case 'bebidas':
        return Icons.local_drink;

      default:
        return Icons.inventory_2;
    }
  }

  Map<String, List<Produto>> agruparProdutosPorCategoria(
    List<Produto> produtos,
  ) {
    final produtosPorCategoria = <String, List<Produto>>{};

    for (final produto in produtos) {
      final categoria = produto.categoria.trim().isEmpty
          ? 'Outros'
          : produto.categoria.trim();

      produtosPorCategoria.putIfAbsent(
        categoria,
        () => [],
      );

      produtosPorCategoria[categoria]!.add(produto);
    }

    for (final listaProdutos in produtosPorCategoria.values) {
      listaProdutos.sort(
        (produtoA, produtoB) => produtoA.nome.toLowerCase().compareTo(
              produtoB.nome.toLowerCase(),
            ),
      );
    }

    final categoriasOrdenadas = produtosPorCategoria.keys.toList()
      ..sort(
        (categoriaA, categoriaB) =>
            categoriaA.toLowerCase().compareTo(
                  categoriaB.toLowerCase(),
                ),
      );

    return {
      for (final categoria in categoriasOrdenadas)
        categoria: produtosPorCategoria[categoria]!,
    };
  }

  Future<void> registrarConsumo(List<Produto> produtos) async {
    if (registrando) {
      return;
    }

    final produtosSelecionados = produtos
        .where(
          (produto) => quantidadeDoProduto(produto.id) > 0,
        )
        .toList();

    if (produtosSelecionados.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Selecione pelo menos um produto.',
          ),
        ),
      );

      return;
    }

    final totalCentavos = calcularTotalCentavos(
      produtosSelecionados,
    );

    final confirmou = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Confirmar consumo'),
          content: SizedBox(
            width: 400,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Usuário: ${widget.nomeUsuario}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...produtosSelecionados.map(
                    (produto) {
                      final quantidade = quantidadeDoProduto(
                        produto.id,
                      );

                      final subtotalCentavos =
                          produto.precoCentavos * quantidade;

                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(produto.nome),
                        subtitle: Text(
                          '$quantidade unidade(s)',
                        ),
                        trailing: Text(
                          'R\$ ${formatarPreco(subtotalCentavos)}',
                        ),
                      );
                    },
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'R\$ ${formatarPreco(totalCentavos)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0B1F3A),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  false,
                );
              },
              child: const Text('CANCELAR'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  true,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFC107),
                foregroundColor: Colors.black,
              ),
              child: const Text('CONFIRMAR'),
            ),
          ],
        );
      },
    );

    if (confirmou != true || !mounted) {
      return;
    }

    final itens = produtosSelecionados.map(
      (produto) {
        return ItemConsumo(
          produtoId: produto.id,
          quantidade: quantidadeDoProduto(produto.id),
        );
      },
    ).toList();

    setState(() {
      registrando = true;
    });

    try {
      await retiradaRepository.registrarRetirada(
        usuarioId: widget.usuarioId,
        itens: itens,
      );

      if (!mounted) {
        return;
      }

      setState(() {
        quantidades.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Consumo de ${widget.nomeUsuario} registrado. '
            'Total: R\$ ${formatarPreco(totalCentavos)}',
          ),
        ),
      );
    } catch (erro) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Não foi possível registrar o consumo: $erro',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          registrando = false;
        });
      }
    }
  }

  Widget construirCardProduto(Produto produto) {
    final quantidade = quantidadeDoProduto(produto.id);

    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 34,
              backgroundColor: const Color(0xFFE8EDF4),
              backgroundImage:
                  produto.fotoPath != null && produto.fotoPath!.isNotEmpty
                      ? MemoryImage(
                          base64Decode(
                            produto.fotoPath!,
                          ),
                        )
                      : null,
              child: produto.fotoPath == null || produto.fotoPath!.isEmpty
                  ? Icon(
                      iconeDaCategoria(
                        produto.categoria,
                      ),
                      size: 40,
                      color: const Color(0xFF0B1F3A),
                    )
                  : null,
            ),
            const SizedBox(height: 12),
            Text(
              produto.nome,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'R\$ ${formatarPreco(produto.precoCentavos)}',
              style: const TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Estoque: ${produto.estoqueAtual}',
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: quantidade > 0
                      ? () {
                          diminuirQuantidade(produto);
                        }
                      : null,
                  icon: const Icon(
                    Icons.remove_circle,
                  ),
                  color: const Color(0xFF0B1F3A),
                  disabledColor: Colors.black26,
                  iconSize: 34,
                ),
                SizedBox(
                  width: 45,
                  child: Text(
                    '$quantidade',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: quantidade < produto.estoqueAtual
                      ? () {
                          aumentarQuantidade(produto);
                        }
                      : null,
                  icon: const Icon(
                    Icons.add_circle,
                  ),
                  color: const Color(0xFFFFC107),
                  disabledColor: Colors.black26,
                  iconSize: 34,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget construirCategoria({
    required String categoria,
    required List<Produto> produtos,
  }) {
    final quantidadeSelecionada = produtos.fold<int>(
      0,
      (total, produto) {
        return total + quantidadeDoProduto(produto.id);
      },
    );

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        initiallyExpanded: categoriasExpandidas[categoria] ?? true,
        onExpansionChanged: (expandida) {
          setState(() {
            categoriasExpandidas[categoria] = expandida;
          });
        },
        backgroundColor: Colors.white,
        collapsedBackgroundColor: Colors.white,
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFE8EDF4),
          child: Icon(
            iconeDaCategoria(categoria),
            color: const Color(0xFF0B1F3A),
          ),
        ),
        title: Text(
          categoria,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0B1F3A),
          ),
        ),
        subtitle: Text(
          produtos.length == 1
              ? '1 produto'
              : '${produtos.length} produtos',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (quantidadeSelecionada > 0)
              Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFC107),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$quantidadeSelecionada selecionado(s)',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            Icon(
              categoriasExpandidas[categoria] ?? true
                  ? Icons.expand_less
                  : Icons.expand_more,
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              16,
              0,
              16,
              16,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final colunas = constraints.maxWidth < 600 ? 1 : 2;

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: produtos.length,
                  gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: colunas,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: colunas == 1 ? 2 : 1.25,
                  ),
                  itemBuilder: (context, index) {
                    return construirCardProduto(
                      produtos[index],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        title: const Text('Registrar consumo'),
        backgroundColor: const Color(0xFF0B1F3A),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 900,
            ),
            child: StreamBuilder<List<Produto>>(
              stream: produtoRepository.observarProdutosAtivos(),
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
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final produtos = snapshot.data!
                    .where(
                      (produto) => produto.estoqueAtual > 0,
                    )
                    .toList();

                final produtosPorCategoria =
                    agruparProdutosPorCategoria(produtos);

                final totalCentavos = calcularTotalCentavos(
                  produtos,
                );

                final quantidadeTotalSelecionada =
                    quantidades.values.fold<int>(
                  0,
                  (total, quantidade) => total + quantidade,
                );

                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.only(
                          bottom: 16,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8EDF4),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.person,
                              color: Color(0xFF0B1F3A),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Registrando para: '
                                '${widget.nomeUsuario}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0B1F3A),
                                ),
                              ),
                            ),
                            if (quantidadeTotalSelecionada > 0)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 7,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFC107),
                                  borderRadius:
                                      BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '$quantidadeTotalSelecionada item(ns)',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: produtos.isEmpty
                            ? const Center(
                                child: Text(
                                  'Nenhum produto disponível.',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black54,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount:
                                    produtosPorCategoria.length,
                                itemBuilder: (context, index) {
                                  final categoria =
                                      produtosPorCategoria.keys
                                          .elementAt(index);

                                  final produtosDaCategoria =
                                      produtosPorCategoria[
                                          categoria]!;

                                  return construirCategoria(
                                    categoria: categoria,
                                    produtos:
                                        produtosDaCategoria,
                                  );
                                },
                              ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Total desta retirada',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              'R\$ ${formatarPreco(totalCentavos)}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0B1F3A),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 58,
                        child: ElevatedButton(
                          onPressed: produtos.isEmpty ||
                                  quantidades.isEmpty ||
                                  registrando
                              ? null
                              : () {
                                  registrarConsumo(produtos);
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFFFFC107),
                            foregroundColor: Colors.black,
                          ),
                          child: registrando
                              ? const SizedBox(
                                  width: 26,
                                  height: 26,
                                  child:
                                      CircularProgressIndicator(
                                    strokeWidth: 3,
                                  ),
                                )
                              : const Text(
                                  'CONFIRMAR CONSUMO',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}