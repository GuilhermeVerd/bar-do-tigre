import 'dart:typed_data';

import 'package:syncfusion_flutter_xlsio/xlsio.dart';

import '../core/database/app_database.dart';
import 'download_service.dart';

class ExcelService {
  const ExcelService._();

  static Future<void> gerarRelatorioMensal({
    required List<ResumoUsuarioRelatorio> relatorios,
    required String nomeMes,
    required int ano,
    required bool mesFechado,
  }) async {
    final workbook = Workbook();
    final worksheet = workbook.worksheets[0];

    worksheet.name = 'Relatório mensal';

    final totalGeral = relatorios.fold<int>(
      0,
      (total, resumo) => total + resumo.totalCentavos,
    );

    final quantidadeTotalRetiradas = relatorios.fold<int>(
      0,
      (total, resumo) => total + resumo.quantidadeRetiradas,
    );

    _configurarCabecalho(
      worksheet: worksheet,
      nomeMes: nomeMes,
      ano: ano,
      mesFechado: mesFechado,
    );

    _criarResumoGeral(
      worksheet: worksheet,
      totalGeral: totalGeral,
      quantidadeTotalRetiradas: quantidadeTotalRetiradas,
      quantidadeUsuarios: relatorios.length,
    );

    _criarTabelaUsuarios(
      worksheet: worksheet,
      relatorios: relatorios,
      totalGeral: totalGeral,
    );

    _ajustarColunas(worksheet);

    final List<int> arquivo = workbook.saveAsStream();

    workbook.dispose();

    final bytes = Uint8List.fromList(arquivo);

    final nomeMesArquivo = nomeMes
        .toLowerCase()
        .replaceAll('ç', 'c')
        .replaceAll('ã', 'a')
        .replaceAll('á', 'a')
        .replaceAll('é', 'e')
        .replaceAll('í', 'i')
        .replaceAll('ó', 'o')
        .replaceAll('ú', 'u')
        .replaceAll(' ', '_');

    await DownloadService.baixarArquivo(
      bytes: bytes,
      nomeArquivo: 'relatorio_bar_do_tigre_${nomeMesArquivo}_$ano.xlsx',
      mimeType:
          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    );
  }

  static void _configurarCabecalho({
    required Worksheet worksheet,
    required String nomeMes,
    required int ano,
    required bool mesFechado,
  }) {
    final titulo = worksheet.getRangeByName('A1:C1');

    titulo.merge();
    titulo.setText('BAR DO TIGRE');

    titulo.cellStyle
      ..bold = true
      ..fontSize = 18
      ..hAlign = HAlignType.center
      ..vAlign = VAlignType.center
      ..backColor = '#0B1F3A'
      ..fontColor = '#FFFFFF';

    worksheet.getRangeByName('A1').rowHeight = 30;

    final subtitulo = worksheet.getRangeByName('A2:C2');

    subtitulo.merge();
    subtitulo.setText('Relatório mensal — $nomeMes de $ano');

    subtitulo.cellStyle
      ..bold = true
      ..fontSize = 12
      ..hAlign = HAlignType.center;

    final situacao = worksheet.getRangeByName('A3:C3');

    situacao.merge();
    situacao.setText(
      mesFechado ? 'Situação: mês fechado' : 'Situação: mês aberto',
    );

    situacao.cellStyle
      ..bold = true
      ..hAlign = HAlignType.center
      ..fontColor = mesFechado ? '#008000' : '#C65911';
  }

  static void _criarResumoGeral({
    required Worksheet worksheet,
    required int totalGeral,
    required int quantidadeTotalRetiradas,
    required int quantidadeUsuarios,
  }) {
    final cabecalho = worksheet.getRangeByName('A5:C5');

    cabecalho.cellStyle
      ..bold = true
      ..backColor = '#D9EAF7'
      ..hAlign = HAlignType.center;

    worksheet.getRangeByName('A5').setText('Total consumido');
    worksheet.getRangeByName('B5').setText('Retiradas');
    worksheet.getRangeByName('C5').setText('Usuários');

    worksheet.getRangeByName('A6').setNumber(totalGeral / 100);
    worksheet.getRangeByName('A6').numberFormat = r'R$ #,##0.00';

    worksheet
        .getRangeByName('B6')
        .setNumber(quantidadeTotalRetiradas.toDouble());

    worksheet.getRangeByName('C6').setNumber(quantidadeUsuarios.toDouble());

    worksheet.getRangeByName('A6:C6').cellStyle.hAlign = HAlignType.center;
  }

  static void _criarTabelaUsuarios({
    required Worksheet worksheet,
    required List<ResumoUsuarioRelatorio> relatorios,
    required int totalGeral,
  }) {
    const linhaCabecalho = 8;

    final cabecalho = worksheet.getRangeByIndex(
      linhaCabecalho,
      1,
      linhaCabecalho,
      3,
    );

    cabecalho.cellStyle
      ..bold = true
      ..backColor = '#0B1F3A'
      ..fontColor = '#FFFFFF'
      ..hAlign = HAlignType.center;

    worksheet.getRangeByIndex(linhaCabecalho, 1).setText('Usuário');
    worksheet.getRangeByIndex(linhaCabecalho, 2).setText('Retiradas');
    worksheet.getRangeByIndex(linhaCabecalho, 3).setText('Total');

    var linhaAtual = linhaCabecalho + 1;

    for (final resumo in relatorios) {
      worksheet.getRangeByIndex(linhaAtual, 1).setText(resumo.nomeUsuario);

      worksheet
          .getRangeByIndex(linhaAtual, 2)
          .setNumber(resumo.quantidadeRetiradas.toDouble());

      final celulaTotal = worksheet.getRangeByIndex(linhaAtual, 3);

      celulaTotal.setNumber(resumo.totalCentavos / 100);
      celulaTotal.numberFormat = r'R$ #,##0.00';

      linhaAtual++;
    }

    if (relatorios.isEmpty) {
      final vazio = worksheet.getRangeByIndex(linhaAtual, 1, linhaAtual, 3);

      vazio.merge();
      vazio.setText('Nenhum consumo registrado neste mês.');
      vazio.cellStyle.hAlign = HAlignType.center;

      linhaAtual++;
    }

    final linhaTotal = worksheet.getRangeByIndex(linhaAtual, 1, linhaAtual, 3);

    linhaTotal.cellStyle
      ..bold = true
      ..backColor = '#D9EAF7';

    worksheet.getRangeByIndex(linhaAtual, 1, linhaAtual, 2).merge();

    worksheet.getRangeByIndex(linhaAtual, 1).setText('TOTAL GERAL');

    final celulaTotalGeral = worksheet.getRangeByIndex(linhaAtual, 3);

    celulaTotalGeral.setNumber(totalGeral / 100);
    celulaTotalGeral.numberFormat = r'R$ #,##0.00';
  }

  static void _ajustarColunas(Worksheet worksheet) {
    worksheet.getRangeByName('A1:A1000').columnWidth = 32;
    worksheet.getRangeByName('B1:B1000').columnWidth = 15;
    worksheet.getRangeByName('C1:C1000').columnWidth = 18;

    worksheet.getRangeByName('A1:C1000').cellStyle
      ..fontName = 'Arial'
      ..vAlign = VAlignType.center;
  }
}
