import 'package:flutter/material.dart';

import '../../services/backup_service.dart';

class ConfiguracoesScreen extends StatefulWidget {
  const ConfiguracoesScreen({super.key});

  @override
  State<ConfiguracoesScreen> createState() => _ConfiguracoesScreenState();
}

class _ConfiguracoesScreenState extends State<ConfiguracoesScreen> {
  final BackupService backupService = BackupService();

  bool gerandoBackup = false;
  bool restaurandoBackup = false;

  bool get operacaoEmAndamento {
    return gerandoBackup || restaurandoBackup;
  }

  Future<void> gerarBackup() async {
    if (operacaoEmAndamento) {
      return;
    }

    setState(() {
      gerandoBackup = true;
    });

    try {
      await backupService.gerarBackup();

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Backup gerado com sucesso.'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (erro) {
      if (!mounted) {
        return;
      }

      _mostrarErro('Não foi possível gerar o backup: ${_limparErro(erro)}');
    } finally {
      if (mounted) {
        setState(() {
          gerandoBackup = false;
        });
      }
    }
  }

  Future<void> restaurarBackup() async {
    if (operacaoEmAndamento) {
      return;
    }

    setState(() {
      restaurandoBackup = true;
    });

    try {
      final restaurado = await backupService.restaurarBackup();

      if (!mounted) {
        return;
      }

      if (!restaurado) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Nenhum arquivo de backup foi selecionado.'),
          ),
        );
        return;
      }

      await _mostrarRestauracaoConcluida();
    } catch (erro) {
      if (!mounted) {
        return;
      }

      _mostrarErro('Não foi possível restaurar o backup: ${_limparErro(erro)}');
    } finally {
      if (mounted) {
        setState(() {
          restaurandoBackup = false;
        });
      }
    }
  }

  Future<void> confirmarGeracaoBackup() async {
    final confirmou = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.cloud_download_outlined),
              SizedBox(width: 10),
              Expanded(child: Text('Gerar backup')),
            ],
          ),
          content: const Text(
            'Será criado um arquivo contendo usuários, produtos, '
            'consumos, estoque, movimentações e fechamentos mensais.\n\n'
            'Guarde esse arquivo em um local seguro.',
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
              icon: const Icon(Icons.download),
              label: const Text('Gerar backup'),
            ),
          ],
        );
      },
    );

    if (confirmou == true) {
      await gerarBackup();
    }
  }

  Future<void> confirmarRestauracaoBackup() async {
    if (operacaoEmAndamento) {
      return;
    }

    final confirmou = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          icon: const Icon(
            Icons.warning_amber_rounded,
            size: 48,
            color: Colors.orange,
          ),
          title: const Text('Restaurar backup?', textAlign: TextAlign.center),
          content: const SizedBox(
            width: 430,
            child: Text(
              'A restauração substituirá todos os usuários, produtos, '
              'consumos, quantidades de estoque, movimentações e '
              'fechamentos atualmente salvos.\n\n'
              'Essa ação não poderá ser desfeita.\n\n'
              'Recomenda-se gerar um backup dos dados atuais antes '
              'de continuar.',
              textAlign: TextAlign.center,
              style: TextStyle(height: 1.4),
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
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.settings_backup_restore),
              label: const Text('Selecionar backup'),
            ),
          ],
        );
      },
    );

    if (confirmou == true) {
      await restaurarBackup();
    }
  }

  Future<void> _mostrarRestauracaoConcluida() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          icon: const Icon(Icons.check_circle, size: 54, color: Colors.green),
          title: const Text(
            'Restauração concluída',
            textAlign: TextAlign.center,
          ),
          content: const Text(
            'Os dados do backup foram restaurados com sucesso.\n\n'
            'As telas do aplicativo serão atualizadas automaticamente.',
            textAlign: TextAlign.center,
          ),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Concluir'),
            ),
          ],
        );
      },
    );
  }

  void _mostrarErro(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 7),
      ),
    );
  }

  String _limparErro(Object erro) {
    return erro
        .toString()
        .replaceFirst('FormatException: ', '')
        .replaceFirst('Bad state: ', '')
        .replaceFirst('StateError: ', '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        title: const Text('Configurações'),
        backgroundColor: const Color(0xFF0B1F3A),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const Text(
                  'Backup e segurança',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0B1F3A),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Proteja os dados do Bar do Tigre criando '
                  'cópias de segurança regularmente.',
                  style: TextStyle(fontSize: 17, color: Colors.black54),
                ),
                const SizedBox(height: 24),
                Card(
                  elevation: 2,
                  clipBehavior: Clip.antiAlias,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(20),
                    leading: const CircleAvatar(
                      radius: 27,
                      backgroundColor: Color(0xFFE3EDF8),
                      child: Icon(
                        Icons.cloud_download_outlined,
                        color: Color(0xFF0B1F3A),
                        size: 30,
                      ),
                    ),
                    title: const Text(
                      'Gerar backup',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: const Padding(
                      padding: EdgeInsets.only(top: 7),
                      child: Text(
                        'Salva os dados do aplicativo em um arquivo JSON.',
                      ),
                    ),
                    trailing: gerandoBackup
                        ? const SizedBox(
                            width: 26,
                            height: 26,
                            child: CircularProgressIndicator(strokeWidth: 3),
                          )
                        : const Icon(Icons.chevron_right),
                    onTap: operacaoEmAndamento ? null : confirmarGeracaoBackup,
                  ),
                ),
                const SizedBox(height: 14),
                Card(
                  elevation: 2,
                  clipBehavior: Clip.antiAlias,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(20),
                    leading: const CircleAvatar(
                      radius: 27,
                      backgroundColor: Color(0xFFFFF3E0),
                      child: Icon(
                        Icons.settings_backup_restore,
                        color: Colors.orange,
                        size: 30,
                      ),
                    ),
                    title: const Text(
                      'Restaurar backup',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: const Padding(
                      padding: EdgeInsets.only(top: 7),
                      child: Text(
                        'Substitui os dados atuais pelos dados '
                        'de um backup anterior.',
                      ),
                    ),
                    trailing: restaurandoBackup
                        ? const SizedBox(
                            width: 26,
                            height: 26,
                            child: CircularProgressIndicator(strokeWidth: 3),
                          )
                        : const Icon(Icons.chevron_right),
                    onTap: operacaoEmAndamento
                        ? null
                        : confirmarRestauracaoBackup,
                  ),
                ),
                const SizedBox(height: 24),
                Card(
                  color: const Color(0xFFFFF8E1),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Guarde o arquivo de backup em um local '
                            'seguro. Recomenda-se gerar um backup antes '
                            'do fechamento mensal, antes de restaurar '
                            'outro arquivo e antes de atualizar o aplicativo.',
                            style: TextStyle(
                              color: Colors.orange.shade900,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
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
