import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

QueryExecutor connectAppDatabase() {
  return DatabaseConnection.delayed(Future(() async {
    try {
      final result = await WasmDatabase.open(
        databaseName: 'bar_do_tigre',
        sqlite3Uri: Uri.parse('sqlite3.wasm'),
        driftWorkerUri: Uri.parse('drift_worker.dart.js'),
      );

      if (result.missingFeatures.isNotEmpty) {
        // ignore: avoid_print
        print('Using ${result.chosenImplementation} due to missing features: ${result.missingFeatures}');
      }

      return result.resolvedExecutor;
    } catch (e, st) {
      // ignore: avoid_print
      print('Erro ao abrir banco Web: $e\n$st');
      throw Exception('Falha ao inicializar persistencia local: $e');
    }
  }));
}
