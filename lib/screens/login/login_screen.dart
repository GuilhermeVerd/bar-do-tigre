import 'package:flutter/material.dart';
import '../home/home_screen.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? usuarioSelecionado;

  final List<String> usuarios = [
    'Guilherme',
    'Oficial 2',
    'Oficial 3',
    'Convidado',
  ];

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
            child: Column(
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
                DropdownButtonFormField<String>(
                 initialValue: usuarioSelecionado,
                  decoration: InputDecoration(
                    labelText: 'Selecione seu nome',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  items: usuarios.map((usuario) {
                    return DropdownMenuItem<String>(
                      value: usuario,
                      child: Text(usuario),
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
    : () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(
              nomeUsuario: usuarioSelecionado!,
            ),
          ),
        );
      },
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
            ),
          ),
        ),
      ),
    );
  }
}