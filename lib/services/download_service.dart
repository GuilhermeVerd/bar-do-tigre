import 'dart:typed_data';

import 'download_service_stub.dart'
    if (dart.library.html) 'download_service_web.dart';

class DownloadService {
  const DownloadService._();

  static Future<void> baixarArquivo({
    required Uint8List bytes,
    required String nomeArquivo,
    required String mimeType,
  }) {
    return baixarArquivoImplementacao(
      bytes: bytes,
      nomeArquivo: nomeArquivo,
      mimeType: mimeType,
    );
  }
}
