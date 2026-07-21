import 'package:flutter/material.dart';

import '../../core/database/app_database.dart';
import '../../repositories/estoque_repository.dart';
import '../../repositories/retirada_repository.dart';
import '../../repositories/usuario_repository.dart';
import '../estoque/estoque_screen.dart';
import '../produtos/produtos_screen.dart';
import '../relatorios/relatorios_screen.dart';
import '../usuarios/usuarios_screen.dart';

class AdministradorScreen extends StatefulWidget {
  const AdministradorScreen({super.key});

  @override
  State<AdministradorScreen> createState() => _AdministradorScreenState();
}

class _AdministradorScreenState extends State<AdministradorScreen> {
  final EstoqueRepository estoqueRepository = EstoqueRepository();

  final UsuarioRepository usuarioRepository = UsuarioRepository();

  final RetiradaRepository retiradaRepository = RetiradaRepository();

  String get mesReferencia {
    final agora = DateTime.now();

    return '${agora.year}-'
        '${agora.month.toString().padLeft(2, '0')}';
  }

  String formatarPreco(int valorCentavos) {
    final valor = valorCentavos / 100;

    return valor.toStringAsFixed(2).replaceAll('.', ',');
  }

  bool estoqueBaixo(Produto produto) {
    if (produto.estoqueInicial <= 0) {
      return produto.estoqueAtual <= 0;
    }

    final limite = produto.estoqueInicial * 0.10;

    return produto.estoqueAtual <= limite;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        title: const Text('Administração'),
        backgroundColor: const Color(0xFF0B1F3A),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: StreamBuilder<List<Usuario>>(
          stream: usuarioRepository.observarUsuarios(),
          builder: (context, usuariosSnapshot) {
            if (usuariosSnapshot.hasError) {
              return _EstadoErro(mensagem: usuariosSnapshot.error.toString());
            }

            return StreamBuilder<List<Produto>>(
              stream: estoqueRepository.observarProdutos(),
              builder: (context, produtosSnapshot) {
                if (produtosSnapshot.hasError) {
                  return _EstadoErro(
                    mensagem: produtosSnapshot.error.toString(),
                  );
                }

                return StreamBuilder<List<ResumoUsuarioRelatorio>>(
                  stream: retiradaRepository.observarRelatorioMensal(
                    mesReferencia: mesReferencia,
                  ),
                  builder: (context, relatorioSnapshot) {
                    if (relatorioSnapshot.hasError) {
                      return _EstadoErro(
                        mensagem: relatorioSnapshot.error.toString(),
                      );
                    }

                    if (!usuariosSnapshot.hasData ||
                        !produtosSnapshot.hasData ||
                        !relatorioSnapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final usuarios = usuariosSnapshot.data!;

                    final produtos = produtosSnapshot.data!;

                    final relatorios = relatorioSnapshot.data!;

                    final usuariosAtivos = usuarios
                        .where((usuario) => usuario.ativo)
                        .length;

                    final produtosAtivos = produtos
                        .where((produto) => produto.ativo)
                        .toList();

                    final produtosComEstoqueBaixo = produtosAtivos
                        .where(estoqueBaixo)
                        .length;

                    final faturamentoMes = relatorios.fold<int>(
                      0,
                      (total, resumo) => total + resumo.totalCentavos,
                    );

                    final quantidadeRetiradas = relatorios.fold<int>(
                      0,
                      (total, resumo) => total + resumo.quantidadeRetiradas,
                    );

                    final maiorConsumidor = relatorios.isEmpty
                        ? 'Nenhum consumo'
                        : relatorios.first.nomeUsuario;

                    return Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1000),
                        child: CustomScrollView(
                          slivers: [
                            SliverPadding(
                              padding: const EdgeInsets.fromLTRB(
                                24,
                                24,
                                24,
                                12,
                              ),
                              sliver: SliverToBoxAdapter(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Painel do administrador',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF0B1F3A),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'Visão geral do Bar do Tigre.',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    _ResumoDashboard(
                                      usuariosAtivos: usuariosAtivos,
                                      produtosAtivos: produtosAtivos.length,
                                      produtosComEstoqueBaixo:
                                          produtosComEstoqueBaixo,
                                      faturamentoMes: faturamentoMes,
                                      quantidadeRetiradas: quantidadeRetiradas,
                                      maiorConsumidor: maiorConsumidor,
                                      formatarPreco: formatarPreco,
                                    ),
                                    const SizedBox(height: 28),
                                    const Text(
                                      'Gerenciamento',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF0B1F3A),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SliverPadding(
                              padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                              sliver: SliverLayoutBuilder(
                                builder: (context, constraints) {
                                  final largura = constraints.crossAxisExtent;

                                  final colunas = largura < 600 ? 1 : 2;

                                  return SliverGrid(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: colunas,
                                          crossAxisSpacing: 16,
                                          mainAxisSpacing: 16,
                                          childAspectRatio: colunas == 1
                                              ? 2.4
                                              : 1.55,
                                        ),
                                    delegate: SliverChildListDelegate([
                                      AdminCard(
                                        titulo: 'Usuários',
                                        subtitulo: 'Oficiais e convidados',
                                        icone: Icons.people,
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const UsuariosScreen(),
                                            ),
                                          );
                                        },
                                      ),
                                      AdminCard(
                                        titulo: 'Produtos',
                                        subtitulo: 'Preços e cadastro',
                                        icone: Icons.inventory_2,
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const ProdutosScreen(),
                                            ),
                                          );
                                        },
                                      ),
                                      AdminCard(
                                        titulo: 'Estoque',
                                        subtitulo: produtosComEstoqueBaixo > 0
                                            ? '$produtosComEstoqueBaixo produto(s) com estoque baixo'
                                            : 'Entradas e quantidades',
                                        icone: Icons.warehouse,
                                        alerta: produtosComEstoqueBaixo > 0,
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const EstoqueScreen(),
                                            ),
                                          );
                                        },
                                      ),
                                      AdminCard(
                                        titulo: 'Relatórios',
                                        subtitulo: 'Consumos, PDF e Excel',
                                        icone: Icons.bar_chart,
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const RelatoriosScreen(),
                                            ),
                                          );
                                        },
                                      ),
                                      AdminCard(
                                        titulo: 'Fechamento mensal',
                                        subtitulo: 'Encerrar contas do mês',
                                        icone: Icons.event_available,
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const RelatoriosScreen(),
                                            ),
                                          );
                                        },
                                      ),
                                      AdminCard(
                                        titulo: 'Configurações',
                                        subtitulo: 'PIN, backup e preferências',
                                        icone: Icons.settings,
                                        onTap: () {
                                          mostrarEmDesenvolvimento(
                                            context,
                                            'Configurações',
                                          );
                                        },
                                      ),
                                    ]),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  void mostrarEmDesenvolvimento(BuildContext context, String recurso) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$recurso será desenvolvido em breve.')),
    );
  }
}

class _ResumoDashboard extends StatelessWidget {
  const _ResumoDashboard({
    required this.usuariosAtivos,
    required this.produtosAtivos,
    required this.produtosComEstoqueBaixo,
    required this.faturamentoMes,
    required this.quantidadeRetiradas,
    required this.maiorConsumidor,
    required this.formatarPreco,
  });

  final int usuariosAtivos;
  final int produtosAtivos;
  final int produtosComEstoqueBaixo;
  final int faturamentoMes;
  final int quantidadeRetiradas;
  final String maiorConsumidor;
  final String Function(int) formatarPreco;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final largura = constraints.maxWidth;

        final colunas = largura < 600 ? 1 : 3;

        final cards = [
          _IndicadorCard(
            titulo: 'Usuários ativos',
            valor: usuariosAtivos.toString(),
            icone: Icons.people_outline,
          ),
          _IndicadorCard(
            titulo: 'Produtos ativos',
            valor: produtosAtivos.toString(),
            icone: Icons.inventory_2_outlined,
          ),
          _IndicadorCard(
            titulo: 'Estoque baixo',
            valor: produtosComEstoqueBaixo.toString(),
            icone: Icons.warning_amber_rounded,
            alerta: produtosComEstoqueBaixo > 0,
          ),
          _IndicadorCard(
            titulo: 'Faturamento do mês',
            valor: 'R\$ ${formatarPreco(faturamentoMes)}',
            icone: Icons.attach_money,
          ),
          _IndicadorCard(
            titulo: 'Retiradas no mês',
            valor: quantidadeRetiradas.toString(),
            icone: Icons.receipt_long_outlined,
          ),
          _IndicadorCard(
            titulo: 'Maior consumidor',
            valor: maiorConsumidor,
            icone: Icons.emoji_events_outlined,
          ),
        ];

        return GridView.count(
          crossAxisCount: colunas,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: colunas == 1 ? 3.2 : 1.45,
          children: cards,
        );
      },
    );
  }
}

class _IndicadorCard extends StatelessWidget {
  const _IndicadorCard({
    required this.titulo,
    required this.valor,
    required this.icone,
    this.alerta = false,
  });

  final String titulo;
  final String valor;
  final IconData icone;
  final bool alerta;

  @override
  Widget build(BuildContext context) {
    final cor = alerta ? Colors.red.shade700 : const Color(0xFF0B1F3A);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icone, size: 32, color: cor),
            const SizedBox(height: 10),
            Text(
              titulo,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 6),
            Text(
              valor,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: cor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AdminCard extends StatelessWidget {
  const AdminCard({
    super.key,
    required this.titulo,
    required this.subtitulo,
    required this.icone,
    required this.onTap,
    this.alerta = false,
  });

  final String titulo;
  final String subtitulo;
  final IconData icone;
  final VoidCallback onTap;
  final bool alerta;

  @override
  Widget build(BuildContext context) {
    final cor = alerta ? Colors.red.shade700 : const Color(0xFF0B1F3A);

    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icone, size: 48, color: cor),
              const SizedBox(height: 12),
              Text(
                titulo,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: cor,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subtitulo,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: alerta ? Colors.red.shade700 : Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EstadoErro extends StatelessWidget {
  const _EstadoErro({required this.mensagem});

  final String mensagem;

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
              'Não foi possível carregar o painel.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              mensagem,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
