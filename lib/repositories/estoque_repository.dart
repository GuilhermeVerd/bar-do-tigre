import '../core/database/app_database.dart';

class EstoqueRepository {
  EstoqueRepository({AppDatabase? database})
    : _database = database ?? appDatabase;

  final AppDatabase _database;

  Stream<List<Produto>> observarProdutos() {
    return _database.observarProdutos();
  }

  Future<void> registrarEntrada({
    required int produtoId,
    required int quantidade,
    String? observacao,
  }) {
    return _database.registrarEntradaEstoque(
      produtoId: produtoId,
      quantidade: quantidade,
      observacao: observacao,
    );
  }

  Stream<List<MovimentacaoEstoqueDetalhada>> observarMovimentacoes() {
    return _database.observarMovimentacoesEstoque();
  }

  Future<void> ajustarEstoque({
    required int produtoId,
    required int novoEstoque,
    required String observacao,
  }) {
    return _database.ajustarEstoque(
      produtoId: produtoId,
      novoEstoque: novoEstoque,
      observacao: observacao,
    );
  }

  Future<int> registrarInventario({
    required String responsavel,
    required List<ItemInventarioRegistro> itens,
    String? observacao,
  }) {
    return _database.registrarInventario(
      responsavel: responsavel,
      itens: itens,
      observacao: observacao,
    );
  }
}
