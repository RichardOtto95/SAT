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

part 'ncm_busca.layout.dart';

class NCMBusca extends StatefulWidget {
  const NCMBusca({Key? key, required this.ncm}) : super(key: key);
  final NCMWrapper ncm;

  @override
  _NCMBuscaController createState() => _NCMBuscaController();
}

class _NCMBuscaController extends State<NCMBusca> {
  int selectedIndex = 0;
  int page = 0;
  int maxpage = 0;
  Grupo? selected;
  List<NCM>? codncm;

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

  Future<List<NCM>> queryData() async {
    var response =
        await WebService.consultar<String>('produtos/ncm?page=$page');
    var map = json.decode(response);
    maxpage = map['pages'];
    codncm = (map['dados'] as List).map((e) => NCM.fromJson(e)).toList();
    return codncm!;
  }

  void initData() async {
    var response = await WebService.consultar<String>('produtos/ncm');
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
