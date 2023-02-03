import 'dart:convert';
import 'dart:io' show Platform;

import 'package:comum/custom_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:comum/models/grupo.dart';

import '../models/subgrupo.dart';
import 'package:comum/webservice.dart';
import 'package:comum/constantes.dart';

import 'package:comum/layout/utils/base_layout.dart';
import 'package:comum/layout/utils/base_view.dart';

part 'subgrupo_busca.layout.dart';

class SubGruposBusca extends StatefulWidget {
  const SubGruposBusca({Key? key, required this.subgrupo}) : super(key: key);
  final SubGrupoWrapper subgrupo;

  @override
  _SubGrupoBuscaController createState() => _SubGrupoBuscaController();
}

class _SubGrupoBuscaController extends State<SubGruposBusca> {
  int selectedIndex = 0;
  int page = 0;
  int maxpage = 0;
  Grupo? selected;
  List<SubGrupo>? subclas;

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

  Future<List<SubGrupo>> queryData() async {
    var response = await WebService.consultar<String>('subgrupos?page=$page');
    var map = json.decode(response);
    maxpage = map['pages'];
    subclas = (map['dados'] as List).map((e) => SubGrupo.fromJson(e)).toList();
    return subclas!;
  }

  void initData() async {
    var response = await WebService.consultar<String>('subgrupos');
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
  Widget build(BuildContext context) => _SubGruposBuscaView(this);
}
