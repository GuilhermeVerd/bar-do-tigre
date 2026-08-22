import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';

Future<void> baixarArquivoImplementacao({
  required Uint8List bytes,
  required String nomeArquivo,
  required String mimeType,
}) async {
  MimeType tipoMime;

  switch (mimeType) {
    case 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet':
      tipoMime = MimeType.microsoftExcel;
      break;
    case 'application/pdf':
      tipoMime = MimeType.pdf;
      break;
    case 'application/json':
      tipoMime = MimeType.json;
      break;
    default:
      tipoMime = MimeType.other;
  }

  final partes = nomeArquivo.split('.');
  final extensao = partes.length > 1 ? partes.last : '';
  final nomeSemExtensao = partes.length > 1
      ? partes.sublist(0, partes.length - 1).join('.')
      : nomeArquivo;

  await FileSaver.instance.saveFile(
    name: nomeSemExtensao,
    bytes: bytes,
    ext: extensao,
    mimeType: tipoMime,
  );
}
