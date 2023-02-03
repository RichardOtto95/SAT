import 'dart:convert';
import 'dart:io' show Platform;

import 'package:comum/custom_widgets.dart';
import 'package:comum/models/figurafiscal.dart';
import 'package:comum/models/ncm.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:comum/models/grupo.dart';
import 'package:comum/webservice.dart';
import 'package:comum/constantes.dart';

import 'package:comum/layout/utils/base_layout.dart';
import 'package:comum/layout/utils/base_view.dart';

import '../models/forn.dart';

part 'forn_busca.layout.dart';

class FornBusca extends StatefulWidget {
  const FornBusca({Key? key, required this.forn}) : super(key: key);
  final FornWrapper forn;

  @override
  // ignore: library_private_types_in_public_api
  _FornBuscaController createState() => _FornBuscaController();
}

class _FornBuscaController extends State<FornBusca> {
  int selectedIndex = 0;
  int page = 0;
  int maxpage = 0;
  Grupo? selected;
  List<Forn>? forn;

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

  Future<List<Forn>> queryData() async {
    var response = await WebService.consultar<String>('forn?page=$page');
    var map = json.decode(response);
    maxpage = map['pages'];
    forn = (map['dados'] as List).map((e) => Forn.fromJson(e)).toList();
    return forn!;
  }

  void initData() async {
    var response = await WebService.consultar<String>('forn');
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
  Widget build(BuildContext context) => _FornBuscaView(this);
}
