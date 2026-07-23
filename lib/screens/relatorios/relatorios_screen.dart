import 'package:flutter/material.dart';
import '../../services/excel_service.dart';
import '../../core/database/app_database.dart';
import '../../repositories/retirada_repository.dart';
import '../../services/pdf_service.dart';
import '../consumo/meu_consumo_screen.dart';
import 'historico_meses_screen.dart';

class RelatoriosScreen extends StatefulWidget {
  const RelatoriosScreen({super.key, this.mesInicial});

  final DateTime? mesInicial;

  @override
  State<RelatoriosScreen> createState() => _RelatoriosScreenState();
}

class _RelatoriosScreenState extends State<RelatoriosScreen> {
  final RetiradaRepository repository = RetiradaRepository();

  late DateTime mesSelecionado;

  @override
  void initState() {
    super.initState();

    mesSelecionado = widget.mesInicial ?? DateTime.now();
  }

  String get mesReferencia {
    return '${mesSelecionado.year}-'
        '${mesSelecionado.month.toString().padLeft(2, '0')}';
  }

  String nomeDoMes(int mes) {
    const meses = [
      'Janeiro',
      'Fevereiro',
      'Março',
      'Abril',
      'Maio',
      'Junho',
      'Julho',
      'Agosto',
      'Setembro',
      'Outubro',
      'Novembro',
      'Dezembro',
    ];

    return meses[mes - 1];
  }

  void mesAnterior() {
    setState(() {
      mesSelecionado = DateTime(mesSelecionado.year, mesSelecionado.month - 1);
    });
  }

  void proximoMes() {
    final agora = DateTime.now();

    final proximo = DateTime(mesSelecionado.year, mesSelecionado.month + 1);

    final mesAtual = DateTime(agora.year, agora.month);

    if (proximo.isAfter(mesAtual)) {
      return;
    }

    setState(() {
      mesSelecionado = proximo;
    });
  }

  bool get podeAvancarMes {
    final agora = DateTime.now();

    final mesAtual = DateTime(agora.year, agora.month);

    final mesExibido = DateTime(mesSelecionado.year, mesSelecionado.month);

    return mesExibido.isBefore(mesAtual);
  }

  String formatarPreco(int valorCentavos) {
    final valor = valorCentavos / 100;

    return valor.toStringAsFixed(2).replaceAll('.', ',');
  }

  void abrirConsumoDoUsuario(ResumoUsuarioRelatorio resumo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MeuConsumoScreen(
          usuarioId: resumo.usuarioId,
          nomeUsuario: resumo.nomeUsuario,
        ),
      ),
    );
  }

  Future<void> fecharMes() async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Fechar mês'),
          content: Text(
            'Deseja realmente fechar '
            '${nomeDoMes(mesSelecionado.month)} '
            '${mesSelecionado.year}?\n\n'
            'Depois do fechamento, não será possível '
            'registrar novos consumos nesse mês.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancelar'),
            ),
            FilledButton.icon(
              onPressed: () {
                Navigator.pop(context, true);
              },
              icon: const Icon(Icons.lock),
              label: const Text('Fechar mês'),
            ),
          ],
        );
      },
    );

    if (confirmar != true) {
      return;
    }

    try {
      await repository.fecharMes(mesReferencia: mesReferencia);

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${nomeDoMes(mesSelecionado.month)} '
            '${mesSelecionado.year} foi fechado com sucesso.',
          ),
          backgroundColor: Colors.green,
        ),
      );
    } catch (erro) {
      if (!mounted) {
        return;
      }

      final mensagem = erro
          .toString()
          .replaceFirst('Bad state: ', '')
          .replaceFirst('StateError: ', '');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(mensagem), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> gerarPdf({
    required List<ResumoUsuarioRelatorio> relatorios,
    required bool mesFechado,
  }) async {
    try {
      await PdfService.gerarRelatorioMensal(
        relatorios: relatorios,
        nomeMes: nomeDoMes(mesSelecionado.month),
        ano: mesSelecionado.year,
        mesFechado: mesFechado,
      );
    } catch (erro) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Não foi possível gerar o PDF: $erro'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> gerarExcel({
    required List<ResumoUsuarioRelatorio> relatorios,
    required bool mesFechado,
  }) async {
    try {
      await ExcelService.gerarRelatorioMensal(
        relatorios: relatorios,
        nomeMes: nomeDoMes(mesSelecionado.month),
        ano: mesSelecionado.year,
        mesFechado: mesFechado,
      );
    } catch (erro) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Não foi possível gerar o Excel: $erro'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        title: const Text('Relatórios'),
        backgroundColor: const Color(0xFF0B1F3A),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Histórico de meses',
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistoricoMesesScreen()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: StreamBuilder<bool>(
              stream: repository.observarMesFechado(
                mesReferencia: mesReferencia,
              ),
              builder: (context, fechamentoSnapshot) {
                if (fechamentoSnapshot.hasError) {
                  return _EstadoErro(erro: fechamentoSnapshot.error.toString());
                }

                final mesFechado = fechamentoSnapshot.data ?? false;

                return StreamBuilder<List<ResumoUsuarioRelatorio>>(
                  stream: repository.observarRelatorioMensal(
                    mesReferencia: mesReferencia,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return _EstadoErro(erro: snapshot.error.toString());
                    }

                    if (!snapshot.hasData || !fechamentoSnapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final relatorios = snapshot.data!;

                    final totalConsumido = relatorios.fold<int>(
                      0,
                      (total, resumo) => total + resumo.totalCentavos,
                    );

                    final quantidadeRetiradas = relatorios.fold<int>(
                      0,
                      (total, resumo) => total + resumo.quantidadeRetiradas,
                    );

                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          _SeletorMes(
                            titulo:
                                '${nomeDoMes(mesSelecionado.month)} '
                                '${mesSelecionado.year}',
                            aoVoltar: mesAnterior,
                            aoAvancar: podeAvancarMes ? proximoMes : null,
                          ),
                          const SizedBox(height: 20),
                          _CardsResumo(
                            totalConsumido: totalConsumido,
                            quantidadeRetiradas: quantidadeRetiradas,
                            formatarPreco: formatarPreco,
                          ),
                          const SizedBox(height: 16),
                          Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton.icon(
                                  onPressed: relatorios.isEmpty
                                      ? null
                                      : () {
                                          gerarPdf(
                                            relatorios: relatorios,
                                            mesFechado: mesFechado,
                                          );
                                        },
                                  icon: const Icon(Icons.picture_as_pdf),
                                  label: const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 14),
                                    child: Text(
                                      'Gerar PDF',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              const SizedBox(height: 12),

                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton.icon(
                                  onPressed: relatorios.isEmpty
                                      ? null
                                      : () {
                                          gerarExcel(
                                            relatorios: relatorios,
                                            mesFechado: mesFechado,
                                          );
                                        },
                                  icon: const Icon(Icons.table_view),
                                  label: const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 14),
                                    child: Text(
                                      'Gerar Excel',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
                                child: mesFechado
                                    ? const _MesFechadoCard()
                                    : FilledButton.icon(
                                        onPressed: fecharMes,
                                        icon: const Icon(Icons.lock_outline),
                                        label: const Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 14,
                                          ),
                                          child: Text(
                                            'Fechar mês',
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Expanded(
                            child: relatorios.isEmpty
                                ? const _EstadoVazio()
                                : _ListaRelatorios(
                                    relatorios: relatorios,
                                    formatarPreco: formatarPreco,
                                    aoSelecionar: abrirConsumoDoUsuario,
                                  ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _MesFechadoCard extends StatelessWidget {
  const _MesFechadoCard();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock, color: Colors.green),
            SizedBox(width: 10),
            Text(
              'Mês fechado',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardsResumo extends StatelessWidget {
  const _CardsResumo({
    required this.totalConsumido,
    required this.quantidadeRetiradas,
    required this.formatarPreco,
  });

  final int totalConsumido;
  final int quantidadeRetiradas;
  final String Function(int) formatarPreco;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final usarColuna = constraints.maxWidth < 600;

        final cardTotal = _ResumoCard(
          titulo: 'Total consumido',
          valor: 'R\$ ${formatarPreco(totalConsumido)}',
          icone: Icons.attach_money,
        );

        final cardRetiradas = _ResumoCard(
          titulo: 'Retiradas',
          valor: quantidadeRetiradas.toString(),
          icone: Icons.receipt_long,
        );

        if (usarColuna) {
          return Column(
            children: [cardTotal, const SizedBox(height: 12), cardRetiradas],
          );
        }

        return Row(
          children: [
            Expanded(child: cardTotal),
            const SizedBox(width: 16),
            Expanded(child: cardRetiradas),
          ],
        );
      },
    );
  }
}

class _ListaRelatorios extends StatelessWidget {
  const _ListaRelatorios({
    required this.relatorios,
    required this.formatarPreco,
    required this.aoSelecionar,
  });

  final List<ResumoUsuarioRelatorio> relatorios;
  final String Function(int) formatarPreco;
  final void Function(ResumoUsuarioRelatorio resumo) aoSelecionar;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: relatorios.length,
      separatorBuilder: (_, _) {
        return const SizedBox(height: 12);
      },
      itemBuilder: (context, index) {
        final resumo = relatorios[index];

        return Card(
          elevation: 2,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              aoSelecionar(resumo);
            },
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: const Color(0xFFE8EDF4),
                    child: Text(
                      resumo.nomeUsuario.isEmpty
                          ? '?'
                          : resumo.nomeUsuario.substring(0, 1).toUpperCase(),
                      style: const TextStyle(
                        color: Color(0xFF0B1F3A),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          resumo.nomeUsuario,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0B1F3A),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${resumo.quantidadeRetiradas} '
                          'retirada(s)',
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'R\$ ${formatarPreco(resumo.totalCentavos)}',
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0B1F3A),
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Ver detalhes',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black45,
                            ),
                          ),
                          SizedBox(width: 3),
                          Icon(
                            Icons.chevron_right,
                            size: 18,
                            color: Colors.black45,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SeletorMes extends StatelessWidget {
  const _SeletorMes({
    required this.titulo,
    required this.aoVoltar,
    required this.aoAvancar,
  });

  final String titulo;
  final VoidCallback aoVoltar;
  final VoidCallback? aoAvancar;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          tooltip: 'Mês anterior',
          onPressed: aoVoltar,
          icon: const Icon(Icons.chevron_left),
        ),
        Expanded(
          child: Text(
            titulo,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0B1F3A),
            ),
          ),
        ),
        IconButton(
          tooltip: 'Próximo mês',
          onPressed: aoAvancar,
          icon: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}

class _ResumoCard extends StatelessWidget {
  const _ResumoCard({
    required this.titulo,
    required this.valor,
    required this.icone,
  });

  final String titulo;
  final String valor;
  final IconData icone;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: const Color(0xFFE8EDF4),
              child: Icon(icone, color: const Color(0xFF0B1F3A)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(titulo, style: const TextStyle(color: Colors.black54)),
                  const SizedBox(height: 6),
                  Text(
                    valor,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0B1F3A),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EstadoVazio extends StatelessWidget {
  const _EstadoVazio();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bar_chart_outlined, size: 90, color: Colors.black26),
          SizedBox(height: 16),
          Text(
            'Nenhum consumo registrado neste mês.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class _EstadoErro extends StatelessWidget {
  const _EstadoErro({required this.erro});

  final String erro;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 70, color: Colors.redAccent),
            const SizedBox(height: 16),
            const Text(
              'Não foi possível carregar o relatório.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              erro,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
