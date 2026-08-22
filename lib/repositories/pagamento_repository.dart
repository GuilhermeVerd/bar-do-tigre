import '../core/database/app_database.dart';

class PagamentoRepository {
  PagamentoRepository({AppDatabase? database})
    : _database = database ?? appDatabase;

  final AppDatabase _database;

  Stream<List<PagamentosMensai>> observarPagamentosPorMes({
    required String mesReferencia,
  }) {
    return _database.observarPagamentosPorMes(mesReferencia: mesReferencia);
  }

  Future<List<PagamentosMensai>> listarPagamentosPorMes({
    required String mesReferencia,
  }) {
    return _database.listarPagamentosPorMes(mesReferencia: mesReferencia);
  }

  Future<List<PagamentosMensai>> listarPagamentosPorUsuario({
    required int usuarioId,
  }) {
    return _database.listarPagamentosPorUsuario(usuarioId: usuarioId);
  }

  Future<bool> verificarPagamentoExistente({
    required int usuarioId,
    required String mesReferencia,
  }) {
    return _database.verificarPagamentoExistente(
      usuarioId: usuarioId,
      mesReferencia: mesReferencia,
    );
  }

  Future<int> registrarPagamento({
    required int usuarioId,
    required String mesReferencia,
    required int valorCentavos,
    DateTime? pagoEm,
  }) {
    return _database.registrarPagamento(
      usuarioId: usuarioId,
      mesReferencia: mesReferencia,
      valorCentavos: valorCentavos,
      pagoEm: pagoEm,
    );
  }

  Future<void> removerPagamento({required int id}) {
    return _database.removerPagamento(id: id);
  }
}
