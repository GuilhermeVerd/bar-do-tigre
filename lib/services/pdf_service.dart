import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../core/database/app_database.dart';

class ItemInventarioPdf {
  const ItemInventarioPdf({
    required this.nome,
    required this.categoria,
    required this.estoqueSistema,
    required this.contagemFisica,
  });

  final String nome;
  final String categoria;
  final int estoqueSistema;
  final int contagemFisica;

  int get diferenca => contagemFisica - estoqueSistema;
}

class PdfService {
  const PdfService._();
  static Future<void> gerarInventario({
    required List<ItemInventarioPdf> itens,
  }) async {
    final documento = pw.Document();
    final agora = DateTime.now();

    final produtosComDiferenca = itens.where((item) {
      return item.diferenca != 0;
    }).length;

    final aumentos = itens.where((item) {
      return item.diferenca > 0;
    }).length;

    final reducoes = itens.where((item) {
      return item.diferenca < 0;
    }).length;

    documento.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(36),
        header: (context) {
          return _cabecalhoInventario(data: agora);
        },
        footer: (context) {
          return _rodape(
            paginaAtual: context.pageNumber,
            totalPaginas: context.pagesCount,
          );
        },
        build: (context) {
          return [
            pw.SizedBox(height: 20),
            _resumoInventario(
              produtosConferidos: itens.length,
              produtosComDiferenca: produtosComDiferenca,
              aumentos: aumentos,
              reducoes: reducoes,
            ),
            pw.SizedBox(height: 24),
            pw.Text(
              'Produtos conferidos',
              style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 12),
            if (itens.isEmpty)
              _estadoInventarioVazio()
            else
              _tabelaInventario(itens),
            pw.SizedBox(height: 20),
            pw.Text(
              'Documento gerado a partir da conferência física '
              'do estoque do Bar do Tigre.',
              style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
            ),
          ];
        },
      ),
    );

    final dataArquivo =
        '${agora.year}-'
        '${agora.month.toString().padLeft(2, '0')}-'
        '${agora.day.toString().padLeft(2, '0')}';

    await Printing.layoutPdf(
      name: 'inventario_bar_do_tigre_$dataArquivo.pdf',
      onLayout: (formato) async {
        return documento.save();
      },
    );
  }

  static Future<void> gerarRelatorioMensal({
    required List<ResumoUsuarioRelatorio> relatorios,
    required String nomeMes,
    required int ano,
    required bool mesFechado,
  }) async {
    final documento = pw.Document();

    final totalGeral = relatorios.fold<int>(
      0,
      (total, resumo) => total + resumo.totalCentavos,
    );

    final quantidadeTotalRetiradas = relatorios.fold<int>(
      0,
      (total, resumo) => total + resumo.quantidadeRetiradas,
    );

    documento.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(36),
        header: (context) {
          return _cabecalho(nomeMes: nomeMes, ano: ano, mesFechado: mesFechado);
        },
        footer: (context) {
          return _rodape(
            paginaAtual: context.pageNumber,
            totalPaginas: context.pagesCount,
          );
        },
        build: (context) {
          return [
            pw.SizedBox(height: 20),
            _cardsResumo(
              totalGeral: totalGeral,
              quantidadeTotalRetiradas: quantidadeTotalRetiradas,
              quantidadeUsuarios: relatorios.length,
            ),
            pw.SizedBox(height: 24),
            pw.Text(
              'Consumo por usuário',
              style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 12),
            if (relatorios.isEmpty)
              _estadoVazio()
            else
              _tabelaRelatorios(relatorios),
            pw.SizedBox(height: 24),
            _totalFinal(totalGeral),
            pw.SizedBox(height: 20),
            _observacaoFechamento(mesFechado: mesFechado),
          ];
        },
      ),
    );

    await Printing.layoutPdf(
      name: 'relatorio_bar_do_tigre_${nomeMes.toLowerCase()}_$ano.pdf',
      onLayout: (formato) async {
        return documento.save();
      },
    );
  }

  static pw.Widget _cabecalhoInventario({required DateTime data}) {
    final dataFormatada =
        '${data.day.toString().padLeft(2, '0')}/'
        '${data.month.toString().padLeft(2, '0')}/'
        '${data.year}';

    final horaFormatada =
        '${data.hour.toString().padLeft(2, '0')}:'
        '${data.minute.toString().padLeft(2, '0')}';

    return pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 14),
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(width: 1.5, color: PdfColors.blueGrey900),
        ),
      ),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
            width: 50,
            height: 50,
            alignment: pw.Alignment.center,
            decoration: pw.BoxDecoration(
              color: PdfColors.blueGrey900,
              borderRadius: pw.BorderRadius.circular(8),
            ),
            child: pw.Text(
              'BT',
              style: pw.TextStyle(
                color: PdfColors.white,
                fontSize: 18,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.SizedBox(width: 14),
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'BAR DO TIGRE',
                  style: pw.TextStyle(
                    fontSize: 22,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.blueGrey900,
                  ),
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  'Relatório de inventário físico',
                  style: const pw.TextStyle(
                    fontSize: 12,
                    color: PdfColors.grey700,
                  ),
                ),
                pw.SizedBox(height: 3),
                pw.Text(
                  '$dataFormatada às $horaFormatada',
                  style: pw.TextStyle(
                    fontSize: 13,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _resumoInventario({
    required int produtosConferidos,
    required int produtosComDiferenca,
    required int aumentos,
    required int reducoes,
  }) {
    return pw.Column(
      children: [
        pw.Row(
          children: [
            pw.Expanded(
              child: _cardResumo(
                titulo: 'Conferidos',
                valor: produtosConferidos.toString(),
              ),
            ),
            pw.SizedBox(width: 12),
            pw.Expanded(
              child: _cardResumo(
                titulo: 'Com diferença',
                valor: produtosComDiferenca.toString(),
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 12),
        pw.Row(
          children: [
            pw.Expanded(
              child: _cardResumo(
                titulo: 'Aumentos',
                valor: aumentos.toString(),
              ),
            ),
            pw.SizedBox(width: 12),
            pw.Expanded(
              child: _cardResumo(
                titulo: 'Reduções',
                valor: reducoes.toString(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget _tabelaInventario(List<ItemInventarioPdf> itens) {
    final itensOrdenados = [...itens]
      ..sort((a, b) {
        return a.nome.toLowerCase().compareTo(b.nome.toLowerCase());
      });

    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.8),
      columnWidths: const {
        0: pw.FlexColumnWidth(2.8),
        1: pw.FlexColumnWidth(1.5),
        2: pw.FlexColumnWidth(1.2),
        3: pw.FlexColumnWidth(1.2),
        4: pw.FlexColumnWidth(1.1),
      },
      children: [
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.blueGrey900),
          children: [
            _celulaCabecalho('Produto'),
            _celulaCabecalho('Categoria'),
            _celulaCabecalho('Sistema'),
            _celulaCabecalho('Físico'),
            _celulaCabecalho('Diferença'),
          ],
        ),
        ...itensOrdenados.map((item) {
          final diferenca = item.diferenca;

          final textoDiferenca = diferenca > 0
              ? '+$diferenca'
              : diferenca.toString();

          final corDiferenca = diferenca > 0
              ? PdfColors.green800
              : diferenca < 0
              ? PdfColors.red800
              : PdfColors.grey700;

          return pw.TableRow(
            children: [
              _celulaTabela(item.nome),
              _celulaTabela(item.categoria),
              _celulaTabela(
                item.estoqueSistema.toString(),
                alinhamento: pw.Alignment.center,
              ),
              _celulaTabela(
                item.contagemFisica.toString(),
                alinhamento: pw.Alignment.center,
              ),
              pw.Container(
                alignment: pw.Alignment.center,
                padding: const pw.EdgeInsets.all(9),
                child: pw.Text(
                  textoDiferenca,
                  style: pw.TextStyle(
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                    color: corDiferenca,
                  ),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }

  static pw.Widget _estadoInventarioVazio() {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.all(24),
      alignment: pw.Alignment.center,
      decoration: pw.BoxDecoration(
        color: PdfColors.grey100,
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Text(
        'Nenhum produto foi informado no inventário.',
        style: const pw.TextStyle(color: PdfColors.grey700),
      ),
    );
  }

  static pw.Widget _cabecalho({
    required String nomeMes,
    required int ano,
    required bool mesFechado,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 14),
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(width: 1.5, color: PdfColors.blueGrey900),
        ),
      ),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
            width: 50,
            height: 50,
            alignment: pw.Alignment.center,
            decoration: pw.BoxDecoration(
              color: PdfColors.blueGrey900,
              borderRadius: pw.BorderRadius.circular(8),
            ),
            child: pw.Text(
              'BT',
              style: pw.TextStyle(
                color: PdfColors.white,
                fontSize: 18,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.SizedBox(width: 14),
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'BAR DO TIGRE',
                  style: pw.TextStyle(
                    fontSize: 22,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.blueGrey900,
                  ),
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  'Relatório mensal de consumos',
                  style: const pw.TextStyle(
                    fontSize: 12,
                    color: PdfColors.grey700,
                  ),
                ),
                pw.SizedBox(height: 3),
                pw.Text(
                  '$nomeMes de $ano',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: pw.BoxDecoration(
              color: mesFechado ? PdfColors.green100 : PdfColors.orange100,
              borderRadius: pw.BorderRadius.circular(6),
            ),
            child: pw.Text(
              mesFechado ? 'MÊS FECHADO' : 'MÊS ABERTO',
              style: pw.TextStyle(
                fontSize: 9,
                fontWeight: pw.FontWeight.bold,
                color: mesFechado ? PdfColors.green900 : PdfColors.orange900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _cardsResumo({
    required int totalGeral,
    required int quantidadeTotalRetiradas,
    required int quantidadeUsuarios,
  }) {
    return pw.Row(
      children: [
        pw.Expanded(
          child: _cardResumo(
            titulo: 'Total consumido',
            valor: 'R\$ ${_formatarPreco(totalGeral)}',
          ),
        ),
        pw.SizedBox(width: 12),
        pw.Expanded(
          child: _cardResumo(
            titulo: 'Retiradas',
            valor: quantidadeTotalRetiradas.toString(),
          ),
        ),
        pw.SizedBox(width: 12),
        pw.Expanded(
          child: _cardResumo(
            titulo: 'Usuários',
            valor: quantidadeUsuarios.toString(),
          ),
        ),
      ],
    );
  }

  static pw.Widget _cardResumo({
    required String titulo,
    required String valor,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(14),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey100,
        borderRadius: pw.BorderRadius.circular(8),
        border: pw.Border.all(color: PdfColors.grey300),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            titulo,
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
          ),
          pw.SizedBox(height: 6),
          pw.Text(
            valor,
            style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.blueGrey900,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _tabelaRelatorios(List<ResumoUsuarioRelatorio> relatorios) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.8),
      columnWidths: const {
        0: pw.FlexColumnWidth(3),
        1: pw.FlexColumnWidth(1.3),
        2: pw.FlexColumnWidth(1.5),
      },
      children: [
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.blueGrey900),
          children: [
            _celulaCabecalho('Usuário'),
            _celulaCabecalho('Retiradas'),
            _celulaCabecalho('Total'),
          ],
        ),
        ...relatorios.map((resumo) {
          return pw.TableRow(
            children: [
              _celulaTabela(resumo.nomeUsuario),
              _celulaTabela(
                resumo.quantidadeRetiradas.toString(),
                alinhamento: pw.Alignment.center,
              ),
              _celulaTabela(
                'R\$ ${_formatarPreco(resumo.totalCentavos)}',
                alinhamento: pw.Alignment.centerRight,
              ),
            ],
          );
        }),
      ],
    );
  }

  static pw.Widget _celulaCabecalho(String texto) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(9),
      child: pw.Text(
        texto,
        style: pw.TextStyle(
          color: PdfColors.white,
          fontSize: 10,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
  }

  static pw.Widget _celulaTabela(
    String texto, {
    pw.Alignment alinhamento = pw.Alignment.centerLeft,
  }) {
    return pw.Container(
      alignment: alinhamento,
      padding: const pw.EdgeInsets.all(9),
      child: pw.Text(texto, style: const pw.TextStyle(fontSize: 10)),
    );
  }

  static pw.Widget _totalFinal(int totalGeral) {
    return pw.Container(
      alignment: pw.Alignment.centerRight,
      padding: const pw.EdgeInsets.all(14),
      decoration: pw.BoxDecoration(
        color: PdfColors.blueGrey50,
        borderRadius: pw.BorderRadius.circular(8),
        border: pw.Border.all(color: PdfColors.blueGrey200),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.end,
        children: [
          pw.Text(
            'TOTAL GERAL: ',
            style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold),
          ),
          pw.Text(
            'R\$ ${_formatarPreco(totalGeral)}',
            style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.blueGrey900,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _estadoVazio() {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.all(24),
      alignment: pw.Alignment.center,
      decoration: pw.BoxDecoration(
        color: PdfColors.grey100,
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Text(
        'Nenhum consumo registrado neste mês.',
        style: const pw.TextStyle(color: PdfColors.grey700),
      ),
    );
  }

  static pw.Widget _observacaoFechamento({required bool mesFechado}) {
    return pw.Text(
      mesFechado
          ? 'Este relatório corresponde a um mês fechado. '
                'Não são permitidos novos consumos neste período.'
          : 'Este relatório corresponde a um mês ainda aberto. '
                'Os valores podem sofrer alterações.',
      style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
    );
  }

  static pw.Widget _rodape({
    required int paginaAtual,
    required int totalPaginas,
  }) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(top: 16),
      padding: const pw.EdgeInsets.only(top: 8),
      decoration: const pw.BoxDecoration(
        border: pw.Border(top: pw.BorderSide(color: PdfColors.grey400)),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            'Bar do Tigre',
            style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey600),
          ),
          pw.Text(
            'Página $paginaAtual de $totalPaginas',
            style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey600),
          ),
        ],
      ),
    );
  }

  static String _formatarPreco(int valorCentavos) {
    final valor = valorCentavos / 100;
    return valor.toStringAsFixed(2).replaceAll('.', ',');
  }
}
