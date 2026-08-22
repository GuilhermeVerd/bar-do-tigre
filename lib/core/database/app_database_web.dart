import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:sqlite3/wasm.dart';

QueryExecutor connectAppDatabase() {
  return LazyDatabase(() async {
    final sqlite3 = await WasmSqlite3.loadFromUrl(Uri.parse('sqlite3.wasm'));
    final fileSystem = await IndexedDbFileSystem.open(dbName: 'bar_do_tigre');
    sqlite3.registerVirtualFileSystem(fileSystem, makeDefault: true);
    return WasmDatabase(
      sqlite3: sqlite3,
      path: '/bar_do_tigre.sqlite',
      fileSystem: fileSystem,
    );
  });
}
