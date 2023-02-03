import 'package:flutter/material.dart';
import 'constantes.dart';

// Propieades personalizadas utilizadas nos widgets.

class Validators {
  static String? validarCampoVazio(String? value) {
    if (value!.isEmpty) return Strings.CAMPO_VAZIO;

    return null;
  }

  static String? validarCPFnotRequired(String? cpf) {
    if (cpf == null || cpf.isEmpty) return null;

    var numeros = cpf.replaceAll(RegExp(r'[^0-9]'), '');

    if (numeros.length != 11) return Strings.CPF_INVALIDO;

    if (RegExp(r'^(\d)\1*$').hasMatch(numeros)) return Strings.CPF_INVALIDO;

    List<int> digitos =
        numeros.split('').map((String d) => int.parse(d)).toList();

    var calcDv1 = 0;
    for (var i in Iterable<int>.generate(9, (i) => 10 - i)) {
      calcDv1 += digitos[10 - i] * i;
    }
    calcDv1 %= 11;
    var dv1 = calcDv1 < 2 ? 0 : 11 - calcDv1;

    if (digitos[9] != dv1) return Strings.CPF_INVALIDO;

    var calcDv2 = 0;
    for (var i in Iterable<int>.generate(10, (i) => 11 - i)) {
      calcDv2 += digitos[11 - i] * i;
    }
    calcDv2 %= 11;
    var dv2 = calcDv2 < 2 ? 0 : 11 - calcDv2;

    if (digitos[10] != dv2) return Strings.CPF_INVALIDO;

    return null;
  }

  static String? validarCNPJnotRequired(String? cnpj) {
    if (cnpj == null || cnpj.isEmpty) return null;

    var numeros = cnpj.replaceAll(RegExp(r'[^0-9]'), '');

    if (numeros.length != 14) return Strings.CNPJ_INVALIDO;

    if (RegExp(r'^(\d)\1*$').hasMatch(numeros)) return Strings.CNPJ_INVALIDO;

    List<int> digitos =
        numeros.split('').map((String d) => int.parse(d)).toList();

    var calcDv1 = 0;
    var j = 0;
    for (var i in Iterable<int>.generate(12, (i) => i < 4 ? 5 - i : 13 - i)) {
      calcDv1 += digitos[j++] * i;
    }
    calcDv1 %= 11;
    var dv1 = calcDv1 < 2 ? 0 : 11 - calcDv1;

    if (digitos[12] != dv1) return Strings.CNPJ_INVALIDO;

    var calcDv2 = 0;
    j = 0;
    for (var i in Iterable<int>.generate(13, (i) => i < 5 ? 6 - i : 14 - i)) {
      calcDv2 += digitos[j++] * i;
    }
    calcDv2 %= 11;
    var dv2 = calcDv2 < 2 ? 0 : 11 - calcDv2;

    if (digitos[13] != dv2) return Strings.CNPJ_INVALIDO;

    return null;
  }
}

class FieldDecorator extends InputDecoration {
  FieldDecorator(label, {fillColor = Cores.branco, hint = '', suffixIcon})
      : super(
          suffixIcon: suffixIcon,
          //labelText: label,
          hintText: hint,
          counterText: '',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          label: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Text(label),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
            borderRadius: BorderRadius.circular(11),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
            borderRadius: BorderRadius.circular(11),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
            borderRadius: BorderRadius.circular(11),
          ),
          filled: true,
          isDense: true,
          labelStyle: const TextStyle(color: Cores.azul),
          fillColor: fillColor,
        );
}

class DisableScrollGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
