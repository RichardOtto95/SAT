import 'package:comum/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:comum/constantes.dart';
import 'package:comum/data_structures.dart';
import 'package:comum/webservice.dart';
import 'package:comum/models/mesa.dart';

import 'package:comum/layout/utils/base_layout.dart';
import 'package:comum/layout/utils/base_view.dart';
import 'package:comum/layout/produto_info.dart';
import 'produtos_selector.dart';

part 'produtos_confirmar.layout.dart';

class ProdutosConfirmar extends StatefulWidget {
  ProdutosConfirmar(
      {Key? key,
      required this.mesa,
      required this.id_item,
      this.only_total = false})
      : super(key: key);
  final Mesa mesa;
  final int id_item;
  final bool only_total;
  @override
  _ProdutosConfirmarController createState() => _ProdutosConfirmarController();
}

class _ProdutosConfirmarController extends State<ProdutosConfirmar> {
  double total = 0;

  Future<bool> _onWillPop() async {
    var cancelado = false;
    if (Cache.itens!.isNotEmpty) {
      await showPlatformDialog(
        context: context,
        builder: (_) => PlatformAlertDialog(
          title: Text("Alerta"),
          content: Container(
            child: Text("Tem certeza que deseja cancelar os itens?"),
          ),
          actions: <Widget>[
            PlatformDialogAction(
              child: Text("Não"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            PlatformDialogAction(
              child: Text("Sim"),
              onPressed: () {
                cancelado = true;
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    } else
      return true;

    return cancelado;
  }

  void itemClick(index) async {
    var length = Cache.itens!.length;
    var title = Cache.itens![index].produto;
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Produto_Info(
          mesa: widget.mesa,
          id_item: index,
          title: title!,
          local: true,
          tranferir: false,
        ),
      ),
    );

    if (Cache.itens!.isEmpty) Navigator.pop(context);

    if (length != Cache.itens!.length)
      setState(() {
        calcularTotal();
      });
  }

  void calcularTotal() {
    total = 0;
    Cache.itens!.forEach((element) {
      total += element.valor! * element.quant!;
    });
  }

  void inserirIOE() async {
    var cancelado = true;

    await showPlatformDialog(
      context: context,
      builder: (_) => PlatformAlertDialog(
        title: Text("Pedido"),
        content: Text("Confirma os itens?"),
        actions: <Widget>[
          PlatformDialogAction(
            child: Text("Não"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          PlatformDialogAction(
            child: Text("Sim"),
            onPressed: () {
              cancelado = false;
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );

    if (cancelado) return;

    for (var i = 0; i < Cache.itens!.length; i++) {
      Cache.itens![i].id_item = widget.id_item + i;
    }

    await WebService.insert('mesas/item', jsonString: jsonEncode(Cache.itens));
    Navigator.pop(context);
  }

  void produtoclick() async {
    await Cache.loadProd();
    await Cache.loadGrupo();

    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Produtos(
                  mesa: widget.mesa,
                  limparCache: false,
                )));

    setState(() {
      calcularTotal();
    });
  }

  @override
  void initState() {
    super.initState();
    calcularTotal();
  }

  @override
  Widget build(BuildContext context) => _ProdutosConfirmarView(this);
}
