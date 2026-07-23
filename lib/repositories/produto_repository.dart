import '../core/database/app_database.dart';

class ProdutoRepository {
  ProdutoRepository({AppDatabase? database})
    : _database = database ?? appDatabase;

  final AppDatabase _database;

  Stream<List<Produto>> observarProdutos() {
    return _database.observarProdutos();
  }

  Stream<List<Produto>> observarProdutosAtivos() {
    return _database.observarProdutosAtivos();
  }

  Future<int> cadastrarProduto({
    required String nome,
    required String categoria,
    required int precoCentavos,
    required int estoqueInicial,
    String? fotoPath,
  }) {
    return _database.cadastrarProduto(
      nome: nome,
      categoria: categoria,
      precoCentavos: precoCentavos,
      estoqueInicial: estoqueInicial,
      fotoPath: fotoPath,
    );
  }

  Future<int> atualizarProduto({
    required int id,
    required String nome,
    required String categoria,
    required int precoCentavos,
    required int estoqueInicial,
    required int estoqueAtual,
    String? fotoPath,
    required bool ativo,
  }) {
    return _database.atualizarProduto(
      id: id,
      nome: nome,
      categoria: categoria,
      precoCentavos: precoCentavos,
      estoqueInicial: estoqueInicial,
      estoqueAtual: estoqueAtual,
      fotoPath: fotoPath,
      ativo: ativo,
    );
  }

  Future<int> alterarSituacaoProduto({required int id, required bool ativo}) {
    return _database.alterarSituacaoProduto(id: id, ativo: ativo);
  }
}
