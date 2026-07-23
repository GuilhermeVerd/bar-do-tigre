import 'package:flutter/material.dart';

import '../../core/database/app_database.dart';
import '../../repositories/usuario_repository.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final UsuarioRepository repository = UsuarioRepository();

  Usuario? usuarioSelecionado;
  bool entrando = false;

  static const Color azulPrincipal = Color(0xFF0B1F3A);
  static const Color amareloDestaque = Color(0xFFFFC107);

  Future<bool> validarPin(Usuario usuario) async {
    if (!usuario.pinAtivo) {
      return true;
    }

    final controladorPin = TextEditingController();
    var ocultarPin = true;

    final autorizado = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            void verificarPin() {
              final pinDigitado = controladorPin.text.trim();

              Navigator.pop(dialogContext, pinDigitado == usuario.pin);
            }

            return AlertDialog(
              title: const Row(
                children: [
                  Icon(Icons.lock_outline),
                  SizedBox(width: 10),
                  Expanded(child: Text('Confirmação de identidade')),
                ],
              ),
              content: SizedBox(
                width: 380,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Olá, ${usuario.nome}. Digite seu PIN para continuar.',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: controladorPin,
                      autofocus: true,
                      obscureText: ocultarPin,
                      keyboardType: TextInputType.number,
                      maxLength: 4,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        labelText: 'PIN de 4 dígitos',
                        prefixIcon: const Icon(Icons.password_outlined),
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
                        verificarPin();
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext, false);
                  },
                  child: const Text('Cancelar'),
                ),
                FilledButton.icon(
                  onPressed: verificarPin,
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

    controladorPin.dispose();

    return autorizado == true;
  }

  Future<void> continuar() async {
    final usuario = usuarioSelecionado;

    if (usuario == null || entrando) {
      return;
    }

    setState(() {
      entrando = true;
    });

    try {
      final autorizado = await validarPin(usuario);

      if (!mounted) {
        return;
      }

      if (!autorizado) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PIN incorreto ou acesso cancelado.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              HomeScreen(usuarioId: usuario.id, nomeUsuario: usuario.nome),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          entrando = false;
        });
      }
    }
  }

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
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Card(
                elevation: 4,
                clipBehavior: Clip.antiAlias,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 36,
                  ),
                  child: StreamBuilder<List<Usuario>>(
                    stream: repository.observarUsuarios(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return _MensagemLogin(
                          icone: Icons.error_outline,
                          titulo: 'Não foi possível carregar os usuários',
                          mensagem: '${snapshot.error}',
                          corIcone: Colors.red,
                        );
                      }

                      if (!snapshot.hasData) {
                        return const SizedBox(
                          height: 320,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      final usuariosAtivos = snapshot.data!
                          .where((usuario) => usuario.ativo)
                          .toList();

                      if (usuariosAtivos.isEmpty) {
                        return const _MensagemLogin(
                          icone: Icons.person_off_outlined,
                          titulo: 'Nenhum usuário ativo',
                          mensagem:
                              'Peça ao administrador para cadastrar ou ativar um usuário.',
                          corIcone: Colors.black54,
                        );
                      }

                      if (usuarioSelecionado != null &&
                          !usuariosAtivos.any(
                            (usuario) => usuario.id == usuarioSelecionado!.id,
                          )) {
                        usuarioSelecionado = null;
                      }

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: azulPrincipal.withValues(alpha: 0.10),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.person_outline,
                              size: 58,
                              color: azulPrincipal,
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Identificação',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: azulPrincipal,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Selecione seu nome para acessar o Bar do Tigre.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.black54,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 32),
                          DropdownButtonFormField<Usuario>(
                            initialValue: usuarioSelecionado,
                            isExpanded: true,
                            decoration: InputDecoration(
                              labelText: 'Usuário',
                              hintText: 'Selecione seu nome',
                              prefixIcon: const Icon(Icons.badge_outlined),
                              filled: true,
                              fillColor: const Color(0xFFF8F9FA),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                  color: Color(0xFFD5DCE5),
                                ),
                              ),
                            ),
                            items: usuariosAtivos.map((usuario) {
                              return DropdownMenuItem<Usuario>(
                                value: usuario,
                                child: Row(
                                  children: [
                                    Icon(
                                      usuario.pinAtivo
                                          ? Icons.lock_outline
                                          : Icons.lock_open_outlined,
                                      size: 19,
                                      color: azulPrincipal,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        usuario.nome,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: entrando
                                ? null
                                : (valor) {
                                    setState(() {
                                      usuarioSelecionado = valor;
                                    });
                                  },
                          ),
                          if (usuarioSelecionado != null) ...[
                            const SizedBox(height: 14),
                            Row(
                              children: [
                                Icon(
                                  usuarioSelecionado!.pinAtivo
                                      ? Icons.verified_user_outlined
                                      : Icons.info_outline,
                                  size: 18,
                                  color: Colors.black54,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    usuarioSelecionado!.pinAtivo
                                        ? 'Este usuário possui proteção por PIN.'
                                        : 'Este usuário não exige PIN.',
                                    style: const TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                          const SizedBox(height: 28),
                          SizedBox(
                            width: double.infinity,
                            height: 58,
                            child: FilledButton.icon(
                              onPressed: usuarioSelecionado == null || entrando
                                  ? null
                                  : continuar,
                              style: FilledButton.styleFrom(
                                backgroundColor: amareloDestaque,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              icon: entrando
                                  ? const SizedBox(
                                      width: 22,
                                      height: 22,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        color: Colors.black,
                                      ),
                                    )
                                  : const Icon(Icons.login),
                              label: Text(
                                entrando ? 'ENTRANDO...' : 'CONTINUAR',
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MensagemLogin extends StatelessWidget {
  const _MensagemLogin({
    required this.icone,
    required this.titulo,
    required this.mensagem,
    required this.corIcone,
  });

  final IconData icone;
  final String titulo;
  final String mensagem;
  final Color corIcone;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icone, size: 64, color: corIcone),
            const SizedBox(height: 18),
            Text(
              titulo,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              mensagem,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
