import 'package:flutter/material.dart';

import '../../core/database/app_database.dart';
import '../../repositories/retirada_repository.dart';

class MeuConsumoScreen extends StatefulWidget {
  const MeuConsumoScreen({
    super.key,
    required this.usuarioId,
    required this.nomeUsuario,
  });

  final int usuarioId;
  final String nomeUsuario;

  @override
  State<MeuConsumoScreen> createState() => _MeuConsumoScreenState();
}

class _MeuConsumoScreenState extends State<MeuConsumoScreen> {
  final RetiradaRepository repository = RetiradaRepository();

  late DateTime mesSelecionado;

  @override
  void initState() {
    super.initState();
    mesSelecionado = DateTime.now();
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

    return mesSelecionado.year < agora.year ||
        mesSelecionado.month < agora.month;
  }

  String formatarPreco(int valorCentavos) {
    final valor = valorCentavos / 100;

    return valor.toStringAsFixed(2).replaceAll('.', ',');
  }

  String formatarData(DateTime dataHora) {
    final dia = dataHora.day.toString().padLeft(2, '0');
    final mes = dataHora.month.toString().padLeft(2, '0');
    final ano = dataHora.year.toString();

    return '$dia/$mes/$ano';
  }

  String formatarHora(DateTime dataHora) {
    final hora = dataHora.hour.toString().padLeft(2, '0');
    final minuto = dataHora.minute.toString().padLeft(2, '0');

    return '$hora:$minuto';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        title: const Text('Meu consumo'),
        backgroundColor: const Color(0xFF0B1F3A),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: StreamBuilder<List<RetiradaMeuConsumo>>(
            stream: repository.observarConsumoDoUsuario(
              usuarioId: widget.usuarioId,
              mesReferencia: mesReferencia,
            ),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      'Erro ao carregar o consumo:\n'
                      '${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }

              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final retiradas = snapshot.data!;

              final totalDoMes = retiradas.fold<int>(
                0,
                (total, retirada) => total + retirada.totalCentavos,
              );

              return Column(
                children: [
                  _SeletorMes(
                    titulo:
                        '${nomeDoMes(mesSelecionado.month)} '
                        '${mesSelecionado.year}',
                    aoVoltar: mesAnterior,
                    aoAvancar: podeAvancarMes ? proximoMes : null,
                  ),
                  _ResumoMensal(
                    nomeUsuario: widget.nomeUsuario,
                    totalDoMesCentavos: totalDoMes,
                    quantidadeRetiradas: retiradas.length,
                    formatarPreco: formatarPreco,
                  ),
                  Expanded(
                    child: retiradas.isEmpty
                        ? const _EstadoVazio()
                        : ListView.separated(
                            padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                            itemCount: retiradas.length,
                            separatorBuilder: (_, __) {
                              return const SizedBox(height: 14);
                            },
                            itemBuilder: (context, index) {
                              final retirada = retiradas[index];

                              return _CardRetirada(
                                retirada: retirada,
                                formatarPreco: formatarPreco,
                                formatarData: formatarData,
                                formatarHora: formatarHora,
                              );
                            },
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
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
                fontSize: 20,
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
      ),
    );
  }
}

class _ResumoMensal extends StatelessWidget {
  const _ResumoMensal({
    required this.nomeUsuario,
    required this.totalDoMesCentavos,
    required this.quantidadeRetiradas,
    required this.formatarPreco,
  });

  final String nomeUsuario;
  final int totalDoMesCentavos;
  final int quantidadeRetiradas;
  final String Function(int) formatarPreco;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFF0B1F3A),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            nomeUsuario,
            style: const TextStyle(color: Colors.white70, fontSize: 18),
          ),
          const SizedBox(height: 10),
          const Text(
            'Total consumido no mês',
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
          const SizedBox(height: 6),
          Text(
            'R\$ ${formatarPreco(totalDoMesCentavos)}',
            style: const TextStyle(
              color: Color(0xFFFFC107),
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '$quantidadeRetiradas retirada(s) registrada(s)',
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class _CardRetirada extends StatelessWidget {
  const _CardRetirada({
    required this.retirada,
    required this.formatarPreco,
    required this.formatarData,
    required this.formatarHora,
  });

  final RetiradaMeuConsumo retirada;
  final String Function(int) formatarPreco;
  final String Function(DateTime) formatarData;
  final String Function(DateTime) formatarHora;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        leading: const CircleAvatar(
          backgroundColor: Color(0xFFE8EDF4),
          child: Icon(Icons.receipt_long, color: Color(0xFF0B1F3A)),
        ),
        title: Text(
          '${formatarData(retirada.dataHora)} '
          'às ${formatarHora(retirada.dataHora)}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${retirada.itens.length} produto(s)'),
        trailing: Text(
          'R\$ ${formatarPreco(retirada.totalCentavos)}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0B1F3A),
          ),
        ),
        children: [
          const Divider(height: 1),
          ...retirada.itens.map((item) {
            return ListTile(
              title: Text(item.nomeProduto),
              subtitle: Text('Quantidade: ${item.quantidade}'),
              trailing: Text('R\$ ${formatarPreco(item.subtotalCentavos)}'),
            );
          }),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.receipt_long_outlined, size: 80, color: Colors.black26),
          SizedBox(height: 16),
          Text(
            'Nenhum consumo registrado neste mês.',
            style: TextStyle(fontSize: 20, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
