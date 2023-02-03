import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:comum/models/cli.dart';
import 'package:comum/models/mesa.dart';

import 'package:comum/constantes.dart';
import 'package:comum/custom_widgets.dart';
import 'package:comum/custom_properties.dart';
import 'package:comum/webservice.dart';

import 'package:comum/layout/cli_edit.dart';
import 'package:comum/layout/clientes_busca.dart';
import 'package:comum/layout/utils/base_layout.dart';
import 'package:comum/layout/utils/base_view.dart';

part 'clientes.layout.dart';

class Clientes extends StatefulWidget {
  const Clientes({Key? key, required this.mesa, this.cliente})
      : super(key: key);
  final Mesa mesa;
  final Cli? cliente;
  @override
  _ClientesController createState() => _ClientesController();
}

class _ClientesController extends State<Clientes> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _focusnode = FocusNode();
  final _cpfcontroller = MaskedTextController(mask: '000.000.000-00');
  final _nomecontroller = TextEditingController(text: 'Consumidor');
  final _nomefancontroller = TextEditingController();

  var cliwrap = CliWrapper();

  void beforeChange(MaskedTextController controller) {
    controller.beforeChange = (previous, next) {
      final unmasked = next.replaceAll(RegExp(r'[^0-9]'), '');
      if (unmasked.length <= 11)
        controller.updateMask('000.000.000-00', shouldMoveCursorToEnd: false);
      else if (unmasked.length <= 14)
        controller.updateMask('00.000.000/0000-00',
            shouldMoveCursorToEnd: false);

      return true;
    };
  }

  void updateCPF() async {
    if (!_formKey.currentState!.validate()) return;

    if (widget.cliente == null) {
      await WebService.update('mesas', <String, dynamic>{
        "id_oe": widget.mesa.id_oe,
        "data": widget.mesa.data!.toIso8601String(),
        "codcli": cliwrap.cli?.codcli,
      }).then((value) {
        if (value) {
          Navigator.pop(context);
        }
      });
    } else {
      widget.cliente!.codcli = cliwrap.cli?.codcli ?? 1;
      widget.cliente!.cli = _nomecontroller.text;
      widget.cliente!.cpf = _cpfcontroller.text;
      Navigator.pop(context);
    }
  }

  void updateValores() {
    setState(() {
      if (widget.cliente != null) {
        widget.cliente!.codcli = cliwrap.cli?.codcli ?? 1;
      }
      _cpfcontroller.text = cliwrap.cli!.cpf ?? '';
      _nomecontroller.text = cliwrap.cli!.cli ?? '';
      _nomefancontroller.text = cliwrap.cli!.nomefantasia ?? '';
    });
  }

  @override
  void initState() {
    if (widget.cliente == null) {
      var cpf = widget.mesa.cli?.cpf ?? '';
      if (cpf.length <= 11)
        _cpfcontroller.updateMask('000.000.000-00',
            shouldMoveCursorToEnd: false);
      else if (cpf.length <= 14)
        _cpfcontroller.updateMask('00.000.000/0000-00',
            shouldMoveCursorToEnd: false);
      _cpfcontroller.text = cpf;
    }

    beforeChange(_cpfcontroller);

    super.initState();

    _focusnode.addListener(() {
      if (_focusnode.hasFocus) {
        _nomecontroller.selection = TextSelection(
            baseOffset: 0, extentOffset: _nomecontroller.value.text.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) => _ClientesView(this);
}
