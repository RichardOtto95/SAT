// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:io' show Platform;

import 'package:comum/models/cli.dart';
import 'package:comum/webservice.dart';

import 'package:comum/constantes.dart';
import 'package:comum/custom_widgets.dart';
import 'package:comum/custom_properties.dart';

import 'package:comum/layout/utils/base_layout.dart';
import 'package:comum/layout/utils/base_view.dart';

part 'cli_edit.layout.dart';

class CliEdit extends StatefulWidget {
  const CliEdit({Key? key, required this.cliente}) : super(key: key);

  final CliWrapper cliente;
  @override
  _CliEditController createState() => _CliEditController();
}

class _CliEditController extends State<CliEdit> {
  Cli get cliente => widget.cliente.cli!;
  set cliente(value) => widget.cliente.cli = value;
  Cli? _cli;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<CliController, dynamic> controllers = {
    CliController.CPF: MaskedTextController(mask: '000.000.000-00'),
    CliController.Nome: TextEditingController(),
    CliController.NomeFantasia: TextEditingController(),
    CliController.CEP: TextEditingController(),
    CliController.Endereco: TextEditingController(),
    CliController.Bairro: TextEditingController(),
    CliController.Cidade: TextEditingController(),
    CliController.Estado: TextEditingController(),
    CliController.IBGE: TextEditingController(),
    CliController.Telefone: TextEditingController(),
    CliController.Email: TextEditingController(),
    CliController.INS: TextEditingController(),
  };

  late final Map<CliController, dynamic> climap = {
    CliController.CPF: cliente.cpf ?? '',
    CliController.Nome: cliente.cli ?? '',
    CliController.NomeFantasia: cliente.nomefantasia ?? '',
    CliController.CEP: cliente.cepr ?? '',
    CliController.Endereco: cliente.endr ?? '',
    CliController.Bairro: cliente.bair ?? '',
    CliController.Cidade: cliente.cidr ?? '',
    CliController.Estado: cliente.estr ?? '',
    CliController.IBGE: cliente.ibgecodigodomunicipio ?? '',
    CliController.Telefone: cliente.telr ?? '',
    CliController.Email: cliente.email ?? '',
    CliController.INS: cliente.ins ?? '',
  };

  int indIE = 0;
  int indCon = 0;

  List<String> indIEItems = [
    'Contribuinte ICMS',
    'Contribuinte isento',
    'Não contribuinte'
  ];

  List<String> indConItems = ['Não', 'Consumidor final'];

  void setBindings() {
    controllers[CliController.CPF].beforeChange = (previous, next) {
      final unmasked = next.replaceAll(RegExp(r'[^0-9]'), '');
      _cli!.cpf = unmasked;
      if (unmasked.length <= 11) {
        controllers[CliController.CPF]
            .updateMask('000.000.000-00', shouldMoveCursorToEnd: false);
      } else if (unmasked.length <= 14) {
        controllers[CliController.CPF]
            .updateMask('00.000.000/0000-00', shouldMoveCursorToEnd: false);
      }
      return true;
    };

    controllers[CliController.Nome].addListener(() {
      _cli!.cli = controllers[CliController.Nome].text;
    });
    controllers[CliController.NomeFantasia].addListener(() {
      _cli!.nomefantasia = controllers[CliController.NomeFantasia].text;
    });
    controllers[CliController.CEP].addListener(() {
      _cli!.cepr = controllers[CliController.CEP].text;
    });
    controllers[CliController.Endereco].addListener(() {
      _cli!.endr = controllers[CliController.Endereco].text;
    });
    controllers[CliController.Bairro].addListener(() {
      _cli!.bair = controllers[CliController.Bairro].text;
    });
    controllers[CliController.Cidade].addListener(() {
      _cli!.cidr = controllers[CliController.Cidade].text;
    });
    controllers[CliController.Estado].addListener(() {
      _cli!.estr = controllers[CliController.Estado].text;
    });
    controllers[CliController.IBGE].addListener(() {
      _cli!.ibgecodigodomunicipio =
          int.parse(controllers[CliController.IBGE].text);
    });
    controllers[CliController.Telefone].addListener(() {
      _cli!.telr = controllers[CliController.Telefone].text;
    });
    controllers[CliController.Email].addListener(() {
      _cli!.email = controllers[CliController.Email].text;
    });
    controllers[CliController.INS].addListener(() {
      _cli!.ins = controllers[CliController.INS].text;
    });
  }

  void initData() async {
    _cli = Cli(cliente.codcli);

    controllers.forEach((key, controller) {
      controller.text = '${climap[key]}';
    });
    _cli!.indicadorIEDestinatario =
        indIE = cliente.indicadorIEDestinatario ?? 0;
    _cli!.indFinal = indCon = cliente.indFinal ?? 0;
  }

  void saveClick() async {
    cliente = _cli;
    await WebService.update('clientes', _cli!.toJson());
    Navigator.pop(context);
  }

  @override
  void initState() {
    setBindings();
    initData();
    super.initState();
  }

  @override
  void dispose() {
    controllers.forEach((_, controller) {
      controller.dispose();
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _CliEditView(this);
}
