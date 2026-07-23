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

  Future<void> gerarBackup() async {
    if (gerandoBackup) {
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

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Não foi possível gerar o backup: $erro'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          gerandoBackup = false;
        });
      }
    }
  }

  Future<void> confirmarGeracaoBackup() async {
    final confirmou = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Gerar backup'),
          content: const Text(
            'Será criado um arquivo contendo usuários, produtos, '
            'consumos, estoque, movimentações e fechamentos mensais.',
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

  void restauracaoEmDesenvolvimento() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('A restauração será implementada no próximo passo.'),
      ),
    );
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
                        'Salva todos os dados do aplicativo '
                        'em um arquivo JSON.',
                      ),
                    ),
                    trailing: gerandoBackup
                        ? const SizedBox(
                            width: 26,
                            height: 26,
                            child: CircularProgressIndicator(strokeWidth: 3),
                          )
                        : const Icon(Icons.chevron_right),
                    onTap: gerandoBackup ? null : confirmarGeracaoBackup,
                  ),
                ),
                const SizedBox(height: 14),
                Card(
                  elevation: 2,
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
                        'Recupera os dados a partir de um '
                        'arquivo de backup anterior.',
                      ),
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: restauracaoEmDesenvolvimento,
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
                            'do fechamento mensal e antes de atualizar '
                            'o aplicativo.',
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
