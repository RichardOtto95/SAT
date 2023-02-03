import 'dart:convert';
import 'dart:math';

import 'package:comum/custom_widgets.dart';
import 'package:comum/sharedpreferences_utils.dart';
import 'package:comum/webservice.dart';
import 'package:comum/models/pgto.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:smartpos_flutter/models/confirmacoes.dart';
import 'package:smartpos_flutter/models/entrada_transacao.dart';
import 'package:smartpos_flutter/smartpos_flutter.dart';

import 'package:comum/layout/utils/base_view.dart';
import 'package:comum/layout/utils/base_layout.dart';
import 'package:comum/constantes.dart';
import 'package:comum/custom_properties.dart';
import 'package:comum/data_structures.dart';
import 'package:comum/models/mesa.dart';
import 'package:comum/layout/utils/pdf_viwer.dart';

part 'pagamento.layout.dart';

class Pagamento extends StatefulWidget {
  Pagamento({
    Key? key,
    this.mesa,
    this.totalSemAdicionais = 0,
    this.valor = 0,
  }) : super(key: key);

  Mesa? mesa;
  final double? totalSemAdicionais;
  final double? valor;

  @override
  _PagamentoController createState() => _PagamentoController();
}

class _PagamentoController extends State<Pagamento> {
  Mesa get mesa => widget.mesa!;
  set mesa(value) => widget.mesa = value;

  final TextEditingController _parcelas = TextEditingController(text: '1');
  final TextEditingController _emitente = TextEditingController();
  final TextEditingController _associado = TextEditingController();
  final TextEditingController _vencimento = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  final TextEditingController _numeroCH = TextEditingController();
  final _cpfcnpj = MaskedTextController(mask: '000.000.000-00');
  final TextEditingController _codbarras = TextEditingController();
  final TextEditingController _autorizacao = TextEditingController();
  final TextEditingController _valor =
      MoneyMaskedTextController(leftSymbol: 'R\$');
  final TextEditingController _disponivel =
      MoneyMaskedTextController(leftSymbol: 'R\$');

  final _pgtos = [
    'Dinheiro',
    'Cartão',
    'Cheque',
    'Convênio',
    'Vale Troca',
    'Outros'
  ];

  final df = DateFormat('dd/MM/yyyy');

  String _pgtoSelecionado = 'Dinheiro';
  String _tituloHeader = '';
  bool usarComissao = true;
  String codFunc = '';
  int _activePageIndex = 0;
  int ent = 1;
  int id_pg = 0;
  FormasPagamento? _entSelecionado;

  List<FormasPagamento> _ents = [];

  double total = 0;

  double get pago {
    var pg = 0.0;

    for (var pgto in (Cache.pgtos ?? [])) {
      pg = pg + (pgto.valor_pg ?? 0.0);
    }

    return pg;
  }

  double get dif => total - pago;

  void beforeChange(MaskedTextController controller) {
    controller.beforeChange = (previous, next) {
      final unmasked = next.replaceAll(RegExp(r'[^0-9]'), '');
      if (unmasked.length <= 11) {
        controller.updateMask('000.000.000-00', shouldMoveCursorToEnd: false);
      } else if (unmasked.length <= 14) {
        controller.updateMask('00.000.000/0000-00',
            shouldMoveCursorToEnd: false);
      }

      return true;
    };
  }

  void cobrarServico(value) {
    setState(() {
      usarComissao = value;
      widget.mesa!.acrescimo = 0;
      total = widget.mesa!.total!;

      if (usarComissao) {
        widget.mesa!.acrescimo = (total - widget.totalSemAdicionais!) *
            ((Models.param!.restaurantecomissaodogarcom! / 100));

        total = total + widget.mesa!.acrescimo!;
      }

      _valor.text =
          NumberFormat('###0.00', 'pt_br').format((dif > 0 ? dif : 0));
    });
  }

  void changeView() {
    setState(() {
      _activePageIndex = (_activePageIndex == 0 ? 1 : 0);
    });
  }

  void verificarConveniado() async {
    var response = await WebService.consultar<String>(
        'pagamentos/convenio/$ent/${_cpfcnpj.unmasked}');
    var map = json.decode(response);
    codFunc = map['codfunc'].toString();
    setState(() {
      _associado.text = map['NomeAssociado'];
      _disponivel.text =
          NumberFormat('###0.00', 'pt_br').format(map['LimiteDisponivel']);
    });
  }

  void deletarPgto(idPG, index) {
    showPlatformDialog(
      context: context,
      builder: (_) => PlatformAlertDialog(
        title: const Text("Deletar pagamento?"),
        content: const Text("O pagamento será deletado."),
        actions: <Widget>[
          PlatformDialogAction(
            child: const Text("Não"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          PlatformDialogAction(
            child: const Text("Sim"),
            onPressed: () async {
              Navigator.pop(context);
              bool isTEFElgin;
              try {
                isTEFElgin = (Cache.ents ?? [])
                        .where(
                            (element) => element.ent == Cache.pgtos![index].ent)
                        .single
                        .ativartefelginpay ==
                    'S';
              } catch (error) {
                isTEFElgin = false;
              }

              if (isTEFElgin) {
                var isElgin = await ElginPAY.isElginPOS();
                if (!isElgin) {
                  EasyLoading.showError(
                      'Não é possível cancelar pagamento ElginPay por esse dispositivo.',
                      dismissOnTap: true);
                  return;
                }

                var saida = await ElginPAY.iniciarTransacao(
                  EntradaTransacao(
                    operacao: Operacoes.CANCELAMENTO,
                    codigoAutorizacaoOriginal: Cache.pgtos![index].autorizacao,
                    nsuTransacaoOriginal: Cache.pgtos![index].nsuautorizadora,
                    numeroParcelas: 1,
                    dataHoraTransacaoOriginal: DateTime(DateTime.now().year,
                        DateTime.now().month, DateTime.now().day),
                    valorTotal: Cache.pgtos![index].valor_pg!
                        .toStringAsFixed(2)
                        .replaceAll(RegExp(r'[R$,.]'), ''),
                    identificadorTransacaoAutomacao:
                        Random().nextInt(9999).toString(),
                  ),
                );
                var confirmacao = Confirmacoes(
                  identificadorConfirmacaoTransacao:
                      saida.identificadorConfirmacaoTransacao,
                  statusTransacao: StatusTransacao.CONFIRMADO_AUTOMATICO,
                );

                await ElginPAY.confirmaTransacao(confirmacao);

                if ((saida.resultadoTransacao ?? 0) <= 0) {
                  return;
                }
              }

              await WebService.delete(
                      'pagamentos/${mesa.id_oe}/${mesa.data}/$idPG')
                  .then((value) async {
                await Cache.loadPgtos(mesa.id_oe, mesa.data);
                setState(() {
                  if (dif > 0) {
                    _valor.text = NumberFormat('###0.00', 'pt_br').format(dif);
                  } else {
                    _valor.text = '';
                  }
                });
              });
            },
          ),
        ],
      ),
    );
  }

  void pgtoClick(index) {
    if (_pgtos[index] != 'Dinheiro') {
      // ignore: prefer_typing_uninitialized_variables
      var tipo;

      if (_pgtos[index] == 'Cartão') {
        tipo = 'C';
      } else if (_pgtos[index] == 'Cheque') {
        tipo = 'H';
      } else if (_pgtos[index] == 'Convênio') {
        tipo = 'N';
      } else if (_pgtos[index] == 'Vale Troca') {
        tipo = 'V';
      } else if (_pgtos[index] == 'Outros') {
        tipo = 'O';
      }

      _ents = Cache.ents!.where((element) => element.tipo == tipo).toList();

      setState(() {
        _tituloHeader = _pgtos[index];
        _pgtoSelecionado = _ents[0].entd;
        _entSelecionado = _ents[0];
        ent = _ents[0].ent;
      });
    } else {
      setState(() {
        _tituloHeader = _pgtos[index];
        _pgtoSelecionado = _pgtos[index];
      });
    }
  }

  void entClick(index) {
    setState(() {
      _pgtoSelecionado = _ents[index].entd;
      _entSelecionado = _ents[index];
      ent = _ents[index].ent;
    });
  }

  void finalizarVenda() async {
    if ((Cache.pgtos ?? []).isEmpty) {
      EasyLoading.showError('Insira um pagamento antes.', dismissOnTap: true);
      return;
    }

    var emitir = false;
    await showPlatformDialog(
      context: context,
      builder: (_) => PlatformAlertDialog(
        title: const Text("Finalizar venda?"),
        content: const Text("A venda atual será finalizada."),
        actions: <Widget>[
          PlatformDialogAction(
            child: const Text("Não"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          PlatformDialogAction(
            child: const Text("Sim"),
            onPressed: () {
              emitir = true;
              Navigator.pop(context);
              EasyLoading.show(status: 'Emitindo...');
            },
          ),
        ],
      ),
    );

    if (emitir) {
      mesa.troco = (pago > total ? dif.abs() : 0);
      var _mesa = mesa.toJson();
      _mesa.addEntries(<String, String>{
        'userAtual': PreferenceUtils.getString(Keys.Matr)
      }.entries);
      await WebService.update('emitir', _mesa).then(
        (value) {
          if (value is String) {
            EasyLoading.showError(value, dismissOnTap: true);
          } else if (value == true) {
            mesa.reservado = 'fechada';
          }
        },
      );
    } else {
      return;
    }

    if (mesa.reservado != 'fechada') {
      EasyLoading.dismiss();
      return;
    }

    EasyLoading.dismiss();
    var exibirNota = false;

    await showPlatformDialog(
      context: context,
      builder: (_) => PlatformAlertDialog(
        title: const Text("Emitir NFC-e?"),
        content: const Text("A NFC-e será emitida."),
        actions: <Widget>[
          PlatformDialogAction(
            child: const Text("Não"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          PlatformDialogAction(
            child: const Text("Sim"),
            onPressed: () async {
              exibirNota = true;
              Navigator.pop(context);

              await EasyLoading.show(status: 'Emitindo NFC-e...');
            },
          ),
        ],
      ),
    );

    if (exibirNota) {
      String xml = await WebService.consultar<String>(
        'emitir/nfce/${mesa.id_oe}/${mesa.data}',
      );

      if (xml.startsWith('{')) {
        var retJson = json.decode(xml);
        if (retJson.isNotEmpty) {
          if (retJson.containsKey('erro')) {
            EasyLoading.showError(
                'Não foi possível emitir a nota.\n${retJson['erro']}',
                dismissOnTap: true);
            Navigator.pop(context);
            return;
          }
        }
      }

      if (isElgin) {
        if (xml.isEmpty) {
          EasyLoading.showError('Não foi possível emitir a nota.',
              dismissOnTap: true);
          Navigator.pop(context);
          return;
        }
        var indexCSC = PreferenceUtils.getString(Keys.IndexCSC);
        var CSC = PreferenceUtils.getString(Keys.CSC);
        EasyLoading.dismiss();

        await ElginPAY.imprimirNFCe(
          xml: xml,
          indexCSC: int.parse(indexCSC),
          csc: CSC,
          viaCliente: 1,
        );
      } else {
        try {
          var json = await WebService.consultar(
            'emitir/nfce/${mesa.id_oe}/${mesa.data}/chave',
          );

          if (json.isEmpty) {
            await EasyLoading.showError('Não foi possível emitir a nota.',
                dismissOnTap: true);
            Navigator.pop(context);
            return;
          }

          var protocol = 'http';
          if (PreferenceUtils.getBool(Keys.UseSSL) == true) {
            protocol = 'https';
          }
          var url =
              '${protocol}://${ConnectionData.data[Keys.IP]}${(ConnectionData.data[Keys.Porta]!.isNotEmpty ? ':' : '')}${ConnectionData.data[Keys.Porta]}/notas/${json[0]['nfechave']}-nfe.pdf';

          EasyLoading.dismiss();
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PDFViewer(
                title: 'NFC-e',
                url: url,
              ),
            ),
          );
        } on Exception catch (_) {
          await EasyLoading.showError('Não foi possível emitir a nota.',
              dismissOnTap: true);
          Navigator.pop(context);
          return;
        }
      }

      Navigator.pop(context);
    } else {
      Navigator.pop(context);
      return;
    }
  }

  void inserirPagamento() async {
    if (dif == 0 || dif.isNegative) {
      EasyLoading.showError('Pagamentos já inseridos.', dismissOnTap: true);
      return;
    }

    if (_tituloHeader == 'Convênio') {
      verificarConveniado();

      var valor = double.parse(
          _valor.text.replaceAll(RegExp(r'[R$.]'), '').replaceAll(',', '.'));
      var disponivel = double.parse(_disponivel.text
          .replaceAll(RegExp(r'[R$.]'), '')
          .replaceAll(',', '.'));

      if (valor > disponivel) {
        EasyLoading.showError('Limite não disponível.', dismissOnTap: true);
        return;
      } else if (_associado.text.isEmpty || _disponivel.text.isEmpty) {
        EasyLoading.showError('Associado não encontrado.', dismissOnTap: true);
        return;
      }
    }

    Pgto pgto;
    if (_pgtoSelecionado != 'Dinheiro' &&
        (_entSelecionado!.ativartefelginpay ?? 'N') == 'S' &&
        isElgin) {
      await ElginPAY.iniciarTransacao(
        EntradaTransacao(
          operacao: Operacoes.VENDA,
          identificadorTransacaoAutomacao: (mesa.id_oe! + id_pg).toString(),
          valorTotal: _valor.text.replaceAll(RegExp(r'[R$,.]'), ''),
        ),
      ).then((saidaTransacao) async {
        if (saidaTransacao.existeTransacaoPendente == true) {
          await showPlatformDialog(
            context: context,
            builder: (_) => PlatformAlertDialog(
              title: const Text("Erro na Venda!"),
              content: const Text("Deseja confirmar a transação?"),
              actions: <Widget>[
                PlatformDialogAction(
                  child: const Text("Não"),
                  onPressed: () {
                    ElginPAY.resolvePendencia(
                        saidaTransacao.dadosTransacaoPendente!,
                        Confirmacoes(
                            statusTransacao: StatusTransacao.DESFEITO_MANUAL));
                    Navigator.pop(context);
                  },
                ),
                PlatformDialogAction(
                  child: const Text("Sim"),
                  onPressed: () async {
                    ElginPAY.resolvePendencia(
                        saidaTransacao.dadosTransacaoPendente!,
                        Confirmacoes(
                            statusTransacao:
                                StatusTransacao.CONFIRMADO_MANUAL));
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        }
        var confirmacao = Confirmacoes(
          identificadorConfirmacaoTransacao:
              saidaTransacao.identificadorConfirmacaoTransacao,
          statusTransacao: StatusTransacao.CONFIRMADO_AUTOMATICO,
        );

        await ElginPAY.confirmaTransacao(confirmacao);

        if (saidaTransacao.viasImprimir ==
            ViasImpressao.VIA_CLIENTE_E_ESTABELECIMENTO) {
          var comprovante = saidaTransacao.comprovanteGraficoLojista;

          ElginPAY.imprimirImagem(comprovante!);

          showPlatformDialog(
            context: context,
            builder: (_) => PlatformAlertDialog(
              title: const Text("Comprovante Cliente"),
              content: const Text("Deseja imprimir via do Cliente?"),
              actions: <Widget>[
                PlatformDialogAction(
                  child: const Text("Não"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                PlatformDialogAction(
                  child: const Text("Sim"),
                  onPressed: () async {
                    comprovante = saidaTransacao.comprovanteGraficoPortador;

                    ElginPAY.imprimirImagem(comprovante!);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        }

        if ((saidaTransacao.resultadoTransacao ?? -1) >= 0) {
          pgto = Pgto(
            id_oe: mesa.id_oe,
            id_pg: id_pg + 1,
            data: mesa.data,
            ent: ent,
            valor_pg: double.parse(
              _valor.text.substring(2, _valor.text.length).replaceAll(',', '.'),
            ),
            pgtos: saidaTransacao.numeroParcelas.toString(),
            tefexecutado: 'S',
            tef: 'ElginPay',
            cartao: saidaTransacao.nomeCartao,
            cartaonsu: saidaTransacao.nsuTerminal,
            autorizacao: saidaTransacao.codigoAutorizacao,
            operadora: saidaTransacao.nomeProvedor,
            nsuautorizadora: saidaTransacao.nsuTransacao,
          );

          Cache.pgtos!.add(pgto);
          WebService.insert('pagamentos', map: pgto.toJson());
        }
      });
    } else {
      pgto = Pgto(
        id_oe: mesa.id_oe,
        id_pg: id_pg + 1,
        data: mesa.data,
        pgtos: _parcelas.text,
        ent: ent,
        valor_pg: double.parse(
          _valor.text.substring(2, _valor.text.length).replaceAll(',', '.'),
        ),
      );
      if (_tituloHeader == 'Cheque') {
        pgto.nome = _emitente.text;
        pgto.data_pg = DateTime.parse(_vencimento.text);
        pgto.doc = _numeroCH.text;
      } else if (_tituloHeader == 'Convênio') {
        pgto.doc = _cpfcnpj.unmasked;
        pgto.codfunc = codFunc;
      } else if (_tituloHeader == 'Vale Troca') {
        pgto.doc = _codbarras.text;
      } else if (_tituloHeader == 'Outros') {
        pgto.data_pg = DateTime.parse(_vencimento.text);
        pgto.doc = _autorizacao.text;
      }

      Cache.pgtos!.add(pgto);
      WebService.insert('pagamentos', map: pgto.toJson());
    }

    setState(() {
      if (dif > 0) {
        _valor.text = NumberFormat('###0.00', 'pt_br').format(dif);
      } else {
        _valor.text = '';
      }
    });
  }

  @override
  void initState() {
    cobrarServico(true);

    _valor.text = NumberFormat('###0.00', 'pt_br').format((dif > 0 ? dif : 0));

    // total = widget.mesa!.total!;
    // _valor.text = NumberFormat('###0.00', 'pt_br')
    //     .format((widget.valor == 0 ? total : widget.valor));

    beforeChange(_cpfcnpj);
    super.initState();
  }

  @override
  void dispose() {
    _valor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _PagamentoView(this);
}
