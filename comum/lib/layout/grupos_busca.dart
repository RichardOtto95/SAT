import 'dart:convert';
import 'dart:io' show Platform;

import 'package:comum/custom_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:comum/models/grupo.dart';

import 'package:comum/models/cli.dart';
import 'package:comum/webservice.dart';
import 'package:comum/constantes.dart';
import 'package:comum/custom_properties.dart';
import 'package:comum/data_structures.dart';

import 'package:comum/layout/utils/base_layout.dart';
import 'package:comum/layout/utils/base_view.dart';
import '../models/grupo.dart';
import 'produtos_insert.dart';

part 'grupos_busca.layout.dart';

class GruposBusca extends StatefulWidget {
  const GruposBusca({Key? key, required this.grupo}) : super(key: key);
  final GrupoWrapper grupo;

  @override
  _GrupoBuscaController createState() => _GrupoBuscaController();
}

class _GrupoBuscaController extends State<GruposBusca> {
  int selectedIndex = 0;
  int page = 0;
  int maxpage = 0;
  Grupo? selected;
  List<Grupo>? clas;

  late FocusNode searchBar;
  TextEditingController _controller = TextEditingController();
  ValueNotifier<bool> _notifier = ValueNotifier(false);

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

  Future<List<Grupo>> queryData() async {
    var response = await WebService.consultar<String>('grupos?page=$page');
    var map = json.decode(response);
    maxpage = map['pages'];
    clas = (map['dados'] as List).map((e) => Grupo.fromJson(e)).toList();
    return clas!;
  }

  void initData() async {
    var response = await WebService.consultar<String>('grupos');
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
  Widget build(BuildContext context) => _GruposBuscaView(this);
}
