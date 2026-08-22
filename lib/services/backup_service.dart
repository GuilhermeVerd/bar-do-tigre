import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';

import '../core/database/app_database.dart';

class BackupService {
  BackupService({AppDatabase? database}) : database = database ?? appDatabase;

  final AppDatabase database;

  Future<void> gerarBackup() async {
    final usuarios = await database.select(database.usuarios).get();
    final produtos = await database.select(database.produtos).get();
    final retiradas = await database.select(database.retiradas).get();
    final itensRetirada = await database.select(database.itensRetirada).get();

    final movimentacoes = await database
        .select(database.movimentacoesEstoque)
        .get();

    final fechamentos = await database
        .select(database.fechamentosMensais)
        .get();

    final pagamentos = await database
        .select(database.pagamentosMensais)
        .get();

    final inventarios = await database
        .select(database.inventarios)
        .get();

    final itensInventario = await database
        .select(database.itensInventario)
        .get();

    final agora = DateTime.now();

    final backup = <String, dynamic>{
      'aplicativo': 'Bar do Tigre',
      'versaoBackup': 2,
      'geradoEm': agora.toIso8601String(),
      'dados': {
        'usuarios': usuarios.map((item) => item.toJson()).toList(),
        'produtos': produtos.map((item) => item.toJson()).toList(),
        'retiradas': retiradas.map((item) => item.toJson()).toList(),
        'itensRetirada': itensRetirada.map((item) => item.toJson()).toList(),
        'movimentacoesEstoque': movimentacoes
            .map((item) => item.toJson())
            .toList(),
        'fechamentosMensais': fechamentos.map((item) => item.toJson()).toList(),
        'pagamentosMensais': pagamentos.map((item) => item.toJson()).toList(),
        'inventarios': inventarios.map((item) => item.toJson()).toList(),
        'itensInventario': itensInventario.map((item) => item.toJson()).toList(),
      },
    };

    const encoder = JsonEncoder.withIndent('  ');
    final textoJson = encoder.convert(backup);
    final bytes = Uint8List.fromList(utf8.encode(textoJson));

    final dataArquivo =
        '${agora.year}'
        '${agora.month.toString().padLeft(2, '0')}'
        '${agora.day.toString().padLeft(2, '0')}_'
        '${agora.hour.toString().padLeft(2, '0')}'
        '${agora.minute.toString().padLeft(2, '0')}';

    await FileSaver.instance.saveFile(
      name: 'backup_bar_do_tigre_$dataArquivo',
      bytes: bytes,
      ext: 'json',
      mimeType: MimeType.other,
    );
  }

  Future<bool> restaurarBackup() async {
    final resultado = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
      allowMultiple: false,
      withData: true,
    );

    if (resultado == null || resultado.files.isEmpty) {
      return false;
    }

    final arquivo = resultado.files.single;
    final bytes = arquivo.bytes;

    if (bytes == null || bytes.isEmpty) {
      throw const FormatException(
        'Não foi possível ler o arquivo selecionado.',
      );
    }

    final textoJson = utf8.decode(bytes, allowMalformed: false);

    final dynamic conteudoDecodificado;

    try {
      conteudoDecodificado = jsonDecode(textoJson);
    } on FormatException {
      throw const FormatException(
        'O arquivo selecionado não contém um JSON válido.',
      );
    }

    if (conteudoDecodificado is! Map) {
      throw const FormatException(
        'A estrutura do arquivo de backup é inválida.',
      );
    }

    final backup = Map<String, dynamic>.from(conteudoDecodificado);

    _validarCabecalhoBackup(backup);

    final dadosBrutos = backup['dados'];

    if (dadosBrutos is! Map) {
      throw const FormatException(
        'A seção de dados do backup não foi encontrada.',
      );
    }

    final dados = Map<String, dynamic>.from(dadosBrutos);

    final usuariosBackup = _converterLista(
      dados: dados,
      chave: 'usuarios',
      conversor: Usuario.fromJson,
    );

    final produtosBackup = _converterLista(
      dados: dados,
      chave: 'produtos',
      conversor: Produto.fromJson,
    );

    final retiradasBackup = _converterLista(
      dados: dados,
      chave: 'retiradas',
      conversor: Retirada.fromJson,
    );

    final itensRetiradaBackup = _converterLista(
      dados: dados,
      chave: 'itensRetirada',
      conversor: ItensRetiradaData.fromJson,
    );

    final movimentacoesBackup = _converterLista(
      dados: dados,
      chave: 'movimentacoesEstoque',
      conversor: MovimentacoesEstoqueData.fromJson,
    );

    final fechamentosBackup = _converterLista(
      dados: dados,
      chave: 'fechamentosMensais',
      conversor: FechamentosMensai.fromJson,
    );

    final versao = backup['versaoBackup'] as int? ?? 1;

    final List<PagamentosMensai> pagamentosBackup;
    final List<Inventario> inventariosBackup;
    final List<ItensInventarioData> itensInventarioBackup;

    if (versao >= 2) {
      pagamentosBackup = _converterLista(
        dados: dados,
        chave: 'pagamentosMensais',
        conversor: PagamentosMensai.fromJson,
      );

      inventariosBackup = _converterLista(
        dados: dados,
        chave: 'inventarios',
        conversor: Inventario.fromJson,
      );

      itensInventarioBackup = _converterLista(
        dados: dados,
        chave: 'itensInventario',
        conversor: ItensInventarioData.fromJson,
      );
    } else {
      pagamentosBackup = [];
      inventariosBackup = [];
      itensInventarioBackup = [];
    }

    _validarRelacionamentos(
      usuarios: usuariosBackup,
      produtos: produtosBackup,
      retiradas: retiradasBackup,
      itensRetirada: itensRetiradaBackup,
      movimentacoes: movimentacoesBackup,
      pagamentos: pagamentosBackup,
      inventarios: inventariosBackup,
      itensInventario: itensInventarioBackup,
    );

    await database.restaurarDadosBackup(
      usuariosBackup: usuariosBackup,
      produtosBackup: produtosBackup,
      retiradasBackup: retiradasBackup,
      itensRetiradaBackup: itensRetiradaBackup,
      movimentacoesBackup: movimentacoesBackup,
      fechamentosBackup: fechamentosBackup,
      pagamentosBackup: pagamentosBackup,
      inventariosBackup: inventariosBackup,
      itensInventarioBackup: itensInventarioBackup,
    );

    return true;
  }

  void _validarCabecalhoBackup(Map<String, dynamic> backup) {
    if (backup['aplicativo'] != 'Bar do Tigre') {
      throw const FormatException(
        'O arquivo selecionado não pertence ao aplicativo Bar do Tigre.',
      );
    }

    final versaoBackup = backup['versaoBackup'];

    if (versaoBackup is! int) {
      throw const FormatException('A versão do arquivo de backup é inválida.');
    }

    if (versaoBackup < 1 || versaoBackup > 2) {
      throw FormatException(
        'A versão $versaoBackup do backup não é compatível '
        'com esta versão do aplicativo.',
      );
    }
  }

  List<T> _converterLista<T>({
    required Map<String, dynamic> dados,
    required String chave,
    required T Function(Map<String, dynamic>) conversor,
  }) {
    final listaBruta = dados[chave];

    if (listaBruta is! List) {
      throw FormatException(
        'A lista "$chave" não foi encontrada no arquivo de backup.',
      );
    }

    try {
      return listaBruta.map<T>((item) {
        if (item is! Map) {
          throw FormatException(
            'Um registro da lista "$chave" possui formato inválido.',
          );
        }

        return conversor(Map<String, dynamic>.from(item));
      }).toList();
    } on FormatException {
      rethrow;
    } catch (erro) {
      throw FormatException(
        'Não foi possível interpretar os dados da lista "$chave": $erro',
      );
    }
  }

  void _validarRelacionamentos({
    required List<Usuario> usuarios,
    required List<Produto> produtos,
    required List<Retirada> retiradas,
    required List<ItensRetiradaData> itensRetirada,
    required List<MovimentacoesEstoqueData> movimentacoes,
    required List<PagamentosMensai> pagamentos,
    required List<Inventario> inventarios,
    required List<ItensInventarioData> itensInventario,
  }) {
    final idsUsuarios = usuarios.map((item) => item.id).toSet();
    final idsProdutos = produtos.map((item) => item.id).toSet();
    final idsRetiradas = retiradas.map((item) => item.id).toSet();
    final idsInventarios = inventarios.map((item) => item.id).toSet();

    for (final retirada in retiradas) {
      if (!idsUsuarios.contains(retirada.usuarioId)) {
        throw FormatException(
          'A retirada ${retirada.id} está vinculada '
          'a um usuário inexistente.',
        );
      }
    }

    for (final item in itensRetirada) {
      if (!idsRetiradas.contains(item.retiradaId)) {
        throw const FormatException(
          'Um item está vinculado a uma retirada inexistente.',
        );
      }

      if (!idsProdutos.contains(item.produtoId)) {
        throw const FormatException(
          'Um item está vinculado a um produto inexistente.',
        );
      }
    }

    for (final movimentacao in movimentacoes) {
      if (!idsProdutos.contains(movimentacao.produtoId)) {
        throw const FormatException(
          'Uma movimentação de estoque está vinculada '
          'a um produto inexistente.',
        );
      }
    }

    for (final pagamento in pagamentos) {
      if (!idsUsuarios.contains(pagamento.usuarioId)) {
        throw const FormatException(
          'Um pagamento está vinculado a um usuário inexistente.',
        );
      }
    }

    for (final item in itensInventario) {
      if (!idsInventarios.contains(item.inventarioId)) {
        throw const FormatException(
          'Um item de inventário está vinculado a um inventário inexistente.',
        );
      }

      if (!idsProdutos.contains(item.produtoId)) {
        throw const FormatException(
          'Um item de inventário está vinculado a um produto inexistente.',
        );
      }
    }
  }
}
