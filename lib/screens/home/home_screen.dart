import 'package:flutter/material.dart';

import '../consumo/consumo_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.nomeUsuario,
  });

  final String nomeUsuario;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Bar do Tigre'),
        backgroundColor: const Color(0xFF0B1F3A),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Sair',
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Olá, $nomeUsuario!',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0B1F3A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'O que você deseja fazer?',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.5,
                      children: [
                        MenuCard(
                          titulo: 'Registrar consumo',
                          icone: Icons.shopping_cart,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ConsumoScreen(
                                  nomeUsuario: nomeUsuario,
                                ),
                              ),
                            );
                          },
                        ),
                        MenuCard(
                          titulo: 'Meu consumo',
                          icone: Icons.receipt_long,
                          onTap: () {
                            mostrarMensagem(
                              context,
                              'Meu consumo',
                            );
                          },
                        ),
                        MenuCard(
                          titulo: 'Produtos',
                          icone: Icons.inventory_2,
                          onTap: () {
                            mostrarMensagem(
                              context,
                              'Produtos',
                            );
                          },
                        ),
                        MenuCard(
                          titulo: 'Administrador',
                          icone: Icons.admin_panel_settings,
                          onTap: () {
                            mostrarMensagem(
                              context,
                              'Administrador',
                            );
                          },
                        ),
                      ],
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

  void mostrarMensagem(
    BuildContext context,
    String nomeTela,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$nomeTela será desenvolvido em breve.',
        ),
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  const MenuCard({
    super.key,
    required this.titulo,
    required this.icone,
    required this.onTap,
  });

  final String titulo;
  final IconData icone;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
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
                titulo,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}