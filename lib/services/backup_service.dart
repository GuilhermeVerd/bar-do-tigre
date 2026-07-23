import 'dart:convert';
import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';

import '../core/database/app_database.dart';

class BackupService {
  BackupService({AppDatabase? database}) : database = database ?? appDatabase;

  final AppDatabase database;

  Future<void> gerarBackup() async {
    final usuarios = await database.select(database.usuarios).get();
    final produtos = await database.select(database.produtos).get();
    final retiradas = await database.select(database.retiradas).get();
    final itensRetirada = await database.select(database.itensRetirada).get();
    final movimentacoes = await database
        .select(database.movimentacoesEstoque)
        .get();
    final fechamentos = await database
        .select(database.fechamentosMensais)
        .get();

    final agora = DateTime.now();

    final backup = <String, dynamic>{
      'aplicativo': 'Bar do Tigre',
      'versaoBackup': 1,
      'geradoEm': agora.toIso8601String(),
      'dados': {
        'usuarios': usuarios.map((item) => item.toJson()).toList(),
        'produtos': produtos.map((item) => item.toJson()).toList(),
        'retiradas': retiradas.map((item) => item.toJson()).toList(),
        'itensRetirada': itensRetirada.map((item) => item.toJson()).toList(),
        'movimentacoesEstoque': movimentacoes
            .map((item) => item.toJson())
            .toList(),
        'fechamentosMensais': fechamentos.map((item) => item.toJson()).toList(),
      },
    };

    const encoder = JsonEncoder.withIndent('  ');
    final textoJson = encoder.convert(backup);
    final bytes = Uint8List.fromList(utf8.encode(textoJson));

    final dataArquivo =
        '${agora.year}'
        '${agora.month.toString().padLeft(2, '0')}'
        '${agora.day.toString().padLeft(2, '0')}_'
        '${agora.hour.toString().padLeft(2, '0')}'
        '${agora.minute.toString().padLeft(2, '0')}';

    await FileSaver.instance.saveFile(
      name: 'backup_bar_do_tigre_$dataArquivo',
      bytes: bytes,
      fileExtension: 'json',
      mimeType: MimeType.json,
    );
  }

  Future<bool> restaurarBackup() async {
    throw UnimplementedError(
      'A restauração de backup será implementada posteriormente.',
    );
  }
}
