import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/database/app_database.dart';
import '../../repositories/pagamento_repository.dart';
import '../../repositories/usuario_repository.dart';

class PagamentosScreen extends StatefulWidget {
  const PagamentosScreen({super.key});

  @override
  State<PagamentosScreen> createState() => _PagamentosScreenState();
}

class _PagamentosScreenState extends State<PagamentosScreen> {
  final PagamentoRepository pagamentoRepository = PagamentoRepository();
  final UsuarioRepository usuarioRepository = UsuarioRepository();

  late DateTime mesSelecionado;

  @override
  void initState() {
    super.initState();
    final agora = DateTime.now();
    mesSelecionado = DateTime(agora.year, agora.month);
  }

  String get mesReferencia {
    return '${mesSelecionado.year}-'
        '${mesSelecionado.month.toString().padLeft(2, '0')}';
  }

  String formatarMes(DateTime data) {
    return DateFormat('MMMM \'de\' yyyy', 'pt_BR').format(data);
  }

  String formatarPreco(int valorCentavos) {
    final valor = valorCentavos / 100;
    return NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$',
    ).format(valor);
  }

  String formatarData(DateTime? data) {
    if (data == null) return '-';
    return DateFormat('dd/MM/yyyy HH:mm', 'pt_BR').format(data);
  }

  void mudarMes({required bool avancar}) {
    setState(() {
      if (avancar) {
        mesSelecionado = DateTime(
          mesSelecionado.year,
          mesSelecionado.month + 1,
        );
      } else {
        mesSelecionado = DateTime(
          mesSelecionado.year,
          mesSelecionado.month - 1,
        );
      }
    });
  }

  Future<void> selecionarMes() async {
    final hoje = DateTime.now();
    final inicial = mesSelecionado;

    final data = await showDatePicker(
      context: context,
      initialDate: inicial,
      firstDate: DateTime(2000),
      lastDate: DateTime(hoje.year + 10),
      locale: const Locale('pt', 'BR'),
      helpText: 'Selecione o mês',
      fieldLabelText: 'Mês de referência',
    );

    if (data == null || !mounted) return;

    setState(() {
      mesSelecionado = DateTime(data.year, data.month);
    });
  }

  Future<void> registrarPagamentoUsuario(Usuario usuario) async {
    final controladorValor = TextEditingController();
    final controladorData = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()),
    );
    DateTime? dataPagamento = DateTime.now();
    String? erroValor;

    final resumo = await usuarioRepository.calcularResumoMensal(
      usuarioId: usuario.id,
      mesReferencia: mesReferencia,
    );

    if (!mounted) return;

    controladorValor.text = (resumo.totalCentavos / 100).toStringAsFixed(2);

    final messenger = ScaffoldMessenger.of(context);

    final confirmou = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            bool validar() {
              erroValor = null;
              final texto = controladorValor.text.trim();
              if (texto.isEmpty) {
                erroValor = 'Informe o valor.';
              } else {
                final numero = double.tryParse(texto.replaceAll(',', '.'));
                if (numero == null || numero <= 0) {
                  erroValor = 'Valor inválido.';
                }
              }
              return erroValor == null;
            }

            return AlertDialog(
              title: Row(
                children: [
                  const Icon(Icons.payment_outlined),
                  const SizedBox(width: 10),
                  Expanded(child: Text('Pagamento de ${usuario.nome}')),
                ],
              ),
              content: SizedBox(
                width: 440,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0B1F3A).withOpacity( 0.08),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mês: ${formatarMes(mesSelecionado)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Total consumido: ${formatarPreco(resumo.totalCentavos)}',
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Quantidade de retiradas: ${resumo.quantidadeRetiradas}',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: controladorValor,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Valor pago (R\$)',
                        prefixIcon: const Icon(Icons.monetization_on_outlined),
                        border: const OutlineInputBorder(),
                        errorText: erroValor,
                      ),
                      onChanged: (_) {
                        setStateDialog(() {
                          erroValor = null;
                        });
                      },
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: controladorData,
                      decoration: const InputDecoration(
                        labelText: 'Data do pagamento',
                        prefixIcon: Icon(Icons.calendar_today_outlined),
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true,
                      onTap: () async {
                        final data = await showDatePicker(
                          context: dialogContext,
                          initialDate: dataPagamento!,
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now().add(const Duration(days: 1)),
                          locale: const Locale('pt', 'BR'),
                        );
                        if (data != null) {
                          setStateDialog(() {
                            dataPagamento = data;
                            controladorData.text = DateFormat('dd/MM/yyyy').format(data);
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext, false),
                  child: const Text('Cancelar'),
                ),
                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC107),
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    if (!validar()) {
                      setStateDialog(() {});
                      return;
                    }
                    Navigator.pop(dialogContext, true);
                  },
                  icon: const Icon(Icons.check),
                  label: const Text('Confirmar pagamento'),
                ),
              ],
            );
          },
        );
      },
    );

    final textoValor = controladorValor.text.trim();

    if (confirmou != true || !mounted) return;

    final jaExiste = await pagamentoRepository.verificarPagamentoExistente(
      usuarioId: usuario.id,
      mesReferencia: mesReferencia,
    );

    if (jaExiste && mounted) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Este usuário já possui pagamento registrado neste mês.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    try {
      final valor = double.parse(textoValor.replaceAll(',', '.'));
      final valorCentavos = (valor * 100).round();

      await pagamentoRepository.registrarPagamento(
        usuarioId: usuario.id,
        mesReferencia: mesReferencia,
        valorCentavos: valorCentavos,
        pagoEm: dataPagamento,
      );

      if (!mounted) return;

      messenger.showSnackBar(
        SnackBar(
          content: Text('Pagamento de ${usuario.nome} registrado com sucesso.'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (erro) {
      if (!mounted) return;

      final mensagem = erro
          .toString()
          .replaceFirst('Bad state: ', '')
          .replaceFirst('StateError: ', '');

      messenger.showSnackBar(
        SnackBar(content: Text(mensagem), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> removerPagamento(PagamentosMensai pagamento) async {
    final confirmou = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.delete_outline, color: Colors.red),
              SizedBox(width: 10),
              Expanded(child: Text('Remover pagamento')),
            ],
          ),
          content: const Text(
            'Deseja realmente remover este registro de pagamento?\n'
            'Esta ação não pode ser desfeita.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Cancelar'),
            ),
            FilledButton.icon(
              style: FilledButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () => Navigator.pop(dialogContext, true),
              icon: const Icon(Icons.delete_forever),
              label: const Text('Remover'),
            ),
          ],
        );
      },
    );

    if (confirmou != true || !mounted) return;

    final messenger = ScaffoldMessenger.of(context);

    try {
      await pagamentoRepository.removerPagamento(id: pagamento.id);
      if (!mounted) return;

      messenger.showSnackBar(
        const SnackBar(
          content: Text('Pagamento removido.'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (erro) {
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(
          content: Text('Erro ao remover: ${erro.toString()}'),
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Pagamentos mensais'),
        backgroundColor: const Color(0xFF0B1F3A),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 18, 24, 12),
                  child: Row(
                    children: [
                      IconButton.filledTonal(
                        onPressed: () => mudarMes(avancar: false),
                        icon: const Icon(Icons.chevron_left),
                      ),
                      Expanded(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: selecionarMes,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                formatarMes(mesSelecionado),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton.filledTonal(
                        onPressed: () => mudarMes(avancar: true),
                        icon: const Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: StreamBuilder<List<Usuario>>(
                    stream: usuarioRepository.observarUsuarios(),
                    builder: (context, usuariosSnapshot) {
                      if (usuariosSnapshot.hasError) {
                        return _Erro(mensagem: usuariosSnapshot.error.toString());
                      }

                      return StreamBuilder<List<PagamentosMensai>>(
                        stream: pagamentoRepository.observarPagamentosPorMes(
                          mesReferencia: mesReferencia,
                        ),
                        builder: (context, pagamentosSnapshot) {
                          if (pagamentosSnapshot.hasError) {
                            return _Erro(
                              mensagem: pagamentosSnapshot.error.toString(),
                            );
                          }

                          if (!usuariosSnapshot.hasData ||
                              !pagamentosSnapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          final usuarios = usuariosSnapshot.data!;
                          final pagamentos = pagamentosSnapshot.data!;

                          final pagPorUsuario = <int, PagamentosMensai>{
                            for (final p in pagamentos) p.usuarioId: p,
                          };

                          if (usuarios.isEmpty) {
                            return const _Vazio();
                          }

                          final totalArrecadado = pagamentos.fold<int>(
                            0,
                            (sum, p) => sum + p.valorCentavos,
                          );

                          final pagos = usuarios.where(
                            (u) => pagPorUsuario.containsKey(u.id),
                          ).length;

                          return CustomScrollView(
                            slivers: [
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    24,
                                    6,
                                    24,
                                    14,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(18),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF0B1F3A),
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Usuários pagos',
                                                style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                '$pagos / ${usuarios.length}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 26,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              const Text(
                                                'Total arrecadado',
                                                style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                formatarPreco(totalArrecadado),
                                                style: const TextStyle(
                                                  color: Color(0xFFFFC107),
                                                  fontSize: 26,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SliverPadding(
                                padding: const EdgeInsets.fromLTRB(
                                  24,
                                  0,
                                  24,
                                  24,
                                ),
                                sliver: SliverList.separated(
                                  itemCount: usuarios.length,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(height: 10),
                                  itemBuilder: (context, indice) {
                                    final usuario = usuarios[indice];
                                    final pagamento = pagPorUsuario[usuario.id];
                                    final pago = pagamento != null;

                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          color: pago
                                              ? Colors.green.withOpacity( 0.4)
                                              : Colors.black12,
                                        ),
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 54,
                                                height: 54,
                                                decoration: BoxDecoration(
                                                  color: pago
                                                      ? Colors.green
                                                          .withOpacity( 0.12)
                                                      : const Color(0xFFFFC107)
                                                          .withOpacity( 0.15),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  pago
                                                      ? Icons.check_circle
                                                      : Icons.hourglass_empty,
                                                  color: pago
                                                      ? Colors.green
                                                      : const Color(0xFFFFB300),
                                                  size: 30,
                                                ),
                                              ),
                                              const SizedBox(width: 14),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      usuario.nome,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 3),
                                                    Text(
                                                      pago
                                                          ? 'Pago em ${formatarData(pagamento.pagoEm)}  •  ${formatarPreco(pagamento.valorCentavos)}'
                                                          : 'Pendente de pagamento',
                                                      style: TextStyle(
                                                        color: pago
                                                            ? Colors.green
                                                            : Colors.black54,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                    if (pago)
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                          top: 4,
                                                        ),
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            horizontal: 10,
                                                            vertical: 3,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.green
                                                                .withOpacity(
                                                              0.12,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              100,
                                                            ),
                                                          ),
                                                          child: const Text(
                                                            'Confirmado',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                              if (pago)
                                                IconButton(
                                                  tooltip: 'Remover pagamento',
                                                  onPressed: () {
                                                    final p = pagamento;
                                                    removerPagamento(p);
                                                                                                    },
                                                  icon: const Icon(
                                                    Icons.delete_outline,
                                                    color: Colors.redAccent,
                                                  ),
                                                )
                                              else
                                                FilledButton.icon(
                                                  onPressed: () =>
                                                      registrarPagamentoUsuario(
                                                    usuario,
                                                  ),
                                                  style:
                                                      FilledButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(
                                                          0xFFFFC107,
                                                        ),
                                                    foregroundColor:
                                                        Colors.black,
                                                  ),
                                                  icon: const Icon(
                                                    Icons.payment,
                                                    size: 19,
                                                  ),
                                                  label: const Text(
                                                    'Registrar',
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Vazio extends StatelessWidget {
  const _Vazio();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.people_outline, size: 90, color: Colors.black26),
          SizedBox(height: 16),
          Text(
            'Nenhum usuário encontrado.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class _Erro extends StatelessWidget {
  const _Erro({required this.mensagem});

  final String mensagem;

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
              'Não foi possível carregar os pagamentos.',
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
