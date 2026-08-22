import 'package:flutter/material.dart';

import '../administrador/administrador_screen.dart';
import '../consumo/consumo_screen.dart';
import '../consumo/meu_consumo_screen.dart';
import '../produtos/produtos_screen.dart';
import '../../services/preferencias_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.usuarioId,
    required this.nomeUsuario,
  });

  final int usuarioId;
  final String nomeUsuario;

  static const Color azulPrincipal = Color(0xFF0B1F3A);
  static const Color amareloDestaque = Color(0xFFFFC107);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Bar do Tigre',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: azulPrincipal,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Sair da conta',
            icon: const Icon(Icons.logout),
            onPressed: () {
              _confirmarSaida(context);
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _CabecalhoUsuario(nomeUsuario: nomeUsuario),
                  const SizedBox(height: 24),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final largura = constraints.maxWidth;

                        final quantidadeColunas = largura < 600
                            ? 1
                            : largura < 900
                            ? 2
                            : 4;

                        final proporcao = quantidadeColunas == 1
                            ? 2.6
                            : quantidadeColunas == 2
                            ? 1.35
                            : 0.78;

                        return GridView.count(
                          crossAxisCount: quantidadeColunas,
                          crossAxisSpacing: 18,
                          mainAxisSpacing: 18,
                          childAspectRatio: proporcao,
                          children: [
                            _MenuCard(
                              titulo: 'Registrar consumo',
                              subtitulo: 'Escolha produtos e quantidades',
                              icone: Icons.add_shopping_cart_outlined,
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
                            _MenuCard(
                              titulo: 'Meu consumo',
                              subtitulo: 'Consulte seu histórico mensal',
                              icone: Icons.receipt_long_outlined,
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
                            _MenuCard(
                              titulo: 'Produtos',
                              subtitulo: 'Consulte os produtos disponíveis',
                              icone: Icons.inventory_2_outlined,
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
                            _MenuCard(
                              titulo: 'Administrador',
                              subtitulo: 'Estoque, usuários e relatórios',
                              icone: Icons.admin_panel_settings_outlined,
                              destaque: true,
                              onTap: () {
                                _abrirAcessoAdministrador(context);
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

  Future<void> _confirmarSaida(BuildContext context) async {
    final sair = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Sair da conta'),
          content: Text(
            'Deseja encerrar o acesso de $nomeUsuario e voltar para a tela de login?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Cancelar'),
            ),
            FilledButton.icon(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              icon: const Icon(Icons.logout),
              label: const Text('Sair'),
            ),
          ],
        );
      },
    );

    if (sair == true && context.mounted) {
      Navigator.pop(context);
    }
  }

  Future<void> _abrirAcessoAdministrador(BuildContext context) async {
    var pinDigitado = '';
    var ocultarPin = true;

    final pinInformado = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            void confirmar() {
              Navigator.pop(dialogContext, pinDigitado.trim());
            }

            return AlertDialog(
              title: const Row(
                children: [
                  Icon(Icons.admin_panel_settings_outlined),
                  SizedBox(width: 10),
                  Expanded(child: Text('Acesso administrativo')),
                ],
              ),
              content: SizedBox(
                width: 380,
                child: TextField(
                  onChanged: (valor) {
                    pinDigitado = valor;
                  },
                  autofocus: true,
                  obscureText: ocultarPin,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: 'PIN administrativo',
                    hintText: 'Digite os 4 números',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      tooltip: ocultarPin ? 'Mostrar PIN' : 'Ocultar PIN',
                      icon: Icon(
                        ocultarPin
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () {
                        setStateDialog(() {
                          ocultarPin = !ocultarPin;
                        });
                      },
                    ),
                    border: const OutlineInputBorder(),
                  ),
                  onSubmitted: (_) {
                    confirmar();
                  },
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
                  onPressed: confirmar,
                  style: FilledButton.styleFrom(
                    backgroundColor: amareloDestaque,
                    foregroundColor: Colors.black,
                  ),
                  icon: const Icon(Icons.login),
                  label: const Text('Entrar'),
                ),
              ],
            );
          },
        );
      },
    );

    if (!context.mounted) {
      return;
    }

    if (pinInformado == null || pinInformado.isEmpty) {
      return;
    }

    final autorizado = await PreferenciasService.instancia
        .validarPinAdministrativo(pinInformado);

    if (!context.mounted) {
      return;
    }

    if (autorizado) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AdministradorScreen()),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('PIN administrativo incorreto.'),
        backgroundColor: Colors.red,
      ),
    );
  }
}

class _CabecalhoUsuario extends StatelessWidget {
  const _CabecalhoUsuario({required this.nomeUsuario});

  final String nomeUsuario;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 32,
              backgroundColor: Color(0xFFE8EDF4),
              child: Icon(
                Icons.person_outline,
                size: 36,
                color: HomeScreen.azulPrincipal,
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Olá, $nomeUsuario!',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: HomeScreen.azulPrincipal,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Selecione uma opção para continuar.',
                    style: TextStyle(fontSize: 17, color: Colors.black54),
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

class _MenuCard extends StatelessWidget {
  const _MenuCard({
    required this.titulo,
    required this.subtitulo,
    required this.icone,
    required this.onTap,
    this.destaque = false,
  });

  final String titulo;
  final String subtitulo;
  final IconData icone;
  final VoidCallback onTap;
  final bool destaque;

  @override
  Widget build(BuildContext context) {
    final corIcone = destaque
        ? const Color(0xFFFFC107)
        : HomeScreen.azulPrincipal;

    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: corIcone.withOpacity( 0.12),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(icone, size: 40, color: corIcone),
              ),
              const SizedBox(height: 12),
              Text(
                titulo,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: HomeScreen.azulPrincipal,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                subtitulo,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
