import 'package:flutter/material.dart';

import '../../core/database/app_database.dart';
import '../../repositories/retirada_repository.dart';
import 'relatorios_screen.dart';

class HistoricoMesesScreen extends StatelessWidget {
  HistoricoMesesScreen({super.key});

  final RetiradaRepository repository = RetiradaRepository();

  String formatarPreco(int valorCentavos) {
    final valor = valorCentavos / 100;
    return valor.toStringAsFixed(2).replaceAll('.', ',');
  }

  String nomeDoMesReferencia(String mesReferencia) {
    final partes = mesReferencia.split('-');

    if (partes.length != 2) {
      return mesReferencia;
    }

    final ano = int.tryParse(partes[0]);
    final mes = int.tryParse(partes[1]);

    if (ano == null || mes == null || mes < 1 || mes > 12) {
      return mesReferencia;
    }

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

    return '${meses[mes - 1]} / $ano';
  }

  String formatarData(DateTime data) {
    final dia = data.day.toString().padLeft(2, '0');
    final mes = data.month.toString().padLeft(2, '0');
    final ano = data.year.toString();

    return '$dia/$mes/$ano';
  }

  DateTime converterMesReferencia(String mesReferencia) {
    final partes = mesReferencia.split('-');

    final ano = int.parse(partes[0]);
    final mes = int.parse(partes[1]);

    return DateTime(ano, mes);
  }

  void abrirRelatorio(
    BuildContext context,
    ResumoMesFechado resumo,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RelatoriosScreen(
          mesInicial: converterMesReferencia(resumo.mesReferencia),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        title: const Text('Histórico de Meses'),
        backgroundColor: const Color(0xFF0B1F3A),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: StreamBuilder<List<ResumoMesFechado>>(
              stream: repository.observarHistoricoMesesFechados(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return _EstadoErro(
                    erro: snapshot.error.toString(),
                  );
                }

                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final meses = snapshot.data!;

                if (meses.isEmpty) {
                  return const _EstadoVazio();
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: meses.length,
                  separatorBuilder: (_, _) {
                    return const SizedBox(height: 14);
                  },
                  itemBuilder: (context, index) {
                    final resumo = meses[index];

                    return Card(
                      elevation: 2,
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () {
                          abrirRelatorio(context, resumo);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 26,
                                    backgroundColor: Color(0xFFE8EDF4),
                                    child: Icon(
                                      Icons.calendar_month,
                                      color: Color(0xFF0B1F3A),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          nomeDoMesReferencia(
                                            resumo.mesReferencia,
                                          ),
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF0B1F3A),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          'Fechado em '
                                          '${formatarData(resumo.fechadoEm)}',
                                          style: const TextStyle(
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.chevron_right,
                                    color: Colors.black45,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 18),
                              const Divider(height: 1),
                              const SizedBox(height: 18),
                              Wrap(
                                spacing: 12,
                                runSpacing: 12,
                                children: [
                                  _InformacaoCard(
                                    icone: Icons.attach_money,
                                    titulo: 'Total',
                                    valor:
                                        'R\$ ${formatarPreco(resumo.totalCentavos)}',
                                  ),
                                  _InformacaoCard(
                                    icone: Icons.receipt_long,
                                    titulo: 'Retiradas',
                                    valor:
                                        resumo.quantidadeRetiradas.toString(),
                                  ),
                                  _InformacaoCard(
                                    icone: Icons.people_outline,
                                    titulo: 'Usuários',
                                    valor:
                                        resumo.quantidadeUsuarios.toString(),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 18),
                              const Row(
                                children: [
                                  Icon(
                                    Icons.lock,
                                    size: 18,
                                    color: Colors.green,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Mês fechado',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    'Abrir relatório',
                                    style: TextStyle(
                                      color: Color(0xFF0B1F3A),
                                      fontWeight: FontWeight.w600,
                                    ),
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
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _InformacaoCard extends StatelessWidget {
  const _InformacaoCard({
    required this.icone,
    required this.titulo,
    required this.valor,
  });

  final IconData icone;
  final String titulo;
  final String valor;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 150),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F9FC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFDDE3EA),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icone,
            color: const Color(0xFF0B1F3A),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                valor,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0B1F3A),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EstadoVazio extends StatelessWidget {
  const _EstadoVazio();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.history,
              size: 90,
              color: Colors.black26,
            ),
            SizedBox(height: 16),
            Text(
              'Nenhum mês foi fechado ainda.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EstadoErro extends StatelessWidget {
  const _EstadoErro({
    required this.erro,
  });

  final String erro;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              size: 70,
              color: Colors.redAccent,
            ),
            const SizedBox(height: 16),
            const Text(
              'Não foi possível carregar o histórico.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              erro,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}