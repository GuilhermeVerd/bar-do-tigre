import '../core/database/app_database.dart';

class RetiradaRepository {
  RetiradaRepository({AppDatabase? database})
    : _database = database ?? appDatabase;

  final AppDatabase _database;

  Future<int> registrarRetirada({
    required int usuarioId,
    required List<ItemConsumo> itens,
    DateTime? dataHora,
  }) {
    return _database.registrarRetirada(
      usuarioId: usuarioId,
      itens: itens,
      dataHora: dataHora,
    );
  }

  Stream<List<RetiradaMeuConsumo>> observarConsumoDoUsuario({
    required int usuarioId,
    required String mesReferencia,
  }) {
    return _database.observarConsumoDoUsuario(
      usuarioId: usuarioId,
      mesReferencia: mesReferencia,
    );
  }

  Stream<List<ResumoUsuarioRelatorio>> observarRelatorioMensal({
    required String mesReferencia,
  }) {
    return _database.observarRelatorioMensal(
      mesReferencia: mesReferencia,
    );
  }

  Stream<List<ResumoMesFechado>> observarHistoricoMesesFechados() {
    return _database.observarHistoricoMesesFechados();
  }

  Stream<bool> observarMesFechado({
    required String mesReferencia,
  }) {
    return _database.observarMesFechado(
      mesReferencia: mesReferencia,
    );
  }

  Future<bool> verificarMesFechado({
    required String mesReferencia,
  }) {
    return _database.verificarMesFechado(
      mesReferencia: mesReferencia,
    );
  }

  Future<void> fecharMes({
    required String mesReferencia,
  }) {
    return _database.fecharMes(
      mesReferencia: mesReferencia,
    );
  }
}