import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'package:comum/sharedpreferences_utils.dart';
import 'package:comum/webservice.dart';
import 'package:comum/constantes.dart';
import 'package:comum/custom_properties.dart';
import 'dart:io' show Platform;
import '../utilities/utilities.dart';
import 'utils/base_view.dart';
import 'pre_config.dart';

part 'login.layout.dart';

class Login extends StatefulWidget {
  const Login({Key? key, required this.destination}) : super(key: key);
  final Widget destination;

  @override
  _LoginController createState() => _LoginController();
}

class _LoginController extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController matrController = TextEditingController();
  final TextEditingController passwdController = TextEditingController();
  final TextEditingController empresaController = TextEditingController();
  late final Widget logo;
  late bool senhaCarregada;

  bool get switchSenha => PreferenceUtils.getBool(Keys.SalvarSenha);

  void switchSenhaOnChanged(bool value) {
    setState(() {
      PreferenceUtils.setBool(Keys.SalvarSenha, value);
    });
  }

  void loginClick() async {
    saveLogin();

    if (senhaCarregada == false) {
      var pw = passwdController.text.toUpperCase();
      var ipw = 0;
      for (var i = 0; i < pw.length; i++) {
        ipw = ipw + ((pw.codeUnitAt(i) * (10 - (i + 1))) - 9);
      }
      var hash = sha256.convert(utf8.encode(ipw.toString()));
      PreferenceUtils.setString(Keys.SATPasswd, hash.toString());
    }

    EasyLoading.show(status: 'Logando...');
    await WebService.login().then(
      (value) {
        if (value == 'conectado') {
          EasyLoading.dismiss();
          saveLogin();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => widget.destination,
            ),
          );
        } else if (value == 'errodeconexao') {
          EasyLoading.dismiss();
          EasyLoading.showError('Erro de conexão.', dismissOnTap: true);
        } else {
          EasyLoading.dismiss();
          EasyLoading.showError(
              value.isNotEmpty ? value : 'Matrícula e/ou senha incorretos.',
              dismissOnTap: true);
        }
      },
    );
  }

  void configClick() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const PreConfig()));
  }

  void loadLogin() {
    if (switchSenha) {
      matrController.text = PreferenceUtils.getString(Keys.Matr);
      passwdController.text = PreferenceUtils.getString(Keys.SATPasswd);
      if (passwdController.text.length > 8) {
        passwdController.text = passwdController.text.substring(0, 8);
      }
      empresaController.text = PreferenceUtils.getString(Keys.Empresa);
      senhaCarregada = true;
    } else {
      PreferenceUtils.remove(Keys.Matr);
      PreferenceUtils.remove(Keys.SATPasswd);
      PreferenceUtils.remove(Keys.Empresa);
      senhaCarregada = false;
    }
  }

  void textFieldOnChange(String value) {
    saveLogin();
  }

  void senhaFieldOnChange(String value) {
    senhaCarregada = false;
  }

  void saveLogin() {
    PreferenceUtils.setString(Keys.Matr, matrController.text);
    PreferenceUtils.setString(Keys.Empresa, empresaController.text);
  }

  @override
  void initState() {
    loadLogin();
    super.initState();
  }

  @override
  void dispose() {
    matrController.dispose();
    passwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _LoginView(this);
}
