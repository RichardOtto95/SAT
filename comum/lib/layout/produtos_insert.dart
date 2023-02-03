import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';

import 'package:comum/models/ioe.dart';
import 'package:comum/models/mesa.dart';
import 'package:comum/models/prod.dart';

import 'package:comum/constantes.dart';
import 'package:comum/custom_properties.dart';
import 'package:comum/custom_widgets.dart';
import 'package:comum/data_structures.dart';
import 'package:comum/sharedpreferences_utils.dart';
import 'package:comum/webservice.dart';

import 'package:comum/layout/utils/base_layout.dart';
import 'package:comum/layout/utils/base_view.dart';

part 'produtos_insert.layout.dart';

class ProdutosInsert extends StatefulWidget {
  ProdutosInsert({Key? key, required this.mesa, required this.prod})
      : super(key: key);
  final Mesa mesa;
  final Prod prod;

  @override
  _ProdutosInsertController createState() => _ProdutosInsertController();
}

class _ProdutosInsertController extends State<ProdutosInsert> {
  TextEditingController _clienteController = TextEditingController();
  TextEditingController _obsController = TextEditingController();
  List<Map<String, String>>? cli;
  double _quant = 1;

  void insert() {
    IOE item = IOE(
        cod: widget.prod.cod,
        id_oe: widget.mesa.id_oe!,
        codfunc: widget.mesa.matr,
        data: widget.mesa.data!,
        id_item: 0,
        produto: widget.prod.produto,
        quant: _quant,
        precodevenda: widget.prod.pvend,
        valor: widget.prod.pvend,
        obs: _obsController.text,
        nome: _clienteController.text,
        lojaentr:
            int.tryParse(PreferenceUtils.getString(Keys.LojaEntrega)) ?? 1);

    Cache.itens!.add(item);

    Navigator.pop(context);
  }

  Future<List<Map<String, String>>> loadClientes() async {
    return await WebService.consultar(
            'mesas/clientes/${widget.mesa.id_oe}/${widget.mesa.data}')
        .then((value) => cli = value);
  }

  Future<List<Map<String, String>>> getClientes(pattern) async {
    List<Map<String, String>> localCli = [];
    Cache.itens!.forEach((element) {
      var duplicado = false;
      cli!.forEach((value) {
        if (element.nome == value['nome']) {
          duplicado = true;
        }
      });

      if (!duplicado) {
        localCli.add(<String, String>{'nome': element.nome ?? 'Consumidor'});
      }
    });

    localCli += cli!;
    return localCli
        .where((element) =>
            element['nome']!.toLowerCase().contains(pattern.toLowerCase()))
        .toList();
  }

  @override
  void initState() {
    loadClientes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => _ProdutosInsertView(this);
}
