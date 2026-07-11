import 'package:flutter/material.dart';

class ConsumoScreen extends StatefulWidget {
  const ConsumoScreen({
    super.key,
    required this.nomeUsuario,
  });

  final String nomeUsuario;

  @override
  State<ConsumoScreen> createState() => _ConsumoScreenState();
}

class _ConsumoScreenState extends State<ConsumoScreen> {
  final List<Map<String, dynamic>> produtos = [
    {
      'nome': 'Coca-Cola',
      'preco': 6.00,
      'quantidade': 0,
      'icone': Icons.local_drink,
    },
    {
      'nome': 'Heineken',
      'preco': 10.00,
      'quantidade': 0,
      'icone': Icons.sports_bar,
    },
    {
      'nome': 'Snickers',
      'preco': 5.00,
      'quantidade': 0,
      'icone': Icons.cake,
    },
    {
      'nome': 'Club Social',
      'preco': 4.00,
      'quantidade': 0,
      'icone': Icons.cookie,
    },
  ];

  double get total {
    double valor = 0;

    for (final produto in produtos) {
      valor +=
          (produto['preco'] as double) * (produto['quantidade'] as int);
    }

    return valor;
  }

  void aumentarQuantidade(int index) {
    setState(() {
      produtos[index]['quantidade'] =
          (produtos[index]['quantidade'] as int) + 1;
    });
  }

  void diminuirQuantidade(int index) {
    final quantidadeAtual = produtos[index]['quantidade'] as int;

    if (quantidadeAtual > 0) {
      setState(() {
        produtos[index]['quantidade'] = quantidadeAtual - 1;
      });
    }
  }

  Future<void> registrarConsumo() async {
    if (total == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecione pelo menos um produto.'),
        ),
      );
      return;
    }

    final produtosSelecionados = produtos
        .where((produto) => (produto['quantidade'] as int) > 0)
        .toList();

    final confirmou = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Confirmar consumo'),
          content: SizedBox(
            width: 400,
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
                ...produtosSelecionados.map((produto) {
                  final quantidade = produto['quantidade'] as int;
                  final preco = produto['preco'] as double;
                  final subtotal = preco * quantidade;

                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(produto['nome'] as String),
                    subtitle: Text('$quantidade unidade(s)'),
                    trailing: Text(
                      'R\$ ${subtotal.toStringAsFixed(2)}',
                    ),
                  );
                }),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'R\$ ${total.toStringAsFixed(2)}',
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
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('CANCELAR'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
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

    final valorRegistrado = total;

    setState(() {
      for (final produto in produtos) {
        produto['quantidade'] = 0;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Consumo de ${widget.nomeUsuario} registrado. '
          'Total: R\$ ${valorRegistrado.toStringAsFixed(2)}',
        ),
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
            constraints: const BoxConstraints(maxWidth: 900),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 16),
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
                            'Registrando para: ${widget.nomeUsuario}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0B1F3A),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      itemCount: produtos.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.25,
                      ),
                      itemBuilder: (context, index) {
                        final produto = produtos[index];
                        final nome = produto['nome'] as String;
                        final preco = produto['preco'] as double;
                        final quantidade = produto['quantidade'] as int;
                        final icone = produto['icone'] as IconData;

                        return Card(
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(18),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  icone,
                                  size: 52,
                                  color: const Color(0xFF0B1F3A),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  nome,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'R\$ ${preco.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        diminuirQuantidade(index);
                                      },
                                      icon: const Icon(Icons.remove_circle),
                                      color: const Color(0xFF0B1F3A),
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
                                      onPressed: () {
                                        aumentarQuantidade(index);
                                      },
                                      icon: const Icon(Icons.add_circle),
                                      color: const Color(0xFFFFC107),
                                      iconSize: 34,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
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
                          'R\$ ${total.toStringAsFixed(2)}',
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
                      onPressed: registrarConsumo,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFC107),
                        foregroundColor: Colors.black,
                      ),
                      child: const Text(
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
            ),
          ),
        ),
      ),
    );
  }
}