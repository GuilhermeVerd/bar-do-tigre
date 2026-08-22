import 'package:flutter/material.dart';

import '../../core/database/app_database.dart';
import '../../repositories/estoque_repository.dart';

class HistoricoEstoqueScreen extends StatelessWidget {
  const HistoricoEstoqueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = EstoqueRepository();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        title: const Text('Histórico de Estoque'),
        backgroundColor: const Color(0xFF0B1F3A),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 950),
            child: StreamBuilder<List<MovimentacaoEstoqueDetalhada>>(
              stream: repository.observarMovimentacoes(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return _EstadoErro(erro: snapshot.error.toString());
                }

                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final movimentacoes = snapshot.data!;

                if (movimentacoes.isEmpty) {
                  return const _EstadoVazio();
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: movimentacoes.length,
                  separatorBuilder: (_, __) {
                    return const SizedBox(height: 12);
                  },
                  itemBuilder: (context, index) {
                    return _MovimentacaoCard(
                      movimentacao: movimentacoes[index],
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

class _MovimentacaoCard extends StatelessWidget {
  const _MovimentacaoCard({required this.movimentacao});

  final MovimentacaoEstoqueDetalhada movimentacao;

  bool get entrada {
    return movimentacao.tipo == 'entrada';
  }

  bool get saida {
    return movimentacao.tipo == 'saida';
  }

  String formatarData(DateTime data) {
    final dia = data.day.toString().padLeft(2, '0');
    final mes = data.month.toString().padLeft(2, '0');
    final hora = data.hour.toString().padLeft(2, '0');
    final minuto = data.minute.toString().padLeft(2, '0');

    return '$dia/$mes/${data.year} às $hora:$minuto';
  }

  @override
  Widget build(BuildContext context) {
    final cor = entrada
        ? Colors.green.shade700
        : saida
        ? Colors.red.shade700
        : Colors.orange.shade700;

    final icone = entrada
        ? Icons.add_circle_outline
        : saida
        ? Icons.remove_circle_outline
        : Icons.tune;

    final sinal = entrada
        ? '+'
        : saida
        ? '-'
        : '';

    final tituloTipo = entrada
        ? 'Entrada'
        : saida
        ? 'Saída'
        : 'Ajuste';

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 27,
              backgroundColor: cor.withOpacity( 0.12),
              child: Icon(icone, color: cor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          movimentacao.nomeProduto,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0B1F3A),
                          ),
                        ),
                      ),
                      Text(
                        '$sinal${movimentacao.quantidade}',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: cor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    tituloTipo,
                    style: TextStyle(fontWeight: FontWeight.bold, color: cor),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Estoque: '
                    '${movimentacao.estoqueAnterior} → '
                    '${movimentacao.estoquePosterior}',
                    style: const TextStyle(color: Colors.black87),
                  ),
                  if (movimentacao.nomeUsuario != null &&
                      movimentacao.nomeUsuario!.isNotEmpty) ...[
                    const SizedBox(height: 5),
                    Text(
                      'Usuário: '
                      '${movimentacao.nomeUsuario}',
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                  if (movimentacao.observacao != null &&
                      movimentacao.observacao!.isNotEmpty) ...[
                    const SizedBox(height: 5),
                    Text(
                      movimentacao.observacao!,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                  const SizedBox(height: 8),
                  Text(
                    formatarData(movimentacao.dataHora),
                    style: const TextStyle(fontSize: 12, color: Colors.black45),
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
          Icon(Icons.history, size: 90, color: Colors.black26),
          SizedBox(height: 16),
          Text(
            'Nenhuma movimentação registrada.',
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
        child: Text(
          'Não foi possível carregar o histórico.\n\n'
          '$erro',
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
