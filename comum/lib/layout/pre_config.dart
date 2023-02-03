import 'dart:convert';
import 'package:flutter/foundation.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:comum/custom_widgets.dart';
import 'package:comum/sharedpreferences_utils.dart';
import 'package:comum/data_structures.dart';
import 'package:comum/webservice.dart';
import 'package:comum/custom_properties.dart';
import 'package:comum/constantes.dart';
// import 'dart:io' show Platform;
// import 'package:flutter/foundation.dart' show kIsWeb;

import 'elgin_config.dart';
import 'utils/base_layout.dart';

class PreConfig extends StatefulWidget {
  const PreConfig({Key? key}) : super(key: key);

  @override
  _ConfigFormState createState() => _ConfigFormState();
}

class _ConfigFormState extends State<PreConfig> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> controllers = {
    Keys.IP: TextEditingController(),
    Keys.Porta: TextEditingController(),
    // Keys.Banco: TextEditingController(),
    // Keys.Porta_Banco: TextEditingController(),
    // Keys.User: TextEditingController(),
    // Keys.Senha: TextEditingController(),
    // Keys.IPBanco: TextEditingController(),
    // Keys.LojaEntrega: TextEditingController(text: '1'),
    // Keys.LojaVenda: TextEditingController(text: '1'),
  };
  bool get useSSL => PreferenceUtils.getBool(Keys.UseSSL);

  void switchUseSSLOnChanged(bool value) {
    setState(() {
      PreferenceUtils.setBool(Keys.UseSSL, value);
    });
  }

  @override
  void initState() {
    super.initState();
    controllers.forEach((key, controller) {
      controller.text = PreferenceUtils.getString(key);
      if (key == Keys.IP && controller.text.isEmpty) {
        controller.text = 'satweb3.satsistemas.com/SATApi';
      }
      // if (key == Keys.User && controller.text.isEmpty) {
      //   controller.text = 'sysdba';
      // } else if (key == Keys.Senha && controller.text.isEmpty) {
      //   controller.text = 'masterkey';
      // } else if (key == Keys.Porta_Banco && controller.text.isEmpty) {
      //   controller.text = '3050';
      // } else if (key == Keys.IP && controller.text.isEmpty) {
      //   controller.text = 'satweb3.satsistemas.com/SATApi';
      // } else if (key == Keys.Banco && controller.text.isEmpty) {
      //   controller.text = 'C:\\SAT Sistemas\\SAT - Firebird\\SAT TESTES.FDB';
      // }
    });
  }

  @override
  void dispose() {
    controllers.forEach((key, controller) {
      controller.dispose();
    });

    super.dispose();
  }

  static Future<void> testConnection(
      Map<String, TextEditingController> _controllers) async {
    _controllers.forEach((key, controller) {
      PreferenceUtils.setString(key, controller.text);
    });

    await WebService.testConnection().then((value) {
      var decoded = json.decode(value);
      EasyLoading.showInfo('Versão WEB Service: ${decoded['webservice']}',
          dismissOnTap: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: "Configurações",
      resizeToAvoidBottom: true,
      centerTitle: true,
      appBarActions: [
        ElevatedButton(
          onPressed: () {
            controllers.forEach((key, controller) {
              PreferenceUtils.setString(key, controller.text);
            });
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              elevation: 0,
              shadowColor: Colors.transparent,
              shape: const CircleBorder()),
          child: const Text(
            "Salvar",
            style: TextStyle(
              color: Cores.branco,
              fontFamily: 'Oxygen',
            ),
          ),
        ),
      ],
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: EdgeInsets.fromLTRB(
            (MediaQuery.of(context).orientation == Orientation.landscape
                ? 200
                : 10),
            10,
            (MediaQuery.of(context).orientation == Orientation.landscape
                ? 200
                : 10),
            0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Configs(formKey: _formKey, controllers: controllers),
              SizedBox(
                child: SwitchListTile(
                  value: useSSL,
                  onChanged: switchUseSSLOnChanged,
                  title: const Text('Ativar SSL'),
                  activeColor: Cores.azul,
                  hoverColor: Colors.transparent,
                  dense: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: (isElgin
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.center),
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RoundButton(
                      text: 'Testar Conexão',
                      onPressed: () => testConnection(controllers),
                    ),
                    if (isElgin)
                      RoundButton(
                        text: 'Menu Elgin',
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ElginConfig(),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
              Center(
                child: Text(
                  versaoSAT,
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'Oxygen',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Configs extends StatelessWidget {
  Configs({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.controllers,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final Map<String, TextEditingController> controllers;

  final doorFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Wrap(
        runSpacing: 10,
        children: [
          if (!kIsWeb)
            Center(
              child: SelectableText('CHAVE: ${ConnectionData.chave}'),
            ),
          TextFormField(
            decoration: FieldDecorator('IP'),
            controller: controllers[Keys.IP],
            validator: Validators.validarCampoVazio,
            autofocus: true,
            onEditingComplete: () => doorFocus.requestFocus(),
          ),
          TextFormField(
              decoration: FieldDecorator('Porta'),
              controller: controllers[Keys.Porta],
              validator: Validators.validarCampoVazio,
              focusNode: doorFocus,
              onEditingComplete: () =>
                  _ConfigFormState.testConnection(controllers)),
          // TextFormField(
          //   decoration: FieldDecorator(
          //     'IP Banco',
          //   ),
          //   controller: controllers[Keys.IPBanco],
          //   validator: Validators.validarCampoVazio,
          // ),
          // TextFormField(
          //   decoration: FieldDecorator('Banco'),
          //   controller: controllers[Keys.Banco],
          //   validator: Validators.validarCampoVazio,
          // ),
          // TextFormField(
          //   decoration: FieldDecorator('Porta Banco'),
          //   controller: controllers[Keys.Porta_Banco],
          //   validator: Validators.validarCampoVazio,
          // ),
          // TextFormField(
          //   decoration: FieldDecorator('Usuário'),
          //   controller: controllers[Keys.User],
          //   validator: Validators.validarCampoVazio,
          // ),
          // TextFormField(
          //   controller: controllers[Keys.Senha],
          //   obscureText: true,
          //   enableSuggestions: false,
          //   autocorrect: false,
          //   decoration: FieldDecorator('Senha'),
          //   validator: Validators.validarCampoVazio,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Expanded(
          //       child: Padding(
          //         padding: const EdgeInsets.only(right: 5),
          //         child: TextFormField(
          //           controller: controllers[Keys.LojaVenda],
          //           enableSuggestions: false,
          //           autocorrect: false,
          //           maxLength: 50,
          //           keyboardType: TextInputType.number,
          //           inputFormatters: <TextInputFormatter>[
          //             FilteringTextInputFormatter.digitsOnly
          //           ],
          //           decoration: FieldDecorator('Loja da Venda'),
          //           validator: Validators.validarCampoVazio,
          //         ),
          //       ),
          //     ),
          //     Expanded(
          //       child: Padding(
          //         padding: const EdgeInsets.only(left: 5),
          //         child: TextFormField(
          //           controller: controllers[Keys.LojaEntrega],
          //           enableSuggestions: false,
          //           autocorrect: false,
          //           maxLength: 50,
          //           keyboardType: TextInputType.number,
          //           inputFormatters: <TextInputFormatter>[
          //             FilteringTextInputFormatter.digitsOnly
          //           ],
          //           decoration: FieldDecorator('Loja da Entrega'),
          //           validator: Validators.validarCampoVazio,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
