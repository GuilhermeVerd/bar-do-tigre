import 'package:drift/drift.dart';

import 'app_database_native.dart'
    if (dart.library.js) 'app_database_web.dart';

part 'app_database.g.dart';

final appDatabase = AppDatabase();

class ItemConsumo {
  const ItemConsumo({required this.produtoId, required this.quantidade});

  final int produtoId;
  final int quantidade;
}

class ItemInventarioRegistro {
  const ItemInventarioRegistro({
    required this.produtoId,
    required this.estoqueContado,
  });

  final int produtoId;
  final int estoqueContado;
}

class ItemMeuConsumo {
  const ItemMeuConsumo({
    required this.nomeProduto,
    required this.quantidade,
    required this.subtotalCentavos,
  });

  final String nomeProduto;
  final int quantidade;
  final int subtotalCentavos;
}

class RetiradaMeuConsumo {
  const RetiradaMeuConsumo({
    required this.id,
    required this.dataHora,
    required this.totalCentavos,
    required this.fechada,
    required this.itens,
  });

  final int id;
  final DateTime dataHora;
  final int totalCentavos;
  final bool fechada;
  final List<ItemMeuConsumo> itens;
}

class ResumoUsuarioRelatorio {
  const ResumoUsuarioRelatorio({
    required this.usuarioId,
    required this.nomeUsuario,
    required this.quantidadeRetiradas,
    required this.totalCentavos,
  });

  final int usuarioId;
  final String nomeUsuario;
  final int quantidadeRetiradas;
  final int totalCentavos;
}

class ResumoMesFechado {
  const ResumoMesFechado({
    required this.mesReferencia,
    required this.fechadoEm,
    required this.totalCentavos,
    required this.quantidadeRetiradas,
    required this.quantidadeUsuarios,
  });

  final String mesReferencia;
  final DateTime fechadoEm;
  final int totalCentavos;
  final int quantidadeRetiradas;
  final int quantidadeUsuarios;
}

class MovimentacaoEstoqueDetalhada {
  const MovimentacaoEstoqueDetalhada({
    required this.id,
    required this.produtoId,
    required this.nomeProduto,
    required this.tipo,
    required this.quantidade,
    required this.estoqueAnterior,
    required this.estoquePosterior,
    required this.dataHora,
    this.nomeUsuario,
    this.observacao,
  });

  final int id;
  final int produtoId;
  final String nomeProduto;
  final String tipo;
  final int quantidade;
  final int estoqueAnterior;
  final int estoquePosterior;
  final DateTime dataHora;
  final String? nomeUsuario;
  final String? observacao;
}

class _ItemConsumoValidado {
  const _ItemConsumoValidado({
    required this.produto,
    required this.quantidade,
    required this.subtotalCentavos,
  });

  final Produto produto;
  final int quantidade;
  final int subtotalCentavos;
}

class Usuarios extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get nome => text().withLength(min: 2, max: 100)();

  TextColumn get tipo => text().withDefault(const Constant('oficial'))();

  TextColumn get pin => text().nullable()();

  BoolColumn get pinAtivo => boolean().withDefault(const Constant(false))();

  BoolColumn get ativo => boolean().withDefault(const Constant(true))();

  DateTimeColumn get criadoEm => dateTime().withDefault(currentDateAndTime)();
}

class Produtos extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get nome => text().withLength(min: 2, max: 100)();

  TextColumn get categoria => text().withLength(min: 2, max: 50)();

  IntColumn get precoCentavos => integer()();

  IntColumn get estoqueInicial => integer()();

  IntColumn get estoqueAtual => integer()();

  TextColumn get fotoPath => text().nullable()();

  BoolColumn get ativo => boolean().withDefault(const Constant(true))();

  DateTimeColumn get criadoEm => dateTime().withDefault(currentDateAndTime)();
}

class Retiradas extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get usuarioId => integer().references(Usuarios, #id)();

  IntColumn get totalCentavos => integer()();

  DateTimeColumn get dataHora => dateTime().withDefault(currentDateAndTime)();

  TextColumn get mesReferencia => text()();

  BoolColumn get fechada => boolean().withDefault(const Constant(false))();
}

class ItensRetirada extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get retiradaId =>
      integer().references(Retiradas, #id, onDelete: KeyAction.cascade)();

  IntColumn get produtoId => integer().references(Produtos, #id)();

  TextColumn get nomeProduto => text()();

  IntColumn get quantidade => integer()();

  IntColumn get precoUnitarioCentavos => integer()();

  IntColumn get subtotalCentavos => integer()();
}

class MovimentacoesEstoque extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get produtoId => integer().references(Produtos, #id)();

  IntColumn get usuarioId => integer().nullable().references(Usuarios, #id)();

  IntColumn get retiradaId => integer().nullable().references(
    Retiradas,
    #id,
    onDelete: KeyAction.setNull,
  )();

  TextColumn get tipo => text().withLength(min: 3, max: 20)();

  IntColumn get quantidade => integer()();

  IntColumn get estoqueAnterior => integer()();

  IntColumn get estoquePosterior => integer()();

  TextColumn get observacao => text().nullable()();

  DateTimeColumn get dataHora => dateTime().withDefault(currentDateAndTime)();
}

class FechamentosMensais extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get mesReferencia => text().unique()();

  DateTimeColumn get fechadoEm => dateTime().withDefault(currentDateAndTime)();
}

class PagamentosMensais extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get usuarioId => integer().references(Usuarios, #id)();

  TextColumn get mesReferencia => text()();

  IntColumn get valorCentavos => integer()();

  DateTimeColumn get pagoEm => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {usuarioId, mesReferencia},
  ];
}

class Inventarios extends Table {
  IntColumn get id => integer().autoIncrement()();

  DateTimeColumn get dataHora => dateTime().withDefault(currentDateAndTime)();

  TextColumn get responsavel => text().withLength(min: 2, max: 100)();

  IntColumn get quantidadeProdutos => integer()();

  IntColumn get quantidadeDiferencas => integer()();

  TextColumn get observacao => text().nullable()();
}

class ItensInventario extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get inventarioId =>
      integer().references(Inventarios, #id, onDelete: KeyAction.cascade)();

  IntColumn get produtoId => integer().references(Produtos, #id)();

  TextColumn get nomeProduto => text()();

  IntColumn get estoqueSistema => integer()();

  IntColumn get estoqueContado => integer()();

  IntColumn get diferenca => integer()();
}

@DriftDatabase(
  tables: [
    Usuarios,
    Produtos,
    Retiradas,
    ItensRetirada,
    MovimentacoesEstoque,
    FechamentosMensais,
    PagamentosMensais,
    Inventarios,
    ItensInventario,
  ],
)
final class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? connectAppDatabase());

  @override
  int get schemaVersion => 5;
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (migrator) async {
        await migrator.createAll();

        await batch((batch) {
          batch.insertAll(usuarios, [
            UsuariosCompanion.insert(
              nome: 'Guilherme',
              tipo: const Value('oficial'),
            ),
            UsuariosCompanion.insert(
              nome: 'Oficial 2',
              tipo: const Value('oficial'),
            ),
            UsuariosCompanion.insert(
              nome: 'Oficial 3',
              tipo: const Value('oficial'),
            ),
            UsuariosCompanion.insert(
              nome: 'Convidado',
              tipo: const Value('convidado'),
            ),
          ]);

          batch.insertAll(produtos, [
            ProdutosCompanion.insert(
              nome: 'Coca-Cola',
              categoria: 'Bebidas',
              precoCentavos: 600,
              estoqueInicial: 100,
              estoqueAtual: 100,
            ),
            ProdutosCompanion.insert(
              nome: 'Heineken',
              categoria: 'Bebidas',
              precoCentavos: 1000,
              estoqueInicial: 100,
              estoqueAtual: 100,
            ),
            ProdutosCompanion.insert(
              nome: 'Snickers',
              categoria: 'Doces',
              precoCentavos: 500,
              estoqueInicial: 50,
              estoqueAtual: 50,
            ),
            ProdutosCompanion.insert(
              nome: 'Club Social',
              categoria: 'Biscoitos',
              precoCentavos: 400,
              estoqueInicial: 50,
              estoqueAtual: 50,
            ),
          ]);
        });
      },
      onUpgrade: (migrator, de, para) async {
        if (de < 2) {
          await migrator.createTable(movimentacoesEstoque);
        }
        if (de < 3) {
          await migrator.createTable(fechamentosMensais);
        }
        if (de < 4) {
          await migrator.createTable(inventarios);
          await migrator.createTable(itensInventario);
        }
        if (de < 5) {
          await migrator.createTable(pagamentosMensais);
        }
      },
    );
  }

  // USUÁRIOS

  Stream<List<Usuario>> observarUsuarios() {
    return (select(
      usuarios,
    )..orderBy([(tabela) => OrderingTerm.asc(tabela.nome)])).watch();
  }

  Future<List<Usuario>> listarUsuariosAtivos() {
    return (select(usuarios)
          ..where((tabela) => tabela.ativo.equals(true))
          ..orderBy([(tabela) => OrderingTerm.asc(tabela.nome)]))
        .get();
  }

  Future<int> cadastrarUsuario({
    required String nome,
    required String tipo,
    required bool pinAtivo,
    String? pin,
  }) {
    return into(usuarios).insert(
      UsuariosCompanion.insert(
        nome: nome,
        tipo: Value(tipo),
        pinAtivo: Value(pinAtivo),
        pin: Value(pinAtivo ? pin : null),
      ),
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
    return (update(usuarios)..where((tabela) => tabela.id.equals(id))).write(
      UsuariosCompanion(
        nome: Value(nome),
        tipo: Value(tipo),
        pinAtivo: Value(pinAtivo),
        pin: Value(pinAtivo ? pin : null),
        ativo: Value(ativo),
      ),
    );
  }

  Future<int> alterarSituacaoUsuario({required int id, required bool ativo}) {
    return (update(usuarios)..where((tabela) => tabela.id.equals(id))).write(
      UsuariosCompanion(ativo: Value(ativo)),
    );
  }

  // PRODUTOS

  Stream<List<Produto>> observarProdutos() {
    return (select(
      produtos,
    )..orderBy([(tabela) => OrderingTerm.asc(tabela.nome)])).watch();
  }

  Stream<List<Produto>> observarProdutosAtivos() {
    return (select(produtos)
          ..where((tabela) => tabela.ativo.equals(true))
          ..orderBy([(tabela) => OrderingTerm.asc(tabela.nome)]))
        .watch();
  }

  Future<int> cadastrarProduto({
    required String nome,
    required String categoria,
    required int precoCentavos,
    required int estoqueInicial,
    String? fotoPath,
  }) {
    return into(produtos).insert(
      ProdutosCompanion.insert(
        nome: nome,
        categoria: categoria,
        precoCentavos: precoCentavos,
        estoqueInicial: estoqueInicial,
        estoqueAtual: estoqueInicial,
        fotoPath: Value(fotoPath),
      ),
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
    return (update(produtos)..where((tabela) => tabela.id.equals(id))).write(
      ProdutosCompanion(
        nome: Value(nome),
        categoria: Value(categoria),
        precoCentavos: Value(precoCentavos),
        estoqueInicial: Value(estoqueInicial),
        estoqueAtual: Value(estoqueAtual),
        fotoPath: Value(fotoPath),
        ativo: Value(ativo),
      ),
    );
  }

  Future<int> alterarSituacaoProduto({required int id, required bool ativo}) {
    return (update(produtos)..where((tabela) => tabela.id.equals(id))).write(
      ProdutosCompanion(ativo: Value(ativo)),
    );
  }

  // RETIRADAS E CONSUMOS

  Future<int> registrarRetirada({
    required int usuarioId,
    required List<ItemConsumo> itens,
    DateTime? dataHora,
  }) {
    return transaction(() async {
      if (itens.isEmpty) {
        throw ArgumentError('A retirada deve possuir pelo menos um item.');
      }

      final usuario =
          await (select(usuarios)..where(
                (tabela) =>
                    tabela.id.equals(usuarioId) & tabela.ativo.equals(true),
              ))
              .getSingleOrNull();

      if (usuario == null) {
        throw StateError('Usuário inexistente ou inativo.');
      }

      final itensValidados = <_ItemConsumoValidado>[];
      var totalCentavos = 0;

      for (final item in itens) {
        if (item.quantidade <= 0) {
          throw ArgumentError(
            'A quantidade dos produtos deve ser maior que zero.',
          );
        }

        final produto =
            await (select(produtos)
                  ..where((tabela) => tabela.id.equals(item.produtoId)))
                .getSingleOrNull();

        if (produto == null) {
          throw StateError('Produto de ID ${item.produtoId} não encontrado.');
        }

        if (!produto.ativo) {
          throw StateError('O produto ${produto.nome} está inativo.');
        }

        if (produto.estoqueAtual < item.quantidade) {
          throw StateError(
            'Estoque insuficiente para ${produto.nome}. '
            'Disponível: ${produto.estoqueAtual}.',
          );
        }

        final subtotalCentavos = produto.precoCentavos * item.quantidade;

        totalCentavos += subtotalCentavos;

        itensValidados.add(
          _ItemConsumoValidado(
            produto: produto,
            quantidade: item.quantidade,
            subtotalCentavos: subtotalCentavos,
          ),
        );
      }

      final momentoRegistro = dataHora ?? DateTime.now();

      final mesReferencia =
          '${momentoRegistro.year}-'
          '${momentoRegistro.month.toString().padLeft(2, '0')}';
      final mesEstaFechado = await verificarMesFechado(
        mesReferencia: mesReferencia,
      );

      if (mesEstaFechado) {
        throw StateError(
          'Não é possível registrar consumo. '
          'O mês $mesReferencia já foi fechado.',
        );
      }

      final retiradaId = await into(retiradas).insert(
        RetiradasCompanion.insert(
          usuarioId: usuarioId,
          totalCentavos: totalCentavos,
          dataHora: Value(momentoRegistro),
          mesReferencia: mesReferencia,
        ),
      );

      for (final item in itensValidados) {
        await into(itensRetirada).insert(
          ItensRetiradaCompanion.insert(
            retiradaId: retiradaId,
            produtoId: item.produto.id,
            nomeProduto: item.produto.nome,
            quantidade: item.quantidade,
            precoUnitarioCentavos: item.produto.precoCentavos,
            subtotalCentavos: item.subtotalCentavos,
          ),
        );

        final estoqueAnterior = item.produto.estoqueAtual;

        final novoEstoque = estoqueAnterior - item.quantidade;

        await (update(produtos)
              ..where((tabela) => tabela.id.equals(item.produto.id)))
            .write(ProdutosCompanion(estoqueAtual: Value(novoEstoque)));

        await into(movimentacoesEstoque).insert(
          MovimentacoesEstoqueCompanion.insert(
            produtoId: item.produto.id,
            usuarioId: Value(usuarioId),
            retiradaId: Value(retiradaId),
            tipo: 'saida',
            quantidade: item.quantidade,
            estoqueAnterior: estoqueAnterior,
            estoquePosterior: novoEstoque,
            observacao: const Value('Saída registrada por consumo.'),
            dataHora: Value(momentoRegistro),
          ),
        );
      }

      return retiradaId;
    });
  }

  Stream<List<RetiradaMeuConsumo>> observarConsumoDoUsuario({
    required int usuarioId,
    required String mesReferencia,
  }) {
    final consulta = select(retiradas)
      ..where(
        (tabela) =>
            tabela.usuarioId.equals(usuarioId) &
            tabela.mesReferencia.equals(mesReferencia),
      )
      ..orderBy([(tabela) => OrderingTerm.desc(tabela.dataHora)]);

    return consulta.watch().asyncMap((listaRetiradas) async {
      final resultado = <RetiradaMeuConsumo>[];

      for (final retirada in listaRetiradas) {
        final itens =
            await (select(itensRetirada)
                  ..where((tabela) => tabela.retiradaId.equals(retirada.id))
                  ..orderBy([(tabela) => OrderingTerm.asc(tabela.id)]))
                .get();

        resultado.add(
          RetiradaMeuConsumo(
            id: retirada.id,
            dataHora: retirada.dataHora,
            totalCentavos: retirada.totalCentavos,
            fechada: retirada.fechada,
            itens: itens.map((item) {
              return ItemMeuConsumo(
                nomeProduto: item.nomeProduto,
                quantidade: item.quantidade,
                subtotalCentavos: item.subtotalCentavos,
              );
            }).toList(),
          ),
        );
      }

      return resultado;
    });
  }

  Stream<List<ResumoUsuarioRelatorio>> observarRelatorioMensal({
    required String mesReferencia,
  }) {
    final consulta =
        select(retiradas).join([
            innerJoin(usuarios, usuarios.id.equalsExp(retiradas.usuarioId)),
          ])
          ..where(retiradas.mesReferencia.equals(mesReferencia))
          ..orderBy([OrderingTerm.asc(usuarios.nome)]);

    return consulta.watch().map((linhas) {
      final resumos = <int, ResumoUsuarioRelatorio>{};

      for (final linha in linhas) {
        final retirada = linha.readTable(retiradas);
        final usuario = linha.readTable(usuarios);

        final resumoAtual = resumos[usuario.id];

        if (resumoAtual == null) {
          resumos[usuario.id] = ResumoUsuarioRelatorio(
            usuarioId: usuario.id,
            nomeUsuario: usuario.nome,
            quantidadeRetiradas: 1,
            totalCentavos: retirada.totalCentavos,
          );
        } else {
          resumos[usuario.id] = ResumoUsuarioRelatorio(
            usuarioId: usuario.id,
            nomeUsuario: usuario.nome,
            quantidadeRetiradas: resumoAtual.quantidadeRetiradas + 1,
            totalCentavos: resumoAtual.totalCentavos + retirada.totalCentavos,
          );
        }
      }

      final lista = resumos.values.toList();

      lista.sort((a, b) => b.totalCentavos.compareTo(a.totalCentavos));

      return lista;
    });
  }

  Future<ResumoUsuarioRelatorio> calcularResumoMensal({
    required int usuarioId,
    required String mesReferencia,
  }) async {
    final usuario = await (select(usuarios)
          ..where((t) => t.id.equals(usuarioId)))
        .getSingleOrNull();

    final nomeUsuario = usuario?.nome ?? 'Usuário';

    final retiradasMes = await (select(retiradas)
          ..where(
            (t) =>
                t.usuarioId.equals(usuarioId) &
                t.mesReferencia.equals(mesReferencia),
          ))
        .get();

    var totalCentavos = 0;
    final quantidadeRetiradas = retiradasMes.length;

    for (final retirada in retiradasMes) {
      totalCentavos += retirada.totalCentavos;
    }

    return ResumoUsuarioRelatorio(
      usuarioId: usuarioId,
      nomeUsuario: nomeUsuario,
      quantidadeRetiradas: quantidadeRetiradas,
      totalCentavos: totalCentavos,
    );
  }

  Future<void> registrarEntradaEstoque({
    required int produtoId,
    required int quantidade,
    String? observacao,
    DateTime? dataHora,
  }) {
    return transaction(() async {
      if (quantidade <= 0) {
        throw ArgumentError('A quantidade da entrada deve ser maior que zero.');
      }

      final produto = await (select(
        produtos,
      )..where((tabela) => tabela.id.equals(produtoId))).getSingleOrNull();

      if (produto == null) {
        throw StateError('Produto não encontrado.');
      }

      final estoqueAnterior = produto.estoqueAtual;

      final estoquePosterior = estoqueAnterior + quantidade;

      await (update(produtos)..where((tabela) => tabela.id.equals(produtoId)))
          .write(ProdutosCompanion(estoqueAtual: Value(estoquePosterior)));

      final textoObservacao = observacao?.trim() ?? '';

      await into(movimentacoesEstoque).insert(
        MovimentacoesEstoqueCompanion.insert(
          produtoId: produtoId,
          tipo: 'entrada',
          quantidade: quantidade,
          estoqueAnterior: estoqueAnterior,
          estoquePosterior: estoquePosterior,
          observacao: Value(
            textoObservacao.isEmpty
                ? 'Entrada de mercadoria.'
                : textoObservacao,
          ),
          dataHora: Value(dataHora ?? DateTime.now()),
        ),
      );
    });
  }

  Stream<List<MovimentacaoEstoqueDetalhada>> observarMovimentacoesEstoque() {
    final consulta = select(movimentacoesEstoque).join([
      innerJoin(
        produtos,
        produtos.id.equalsExp(movimentacoesEstoque.produtoId),
      ),
      leftOuterJoin(
        usuarios,
        usuarios.id.equalsExp(movimentacoesEstoque.usuarioId),
      ),
    ])..orderBy([OrderingTerm.desc(movimentacoesEstoque.dataHora)]);

    return consulta.watch().map((linhas) {
      return linhas.map((linha) {
        final movimentacao = linha.readTable(movimentacoesEstoque);

        final produto = linha.readTable(produtos);

        final usuario = linha.readTableOrNull(usuarios);

        return MovimentacaoEstoqueDetalhada(
          id: movimentacao.id,
          produtoId: produto.id,
          nomeProduto: produto.nome,
          tipo: movimentacao.tipo,
          quantidade: movimentacao.quantidade,
          estoqueAnterior: movimentacao.estoqueAnterior,
          estoquePosterior: movimentacao.estoquePosterior,
          dataHora: movimentacao.dataHora,
          nomeUsuario: usuario?.nome,
          observacao: movimentacao.observacao,
        );
      }).toList();
    });
  }

  Future<void> ajustarEstoque({
    required int produtoId,
    required int novoEstoque,
    required String observacao,
    DateTime? dataHora,
  }) {
    return transaction(() async {
      if (novoEstoque < 0) {
        throw ArgumentError('O estoque não pode ser negativo.');
      }

      final textoObservacao = observacao.trim();

      if (textoObservacao.isEmpty) {
        throw ArgumentError('Informe o motivo do ajuste.');
      }

      final produto = await (select(
        produtos,
      )..where((tabela) => tabela.id.equals(produtoId))).getSingleOrNull();

      if (produto == null) {
        throw StateError('Produto não encontrado.');
      }

      final estoqueAnterior = produto.estoqueAtual;

      if (estoqueAnterior == novoEstoque) {
        throw StateError('O novo estoque é igual ao estoque atual.');
      }

      await (update(produtos)..where((tabela) => tabela.id.equals(produtoId)))
          .write(ProdutosCompanion(estoqueAtual: Value(novoEstoque)));

      final diferenca = (novoEstoque - estoqueAnterior).abs();

      await into(movimentacoesEstoque).insert(
        MovimentacoesEstoqueCompanion.insert(
          produtoId: produtoId,
          tipo: 'ajuste',
          quantidade: diferenca,
          estoqueAnterior: estoqueAnterior,
          estoquePosterior: novoEstoque,
          observacao: Value(textoObservacao),
          dataHora: Value(dataHora ?? DateTime.now()),
        ),
      );
    });
  }

  Stream<List<ResumoMesFechado>> observarHistoricoMesesFechados() {
    final consulta = select(fechamentosMensais)
      ..orderBy([(tabela) => OrderingTerm.desc(tabela.mesReferencia)]);

    return consulta.watch().asyncMap((listaFechamentos) async {
      final resultado = <ResumoMesFechado>[];

      for (final fechamento in listaFechamentos) {
        final retiradasDoMes =
            await (select(retiradas)..where(
                  (tabela) =>
                      tabela.mesReferencia.equals(fechamento.mesReferencia),
                ))
                .get();

        final totalCentavos = retiradasDoMes.fold<int>(
          0,
          (total, retirada) => total + retirada.totalCentavos,
        );

        final usuariosDoMes = retiradasDoMes
            .map((retirada) => retirada.usuarioId)
            .toSet();

        resultado.add(
          ResumoMesFechado(
            mesReferencia: fechamento.mesReferencia,
            fechadoEm: fechamento.fechadoEm,
            totalCentavos: totalCentavos,
            quantidadeRetiradas: retiradasDoMes.length,
            quantidadeUsuarios: usuariosDoMes.length,
          ),
        );
      }

      return resultado;
    });
  }

  Stream<bool> observarMesFechado({required String mesReferencia}) {
    final consulta = select(fechamentosMensais)
      ..where((tabela) => tabela.mesReferencia.equals(mesReferencia));

    return consulta.watch().map((fechamentos) => fechamentos.isNotEmpty);
  }

  Future<bool> verificarMesFechado({required String mesReferencia}) async {
    final fechamento =
        await (select(fechamentosMensais)
              ..where((tabela) => tabela.mesReferencia.equals(mesReferencia)))
            .getSingleOrNull();

    return fechamento != null;
  }

  Future<void> fecharMes({required String mesReferencia}) {
    return transaction(() async {
      final jaFechado = await verificarMesFechado(mesReferencia: mesReferencia);

      if (jaFechado) {
        throw StateError('Este mês já está fechado.');
      }

      await into(fechamentosMensais).insert(
        FechamentosMensaisCompanion.insert(mesReferencia: mesReferencia),
      );

      await (update(retiradas)
            ..where((tabela) => tabela.mesReferencia.equals(mesReferencia)))
          .write(const RetiradasCompanion(fechada: Value(true)));
    });
  }

  Future<int> registrarInventario({
    required String responsavel,
    required List<ItemInventarioRegistro> itens,
    String? observacao,
    DateTime? dataHora,
  }) {
    return transaction(() async {
      final nomeResponsavel = responsavel.trim();

      if (nomeResponsavel.length < 2) {
        throw ArgumentError('Informe o nome do responsável pelo inventário.');
      }

      if (itens.isEmpty) {
        throw ArgumentError('O inventário deve possuir pelo menos um produto.');
      }

      final produtosIncluidos = <int>{};

      for (final item in itens) {
        if (item.estoqueContado < 0) {
          throw ArgumentError('A contagem física não pode ser negativa.');
        }

        if (!produtosIncluidos.add(item.produtoId)) {
          throw ArgumentError(
            'O mesmo produto não pode aparecer duas vezes no inventário.',
          );
        }
      }

      final momentoRegistro = dataHora ?? DateTime.now();
      final produtosValidados =
          <({Produto produto, int estoqueContado, int diferenca})>[];

      for (final item in itens) {
        final produto =
            await (select(produtos)
                  ..where((tabela) => tabela.id.equals(item.produtoId)))
                .getSingleOrNull();

        if (produto == null) {
          throw StateError('Produto de ID ${item.produtoId} não encontrado.');
        }

        final diferenca = item.estoqueContado - produto.estoqueAtual;

        produtosValidados.add((
          produto: produto,
          estoqueContado: item.estoqueContado,
          diferenca: diferenca,
        ));
      }

      final quantidadeDiferencas = produtosValidados
          .where((item) => item.diferenca != 0)
          .length;

      final textoObservacao = observacao?.trim();

      final inventarioId = await into(inventarios).insert(
        InventariosCompanion.insert(
          dataHora: Value(momentoRegistro),
          responsavel: nomeResponsavel,
          quantidadeProdutos: produtosValidados.length,
          quantidadeDiferencas: quantidadeDiferencas,
          observacao: Value(
            textoObservacao == null || textoObservacao.isEmpty
                ? null
                : textoObservacao,
          ),
        ),
      );

      for (final item in produtosValidados) {
        await into(itensInventario).insert(
          ItensInventarioCompanion.insert(
            inventarioId: inventarioId,
            produtoId: item.produto.id,
            nomeProduto: item.produto.nome,
            estoqueSistema: item.produto.estoqueAtual,
            estoqueContado: item.estoqueContado,
            diferenca: item.diferenca,
          ),
        );

        if (item.diferenca == 0) {
          continue;
        }

        await (update(produtos)
              ..where((tabela) => tabela.id.equals(item.produto.id)))
            .write(ProdutosCompanion(estoqueAtual: Value(item.estoqueContado)));

        await into(movimentacoesEstoque).insert(
          MovimentacoesEstoqueCompanion.insert(
            produtoId: item.produto.id,
            tipo: 'ajuste',
            quantidade: item.diferenca.abs(),
            estoqueAnterior: item.produto.estoqueAtual,
            estoquePosterior: item.estoqueContado,
            observacao: Value(
              'Ajuste realizado pelo inventário nº $inventarioId. '
              'Responsável: $nomeResponsavel.',
            ),
            dataHora: Value(momentoRegistro),
          ),
        );
      }

      return inventarioId;
    });
  }

  Future<List<PagamentosMensai>> listarPagamentosPorMes({
    required String mesReferencia,
  }) {
    return (select(pagamentosMensais)
          ..where((t) => t.mesReferencia.equals(mesReferencia))
          ..orderBy([(t) => OrderingTerm(expression: t.usuarioId)]))
        .get();
  }

  Stream<List<PagamentosMensai>> observarPagamentosPorMes({
    required String mesReferencia,
  }) {
    return (select(pagamentosMensais)
          ..where((t) => t.mesReferencia.equals(mesReferencia))
          ..orderBy([(t) => OrderingTerm(expression: t.usuarioId)]))
        .watch();
  }

  Future<List<PagamentosMensai>> listarPagamentosPorUsuario({
    required int usuarioId,
  }) {
    return (select(pagamentosMensais)
          ..where((t) => t.usuarioId.equals(usuarioId))
          ..orderBy([
            (t) => OrderingTerm(
              expression: t.mesReferencia,
              mode: OrderingMode.desc,
            ),
          ]))
        .get();
  }

  Future<bool> verificarPagamentoExistente({
    required int usuarioId,
    required String mesReferencia,
  }) async {
    final resultado = await (select(pagamentosMensais)
          ..where(
            (t) =>
                t.usuarioId.equals(usuarioId) &
                t.mesReferencia.equals(mesReferencia),
          ))
        .getSingleOrNull();

    return resultado != null;
  }

  Future<int> registrarPagamento({
    required int usuarioId,
    required String mesReferencia,
    required int valorCentavos,
    DateTime? pagoEm,
  }) {
    if (valorCentavos <= 0) {
      throw ArgumentError('O valor do pagamento deve ser maior que zero.');
    }

    final dataHora = pagoEm ?? DateTime.now();

    return into(pagamentosMensais).insert(
      PagamentosMensaisCompanion.insert(
        usuarioId: usuarioId,
        mesReferencia: mesReferencia,
        valorCentavos: valorCentavos,
        pagoEm: Value(dataHora),
      ),
    );
  }

  Future<void> removerPagamento({required int id}) {
    return (delete(pagamentosMensais)..where((t) => t.id.equals(id))).go();
  }

  Future<List<Inventario>> listarInventarios() {
    return (select(inventarios)
          ..orderBy([
            (t) => OrderingTerm(
              expression: t.dataHora,
              mode: OrderingMode.desc,
            ),
          ]))
        .get();
  }

  Future<List<ItensInventarioData>> listarItensInventario({
    required int inventarioId,
  }) {
    return (select(itensInventario)
          ..where((t) => t.inventarioId.equals(inventarioId))
          ..orderBy([(t) => OrderingTerm(expression: t.nomeProduto)]))
        .get();
  }

  Future<void> restaurarDadosBackup({
    required List<Usuario> usuariosBackup,
    required List<Produto> produtosBackup,
    required List<Retirada> retiradasBackup,
    required List<ItensRetiradaData> itensRetiradaBackup,
    required List<MovimentacoesEstoqueData> movimentacoesBackup,
    required List<FechamentosMensai> fechamentosBackup,
    required List<PagamentosMensai> pagamentosBackup,
    required List<Inventario> inventariosBackup,
    required List<ItensInventarioData> itensInventarioBackup,
  }) {
    return transaction(() async {
      // Apaga primeiro as tabelas dependentes.
      await delete(itensInventario).go();
      await delete(inventarios).go();
      await delete(pagamentosMensais).go();
      await delete(itensRetirada).go();
      await delete(movimentacoesEstoque).go();
      await delete(retiradas).go();
      await delete(fechamentosMensais).go();

      // Depois apaga as tabelas principais.
      await delete(produtos).go();
      await delete(usuarios).go();

      // Restaura primeiro os registros principais.
      for (final usuario in usuariosBackup) {
        await into(usuarios).insert(usuario);
      }

      for (final produto in produtosBackup) {
        await into(produtos).insert(produto);
      }

      // Restaura os registros dependentes.
      for (final retirada in retiradasBackup) {
        await into(retiradas).insert(retirada);
      }

      for (final item in itensRetiradaBackup) {
        await into(itensRetirada).insert(item);
      }

      for (final movimentacao in movimentacoesBackup) {
        await into(movimentacoesEstoque).insert(movimentacao);
      }

      for (final fechamento in fechamentosBackup) {
        await into(fechamentosMensais).insert(fechamento);
      }

      for (final pagamento in pagamentosBackup) {
        await into(pagamentosMensais).insert(pagamento);
      }

      for (final inventario in inventariosBackup) {
        await into(inventarios).insert(inventario);
      }

      for (final item in itensInventarioBackup) {
        await into(itensInventario).insert(item);
      }
    });
  }
}
