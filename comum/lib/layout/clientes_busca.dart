// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'dart:io' show Platform;

import 'package:comum/custom_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:comum/models/cli.dart';
import 'package:comum/webservice.dart';
import 'package:comum/constantes.dart';
import 'package:comum/layout/utils/base_layout.dart';
import 'package:comum/layout/utils/base_view.dart';

part 'clientes_busca.layout.dart';

class ClientesBusca extends StatefulWidget {
  const ClientesBusca({Key? key, required this.cliente}) : super(key: key);
  final CliWrapper cliente;

  @override
  _ClientesBuscaController createState() => _ClientesBuscaController();
}

class _ClientesBuscaController extends State<ClientesBusca> {
  int selectedIndex = 0;
  int page = 0;
  int maxpage = 0;
  Cli? selected;
  List<Cli>? clis;

  late FocusNode searchBar;
  // final TextEditingController _controller = TextEditingController();
  // ValueNotifier<bool> _notifier = ValueNotifier(false);

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

  Future<List<Cli>> queryData() async {
    var response = await WebService.consultar<String>('clientes?page=$page');
    var map = json.decode(response);
    maxpage = map['pages'];
    clis = (map['dados'] as List).map((e) => Cli.fromJson(e)).toList();
    return clis!;
  }

  void initData() async {
    var response = await WebService.consultar<String>('clientes');
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
  Widget build(BuildContext context) => _ClientesBuscaView(this);
}
