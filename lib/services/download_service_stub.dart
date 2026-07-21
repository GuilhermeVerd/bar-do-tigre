import 'dart:typed_data';

Future<void> baixarArquivoImplementacao({
  required Uint8List bytes,
  required String nomeArquivo,
  required String mimeType,
}) async {
  throw UnsupportedError(
    'O download direto ainda não está configurado para esta plataforma.',
  );
}
