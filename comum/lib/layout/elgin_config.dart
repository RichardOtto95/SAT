import 'dart:io';
import 'dart:math';

import 'package:comum/custom_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smartpos_flutter/models/confirmacoes.dart';
import 'package:smartpos_flutter/models/entrada_transacao.dart';
import 'package:smartpos_flutter/smartpos_flutter.dart';

import 'package:comum/constantes.dart';

import 'utils/base_layout.dart';

class ElginConfig extends StatefulWidget {
  const ElginConfig({Key? key}) : super(key: key);

  @override
  _PostConfigFormState createState() => _PostConfigFormState();
}

class _PostConfigFormState extends State<ElginConfig> {
  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: "Menu Elgin",
      resizeToAvoidBottom: true,
      titleSize: MediaQuery.of(context).size.width * 0.05,
      centerTitle: true,
      rodape: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height *
            (kIsWeb ? 0.03 : (Platform.isIOS ? 0.06 : 0.03)),
        child: Text(
          versaoSAT,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: 'Oxygen',
          ),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Wrap(
              direction: Axis.vertical,
              spacing: 10,
              children: [
                RoundButton(
                  text: 'Cancelamento',
                  onPressed: () async {
                    var saida = await ElginPAY.iniciarTransacao(
                      EntradaTransacao(
                        operacao: Operacoes.CANCELAMENTO,
                        identificadorTransacaoAutomacao:
                            Random().nextInt(999).toString(),
                      ),
                    );
                    var confirmacao = Confirmacoes(
                      identificadorConfirmacaoTransacao:
                          saida.identificadorConfirmacaoTransacao,
                      statusTransacao: StatusTransacao.CONFIRMADO_AUTOMATICO,
                    );
                    await ElginPAY.confirmaTransacao(confirmacao);
                  },
                ),
                RoundButton(
                  text: 'Reimpressão',
                  onPressed: () async {
                    var saida = await ElginPAY.iniciarTransacao(
                      EntradaTransacao(
                        operacao: Operacoes.REIMPRESSAO,
                        identificadorTransacaoAutomacao:
                            Random().nextInt(999).toString(),
                      ),
                    );

                    var confirmacao = Confirmacoes(
                      identificadorConfirmacaoTransacao:
                          saida.identificadorConfirmacaoTransacao,
                      statusTransacao: StatusTransacao.CONFIRMADO_AUTOMATICO,
                    );

                    await ElginPAY.confirmaTransacao(confirmacao);

                    if ((saida.comprovanteGraficoLojista ?? '').isNotEmpty) {
                      var comprovante = saida.comprovanteGraficoLojista;

                      ElginPAY.imprimirImagem(comprovante!);
                    } else if ((saida.comprovanteGraficoPortador ?? '')
                        .isNotEmpty) {
                      var comprovante = saida.comprovanteGraficoPortador;

                      ElginPAY.imprimirImagem(comprovante!);
                    } else {
                      List<String> comprovante =
                          saida.comprovanteCompleto!.cast<String>();

                      ElginPAY.imprimirStrings(comprovante);
                    }
                  },
                ),
                RoundButton(
                  text: 'Instalação',
                  onPressed: () async {
                    var saida = await ElginPAY.iniciarTransacao(
                      EntradaTransacao(
                        operacao: Operacoes.INSTALACAO,
                        identificadorTransacaoAutomacao:
                            Random().nextInt(999).toString(),
                      ),
                    );
                    var confirmacao = Confirmacoes(
                      identificadorConfirmacaoTransacao:
                          saida.identificadorConfirmacaoTransacao,
                      statusTransacao: StatusTransacao.CONFIRMADO_AUTOMATICO,
                    );
                    await ElginPAY.confirmaTransacao(confirmacao);
                  },
                ),
                RoundButton(
                  text: 'Manutenção',
                  onPressed: () async {
                    var saida = await ElginPAY.iniciarTransacao(
                      EntradaTransacao(
                        operacao: Operacoes.MANUTENCAO,
                        identificadorTransacaoAutomacao:
                            Random().nextInt(999).toString(),
                      ),
                    );
                    var confirmacao = Confirmacoes(
                      identificadorConfirmacaoTransacao:
                          saida.identificadorConfirmacaoTransacao,
                      statusTransacao: StatusTransacao.CONFIRMADO_AUTOMATICO,
                    );
                    await ElginPAY.confirmaTransacao(confirmacao);
                  },
                ),
                RoundButton(
                  text: 'Administrativo',
                  onPressed: () async {
                    var saida = await ElginPAY.iniciarTransacao(
                      EntradaTransacao(
                        operacao: Operacoes.ADMINISTRATIVA,
                        identificadorTransacaoAutomacao:
                            Random().nextInt(999).toString(),
                      ),
                    );

                    var confirmacao = Confirmacoes(
                      identificadorConfirmacaoTransacao:
                          saida.identificadorConfirmacaoTransacao,
                      statusTransacao: StatusTransacao.CONFIRMADO_AUTOMATICO,
                    );

                    await ElginPAY.confirmaTransacao(confirmacao);

                    if ((saida.comprovanteGraficoLojista ?? '').isNotEmpty) {
                      var comprovante = saida.comprovanteGraficoLojista;

                      ElginPAY.imprimirImagem(comprovante!);
                    } else if ((saida.comprovanteGraficoPortador ?? '')
                        .isNotEmpty) {
                      var comprovante = saida.comprovanteGraficoPortador;

                      ElginPAY.imprimirImagem(comprovante!);
                    } else {
                      List<String> comprovante =
                          saida.comprovanteCompleto!.cast<String>();

                      ElginPAY.imprimirStrings(comprovante);
                    }
                  },
                ),
                RoundButton(
                  text: 'Teste Impressão',
                  onPressed: () async {
                    ElginPAY.imprimirStrings(<String>[
                      'Teste Impressão',
                      'SAT Sistemas',
                      DateTime.now().toString(),
                    ]);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
