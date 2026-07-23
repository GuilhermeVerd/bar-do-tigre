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

  Future<bool> validarPin(Usuario usuario) async {
    if (!usuario.pinAtivo) {
      return true;
    }

    String pinDigitado = '';

    final autorizado = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Digite seu PIN'),
          content: SizedBox(
            width: 360,
            child: TextField(
              autofocus: true,
              obscureText: true,
              keyboardType: TextInputType.number,
              maxLength: 4,
              decoration: const InputDecoration(
                labelText: 'PIN de 4 dígitos',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
              onChanged: (valor) {
                pinDigitado = valor;
              },
              onSubmitted: (valor) {
                Navigator.pop(dialogContext, valor == usuario.pin);
              },
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
                Navigator.pop(dialogContext, pinDigitado == usuario.pin);
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

    return autorizado == true;
  }

  Future<void> continuar() async {
    final usuario = usuarioSelecionado;

    if (usuario == null) {
      return;
    }

    final autorizado = await validarPin(usuario);

    if (!mounted) {
      return;
    }

    if (!autorizado) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('PIN incorreto.')));
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            HomeScreen(usuarioId: usuario.id, nomeUsuario: usuario.nome),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        title: const Text('Identificação'),
        backgroundColor: const Color(0xFF0B1F3A),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: StreamBuilder<List<Usuario>>(
              stream: repository.observarUsuarios(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Erro ao carregar usuários:\n${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final usuariosAtivos = snapshot.data!
                    .where((usuario) => usuario.ativo)
                    .toList();

                if (usuariosAtivos.isEmpty) {
                  return const Center(
                    child: Text(
                      'Nenhum usuário ativo cadastrado.',
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  );
                }

                if (usuarioSelecionado != null &&
                    !usuariosAtivos.any(
                      (usuario) => usuario.id == usuarioSelecionado!.id,
                    )) {
                  usuarioSelecionado = null;
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.person,
                      size: 80,
                      color: Color(0xFF0B1F3A),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Quem está registrando?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0B1F3A),
                      ),
                    ),
                    const SizedBox(height: 32),
                    DropdownButtonFormField<Usuario>(
                      initialValue: usuarioSelecionado,
                      decoration: InputDecoration(
                        labelText: 'Selecione seu nome',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      items: usuariosAtivos.map((usuario) {
                        return DropdownMenuItem<Usuario>(
                          value: usuario,
                          child: Row(
                            children: [
                              Icon(
                                usuario.pinAtivo ? Icons.lock : Icons.lock_open,
                                size: 18,
                                color: const Color(0xFF0B1F3A),
                              ),
                              const SizedBox(width: 8),
                              Text(usuario.nome),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (valor) {
                        setState(() {
                          usuarioSelecionado = valor;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: usuarioSelecionado == null
                            ? null
                            : continuar,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFC107),
                          foregroundColor: Colors.black,
                        ),
                        child: const Text(
                          'CONTINUAR',
                          style: TextStyle(
                            fontSize: 18,
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
    );
  }
}
