import 'dart:io' show Platform;

import 'package:comum/custom_widgets.dart';
import 'package:flutter/foundation.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:comum/models/grupo.dart';
import 'package:comum/models/ioe.dart';
import 'package:comum/models/mesa.dart';
import 'package:comum/models/prod.dart';

import 'package:comum/constantes.dart';
import 'package:comum/custom_properties.dart';
import 'package:comum/data_structures.dart';

import 'package:comum/layout/utils/base_layout.dart';
import 'package:comum/layout/utils/base_view.dart';
import 'produtos_insert.dart';

part 'produtos_selector.layout.dart';

class Produtos extends StatefulWidget {
  const Produtos(
      {Key? key,
      required this.mesa,
      this.limparCache = true,
      this.prod,
      this.dest})
      : super(key: key);

  final bool limparCache;
  final Mesa mesa;
  final int? dest;
  final IOE? prod;
  @override
  _ProdutosController createState() => _ProdutosController();
}

class _ProdutosController extends State<Produtos> {
  int? selectedIndex = 0;
  int grupoIndex = 0;
  int subGrupoIndex = 0;
  bool subVisible = false;
  bool viewGrupos = true;
  List<Prod>? data;
  Prod? selectedProd;
  late FocusNode searchBar;
  final ScrollController _scrollController = ScrollController();
  TextEditingController _controller = TextEditingController();

  void updateSelected(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void queryData() {
    if (viewGrupos) {
      if (grupoIndex > 0) {
        data = data!.where((element) => element.clas == grupoIndex).toList();
        if (subGrupoIndex > 0) {
          data = data!
              .where((element) => element.subclas == subGrupoIndex)
              .toList();
        }
      }
    } else {
      data = data!
          .where((element) =>
              (element.produto ?? '')
                  .toLowerCase()
                  .contains(_controller.text.toLowerCase()) ||
              (element.cod.toString()).contains(_controller.text))
          .toList();
    }
  }

  void search(str) {
    setState(() {});
  }

  void lerCodigoDeBarras() async {
    var prod;

    var barcodeScanRes = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SimpleBarcodeScannerPage(),
        ));

    try {
      //  prod = Cache.prods!.where((prod) => prod.codind == barcodeScanRes).single;
    } catch (e) {
      EasyLoading.showError('Produto não encontrado', dismissOnTap: true);
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProdutosInsert(
          mesa: widget.mesa,
          prod: prod!,
        ),
      ),
    );
  }

  void inserirProduto() async {
    selectedProd = data![selectedIndex ?? 0];
    if (selectedProd == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProdutosInsert(
          mesa: widget.mesa,
          prod: selectedProd!,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    searchBar = FocusNode();
    if (widget.limparCache) Cache.initItens();
  }

  @override
  void dispose() {
    searchBar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _ProdutosView(this);
}
