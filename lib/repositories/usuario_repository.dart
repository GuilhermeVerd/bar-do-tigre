import '../core/database/app_database.dart';

class UsuarioRepository {
  UsuarioRepository({AppDatabase? database})
    : _database = database ?? appDatabase;

  final AppDatabase _database;

  Stream<List<Usuario>> observarUsuarios() {
    return _database.observarUsuarios();
  }

  Future<List<Usuario>> listarUsuariosAtivos() {
    return _database.listarUsuariosAtivos();
  }

  Future<int> cadastrarUsuario({
    required String nome,
    required String tipo,
    required bool pinAtivo,
    String? pin,
  }) {
    return _database.cadastrarUsuario(
      nome: nome,
      tipo: tipo,
      pinAtivo: pinAtivo,
      pin: pin,
    );
  }

  Future<int> atualizarUsuario({
    required int id,
    required String nome,
    required String tipo,
    required bool pinAtivo,
    String? pin,
    required bool ativo,
  }) {
    return _database.atualizarUsuario(
      id: id,
      nome: nome,
      tipo: tipo,
      pinAtivo: pinAtivo,
      pin: pin,
      ativo: ativo,
    );
  }

  Future<int> alterarSituacaoUsuario({required int id, required bool ativo}) {
    return _database.alterarSituacaoUsuario(id: id, ativo: ativo);
  }

  Future<ResumoUsuarioRelatorio> calcularResumoMensal({
    required int usuarioId,
    required String mesReferencia,
  }) {
    return _database.calcularResumoMensal(
      usuarioId: usuarioId,
      mesReferencia: mesReferencia,
    );
  }
}
