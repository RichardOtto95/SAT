// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';

import 'package:comum/models/ioe.dart';
import 'package:comum/models/mesa.dart';

import 'package:comum/constantes.dart';
import 'package:comum/data_structures.dart';
import 'package:comum/webservice.dart';
import 'package:comum/sharedpreferences_utils.dart';

import 'package:comum/layout/utils/base_layout.dart';
import 'package:comum/layout/utils/base_view.dart';

part 'produto_info.layout.dart';

class Produto_Info extends StatefulWidget {
  const Produto_Info({
    Key? key,
    required this.mesa,
    required this.id_item,
    required this.title,
    this.local = false,
    this.tranferir = true,
    this.excluir = true,
  }) : super(key: key);
  final Mesa mesa;
  final String title;
  final bool local;
  final int id_item;
  final bool tranferir;
  final bool excluir;
  @override
  _Produto_InfoController createState() => _Produto_InfoController();
}

class _Produto_InfoController extends State<Produto_Info> {
  IOE? item;

  Future<IOE> _load() async {
    if (!widget.local) {
      var prod;
      try {
        await WebService.consultar<IOE>(
                'mesas/item/${widget.mesa.id_oe}/${widget.mesa.data}/${widget.id_item}')
            .then((value) => prod = value.single);
      } catch (e) {
        await showPlatformDialog(
            context: context,
            builder: (_) => PlatformAlertDialog(
                  title: const Text("Erro"),
                  content: const Text("Item não encontrado."),
                  actions: <Widget>[
                    PlatformDialogAction(
                      child: const Text("OK"),
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ));
        Navigator.pop(context);
      }

      return prod;
    } else
      return Cache.itens![widget.id_item];
  }

  void moveItem() async {
    var cancelado = true;
    await showPlatformDialog(
      context: context,
      builder: (_) => PlatformAlertDialog(
        title: Text("Mover item"),
        content: Text("Mover item atual para outro atendimento?"),
        actions: <Widget>[
          PlatformDialogAction(
            child: Text("Não"),
            onPressed: () {
              cancelado = true;
              Navigator.pop(context);
            },
          ),
          PlatformDialogAction(
            child: Text("Sim"),
            onPressed: () async {
              cancelado = false;
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );

    if (cancelado) return;
    cancelado = true;

    var dest = 1;

    await showPlatformDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return PlatformAlertDialog(
              title: Text("Atendimento Destino"),
              content: Container(
                  height: MediaQuery.of(context).size.height *
                      (Cache.mesas!.length * 0.06),
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      for (var i = 0; i < Cache.mesas!.length; i++)
                        if ((Cache.mesas![i].pedido != widget.mesa.pedido) &&
                            (Cache.mesas![i].reservado == 'O'))
                          i
                    ].map<Card>((e) {
                      return Card(
                        elevation: 0,
                        child: InkWell(
                          onTap: () {
                            dest = Cache.mesas![e].pedido;
                            cancelado = false;
                            Navigator.pop(context);
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  'Atendimento ${NumberFormat('00').format(Cache.mesas![e].pedido)}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Oxygen',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  )),
              actions: <Widget>[
                PlatformDialogAction(
                  child: Text("Cancelar"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      },
    );

    if (cancelado) return;

    await WebService.update('mesas/item/update', <String, dynamic>{
      'id_oe': item!.id_oe,
      'data': item!.data.toIso8601String(),
      'id_item': item!.id_item,
      'pedido': dest,
      'obs':
          '${(item!.obs?.isEmpty ?? true) ? '' : '${item!.obs}\n'}Transferido do atendimento ${NumberFormat('000').format(widget.mesa.pedido)}${(widget.mesa.garcom?.isEmpty ?? true) ? '.' : ' pelo atendente ${widget.mesa.garcom}.'}',
    }).then((value) async {
      if (!value) {
        await showPlatformDialog(
          context: context,
          builder: (_) => PlatformAlertDialog(
            title: const Text('Atendimento destino fechado'),
            content: const Text(
                'Não foi possível mover o item.\nAtendimento destino não está aberto.'),
            actions: <Widget>[
              PlatformDialogAction(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      } else {
        Navigator.pop(context);
      }
    });
  }

  void deleteItem() async {
    showPlatformDialog(
      context: context,
      builder: (_) => PlatformAlertDialog(
        title: Text("Deletar item"),
        content: Text("Deletar item atual?\nAção não pode ser desfeita."),
        actions: <Widget>[
          PlatformDialogAction(
            child: Text("Não"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          PlatformDialogAction(
            child: Text("Sim"),
            onPressed: () async {
              if (!widget.local) {
                await WebService.delete('mesas/item', body: <String, dynamic>{
                  'id_oe': item!.id_oe,
                  'id_item': item!.id_item,
                  'data': item!.data.toIso8601String(),
                }).then((value) async {
                  if (!value) {
                    await showPlatformDialog(
                      context: context,
                      builder: (_) => PlatformAlertDialog(
                        title: Text('Item já deletado'),
                        content: Text('Este item já foi deletado.'),
                        actions: <Widget>[
                          PlatformDialogAction(
                            child: Text("OK"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  } else
                    Navigator.pop(context);
                });
              } else {
                Cache.itens!.removeAt(widget.id_item);
                Navigator.pop(context);
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => _Produto_InfoView(this);
}
