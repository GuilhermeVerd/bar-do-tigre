import 'package:flutter/material.dart';

import '../../core/database/app_database.dart';
import '../../repositories/usuario_repository.dart';

class UsuariosScreen extends StatefulWidget {
  const UsuariosScreen({super.key});

  @override
  State<UsuariosScreen> createState() => _UsuariosScreenState();
}

class _UsuariosScreenState extends State<UsuariosScreen> {
  final UsuarioRepository repository = UsuarioRepository();

  Future<void> abrirFormulario({Usuario? usuario}) async {
    final resultado = await showDialog<_DadosUsuario>(
      context: context,
      builder: (dialogContext) {
        return _FormularioUsuarioDialog(usuario: usuario);
      },
    );

    if (resultado == null || !mounted) {
      return;
    }

    try {
      if (usuario == null) {
        await repository.cadastrarUsuario(
          nome: resultado.nome,
          tipo: resultado.tipo,
          pinAtivo: resultado.pinAtivo,
          pin: resultado.pin,
        );
      } else {
        await repository.atualizarUsuario(
          id: usuario.id,
          nome: resultado.nome,
          tipo: resultado.tipo,
          pinAtivo: resultado.pinAtivo,
          pin: resultado.pin,
          ativo: usuario.ativo,
        );
      }

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            usuario == null
                ? 'Usuário cadastrado com sucesso.'
                : 'Usuário atualizado com sucesso.',
          ),
        ),
      );
    } catch (erro) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Não foi possível salvar o usuário: $erro')),
      );
    }
  }

  Future<void> alterarSituacao(Usuario usuario, bool ativo) async {
    try {
      await repository.alterarSituacaoUsuario(id: usuario.id, ativo: ativo);
    } catch (erro) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Não foi possível alterar o usuário: $erro')),
      );
    }
  }

  String formatarTipo(String tipo) {
    switch (tipo.toLowerCase()) {
      case 'oficial':
        return 'Oficial';
      case 'convidado':
        return 'Convidado';
      default:
        return tipo;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Usuários'),
        backgroundColor: const Color(0xFF0B1F3A),
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          abrirFormulario();
        },
        backgroundColor: const Color(0xFFFFC107),
        foregroundColor: Colors.black,
        icon: const Icon(Icons.person_add),
        label: const Text('NOVO USUÁRIO'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: StreamBuilder<List<Usuario>>(
            stream: repository.observarUsuarios(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      'Erro ao carregar usuários:\n${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }

              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final usuarios = snapshot.data!;

              if (usuarios.isEmpty) {
                return const Center(
                  child: Text(
                    'Nenhum usuário cadastrado.',
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                itemCount: usuarios.length,
                separatorBuilder: (_, _) {
                  return const SizedBox(height: 12);
                },
                itemBuilder: (context, index) {
                  final usuario = usuarios[index];

                  return Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: const Color(0xFFE8EDF4),
                            child: Icon(
                              usuario.tipo == 'oficial'
                                  ? Icons.military_tech
                                  : Icons.person,
                              color: const Color(0xFF0B1F3A),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  usuario.nome,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: usuario.ativo
                                        ? Colors.black
                                        : Colors.black38,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  formatarTipo(usuario.tipo),
                                  style: const TextStyle(color: Colors.black54),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Icon(
                                      usuario.pinAtivo
                                          ? Icons.lock
                                          : Icons.lock_open,
                                      size: 18,
                                      color: usuario.pinAtivo
                                          ? const Color(0xFF0B1F3A)
                                          : Colors.black38,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      usuario.pinAtivo
                                          ? 'PIN habilitado'
                                          : 'Sem PIN',
                                      style: const TextStyle(
                                        color: Colors.black54,
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
                              abrirFormulario(usuario: usuario);
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          Switch(
                            value: usuario.ativo,
                            onChanged: (valor) {
                              alterarSituacao(usuario, valor);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _FormularioUsuarioDialog extends StatefulWidget {
  const _FormularioUsuarioDialog({this.usuario});

  final Usuario? usuario;

  @override
  State<_FormularioUsuarioDialog> createState() =>
      _FormularioUsuarioDialogState();
}

class _FormularioUsuarioDialogState extends State<_FormularioUsuarioDialog> {
  final formularioKey = GlobalKey<FormState>();

  late String nome;
  late String tipo;
  late String pin;
  late bool pinAtivo;

  @override
  void initState() {
    super.initState();

    nome = widget.usuario?.nome ?? '';
    tipo = widget.usuario?.tipo ?? 'oficial';
    pin = widget.usuario?.pin ?? '';
    pinAtivo = widget.usuario?.pinAtivo ?? false;
  }

  void salvar() {
    if (formularioKey.currentState?.validate() != true) {
      return;
    }

    formularioKey.currentState?.save();

    Navigator.pop(
      context,
      _DadosUsuario(
        nome: nome.trim(),
        tipo: tipo,
        pinAtivo: pinAtivo,
        pin: pinAtivo ? pin : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.usuario == null ? 'Cadastrar usuário' : 'Editar usuário',
      ),
      content: SizedBox(
        width: 460,
        child: Form(
          key: formularioKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: nome,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: (valor) {
                    if (valor == null || valor.trim().length < 2) {
                      return 'Informe um nome válido.';
                    }

                    return null;
                  },
                  onSaved: (valor) {
                    nome = valor?.trim() ?? '';
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: tipo,
                  decoration: const InputDecoration(
                    labelText: 'Tipo',
                    prefixIcon: Icon(Icons.badge),
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'oficial', child: Text('Oficial')),
                    DropdownMenuItem(
                      value: 'convidado',
                      child: Text('Convidado'),
                    ),
                  ],
                  onChanged: (valor) {
                    if (valor != null) {
                      setState(() {
                        tipo = valor;
                      });
                    }
                  },
                ),
                const SizedBox(height: 12),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Usar PIN'),
                  subtitle: const Text('Exigir PIN para acessar este usuário'),
                  value: pinAtivo,
                  onChanged: (valor) {
                    setState(() {
                      pinAtivo = valor;

                      if (!pinAtivo) {
                        pin = '';
                      }
                    });
                  },
                ),
                if (pinAtivo) ...[
                  const SizedBox(height: 12),
                  TextFormField(
                    initialValue: pin,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    decoration: const InputDecoration(
                      labelText: 'PIN de 4 dígitos',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                    validator: (valor) {
                      if (!pinAtivo) {
                        return null;
                      }

                      if (valor == null ||
                          !RegExp(r'^\d{4}$').hasMatch(valor)) {
                        return 'Informe exatamente 4 números.';
                      }

                      return null;
                    },
                    onSaved: (valor) {
                      pin = valor ?? '';
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

class _DadosUsuario {
  const _DadosUsuario({
    required this.nome,
    required this.tipo,
    required this.pinAtivo,
    required this.pin,
  });

  final String nome;
  final String tipo;
  final bool pinAtivo;
  final String? pin;
}
