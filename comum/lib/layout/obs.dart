import 'package:flutter/material.dart';
import 'package:comum/models/mesa.dart';

import 'package:comum/constantes.dart';
import 'package:comum/custom_properties.dart';
import 'package:comum/webservice.dart';

import 'package:comum/layout/utils/base_layout.dart';
import 'package:comum/layout/utils/base_view.dart';

part 'obs.layout.dart';

class Obs extends StatefulWidget {
  const Obs({Key? key, required this.mesa}) : super(key: key);
  final Mesa mesa;
  @override
  _ObsController createState() => _ObsController();
}

class _ObsController extends State<Obs> {
  final _focusnode = FocusNode();
  final TextEditingController _obsController = TextEditingController();

  void updateCPF() async {
    widget.mesa.obs = _obsController.text;
    WebService.update('mesas', <String, dynamic>{
      "id_oe": widget.mesa.id_oe,
      "data": widget.mesa.data!.toIso8601String(),
      "obs": widget.mesa.obs,
    });

    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _obsController.text = widget.mesa.obs ?? '';
    _focusnode.addListener(() {
      if (_focusnode.hasFocus) {
        _obsController.selection = TextSelection(
            baseOffset: 0, extentOffset: _obsController.value.text.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) => _ObsView(this);
}
