import 'dart:convert';
import 'dart:io' show Platform;

import 'package:comum/custom_widgets.dart';
import 'package:comum/models/figurafiscal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:comum/models/grupo.dart';

import '../models/prod.dart';
import '../models/subgrupo.dart';
import 'package:comum/webservice.dart';
import 'package:comum/constantes.dart';

import 'package:comum/layout/utils/base_layout.dart';
import 'package:comum/layout/utils/base_view.dart';

part 'figurafiscal_busca_layout.dart';

class FiguraFiscalBusca extends StatefulWidget {
  const FiguraFiscalBusca({Key? key, required this.figurafiscal})
      : super(key: key);
  final FiguraFiscalWrapper figurafiscal;

  @override
  _FiguraFiscalBuscaController createState() => _FiguraFiscalBuscaController();
}

class _FiguraFiscalBuscaController extends State<FiguraFiscalBusca> {
  int selectedIndex = 0;
  int page = 0;
  int maxpage = 0;
  Grupo? selected;
  List<FiguraFiscal>? codfigurafiscal;

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

  Future<List<FiguraFiscal>> queryData() async {
    var response =
        await WebService.consultar<String>('figurafiscal?page=$page');
    var map = json.decode(response);
    maxpage = map['pages'];
    codfigurafiscal =
        (map['dados'] as List).map((e) => FiguraFiscal.fromJson(e)).toList();
    return codfigurafiscal!;
  }

  void initData() async {
    var response = await WebService.consultar<String>('figurafiscal');
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
