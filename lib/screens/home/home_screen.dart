import 'package:flutter/material.dart';

import '../administrador/administrador_screen.dart';
import '../consumo/consumo_screen.dart';
import '../consumo/meu_consumo_screen.dart';
import '../produtos/produtos_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.usuarioId,
    required this.nomeUsuario,
  });

  final int usuarioId;
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
            constraints: const BoxConstraints(maxWidth: 900),
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
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final quantidadeColunas =
                            constraints.maxWidth < 600 ? 1 : 2;

                        return GridView.count(
                          crossAxisCount: quantidadeColunas,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio:
                              quantidadeColunas == 1 ? 2.4 : 1.5,
                          children: [
                            MenuCard(
                              titulo: 'Registrar consumo',
                              icone: Icons.shopping_cart,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ConsumoScreen(
                                      usuarioId: usuarioId,
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MeuConsumoScreen(
                                      usuarioId: usuarioId,
                                      nomeUsuario: nomeUsuario,
                                    ),
                                  ),
                                );
                              },
                            ),
                            MenuCard(
                              titulo: 'Produtos',
                              icone: Icons.inventory_2,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ProdutosScreen(),
                                  ),
                                );
                              },
                            ),
                            MenuCard(
                              titulo: 'Administrador',
                              icone: Icons.admin_panel_settings,
                              onTap: () {
                                abrirAcessoAdministrador(context);
                              },
                            ),
                          ],
                        );
                      },
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

  Future<void> abrirAcessoAdministrador(
    BuildContext context,
  ) async {
    String pinDigitado = '';

    final autorizado = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Acesso administrativo'),
          content: SizedBox(
            width: 360,
            child: TextField(
              autofocus: true,
              obscureText: true,
              keyboardType: TextInputType.number,
              maxLength: 4,
              decoration: const InputDecoration(
                labelText: 'Digite o PIN',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
              onChanged: (valor) {
                pinDigitado = valor;
              },
              onSubmitted: (valor) {
                Navigator.pop(
                  dialogContext,
                  valor == '1234',
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('CANCELAR'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  pinDigitado == '1234',
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFC107),
                foregroundColor: Colors.black,
              ),
              child: const Text('ENTRAR'),
            ),
          ],
        );
      },
    );

    if (!context.mounted) {
      return;
    }

    if (autorizado == true) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AdministradorScreen(),
        ),
      );
    } else if (autorizado == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('PIN administrativo incorreto.'),
        ),
      );
    }
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