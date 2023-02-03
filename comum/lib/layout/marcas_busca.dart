import 'dart:convert';
import 'dart:io' show Platform;

import 'package:comum/custom_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:comum/models/grupo.dart';

import '../models/marcas.dart';
import '../models/subgrupo.dart';
import 'package:comum/webservice.dart';
import 'package:comum/constantes.dart';

import 'package:comum/layout/utils/base_layout.dart';
import 'package:comum/layout/utils/base_view.dart';

part 'marcas_busca_layout.dart';

class MarcasBusca extends StatefulWidget {
  const MarcasBusca({Key? key, required this.marcas}) : super(key: key);
  final MarcasWrapper marcas;

  @override
  _MarcasBuscaController createState() => _MarcasBuscaController();
}

class _MarcasBuscaController extends State<MarcasBusca> {
  int selectedIndex = 0;
  int page = 0;
  int maxpage = 0;
  Grupo? selected;
  List<Marcas>? cod;

  late FocusNode searchBar;

  void nextPage() {
    setState(() {
      page++;
    });
  }

  void lastPage() {
    setState(() {
      page = maxpage - 1;
    });
  }

  void firstPage() {
    setState(() {
      page = 0;
    });
  }

  void backPage() {
    setState(() {
      page--;
    });
  }

  Future<List<Marcas>> queryData() async {
    var response = await WebService.consultar<String>('marcas?page=$page');
    var map = json.decode(response);
    maxpage = map['pages'];
    cod = (map['dados'] as List).map((e) => Marcas.fromJson(e)).toList();
    return cod!;
  }

  void initData() async {
    var response = await WebService.consultar<String>('marcas');
    var map = json.decode(response);
    setState(() {
      maxpage = map['pages'];
    });
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _MarcasBuscaView(this);
}
