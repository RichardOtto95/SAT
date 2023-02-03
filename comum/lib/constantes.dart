// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

String appName = "Atendimento";
String versaoSAT = "211206B";

class Strings {
  static const String CAMPO_VAZIO = "Não pode ser vazio.";
  static const String CPF_INVALIDO = "CPF Inválido.";
  static const String CNPJ_INVALIDO = "CNPJ Inválido.";
}

class Cores {
  static const Color azul = Color(0xFF016eaf);
  static const Color branco = Color(0xFFEEEEEE);
  static const Color verde = Color(0xFF009e2f);
  static const Color vermelho = Color(0xFFe62937);
  static const Color amarelo = Color(0xFFffcb00);
  static const Color azul_claro = Color(0xFF92C1D7);
}

class Keys {
  // Chaves usadas no SharedPreferences.
  static const String IP = 'ip';
  static const String Porta = 'port';
  static const String IPBanco = 'ipbanco';
  static const String Banco = 'bancodados';
  static const String Porta_Banco = 'portabanco';
  static const String User = 'username';
  static const String Senha = 'password';
  static const String Matr = 'matr';
  static const String SATPasswd = 'satpasswd';
  static const String Empresa = 'empresa';
  static const String SalvarSenha = 'salvarsenha';
  static const String UseSSL = 'usessl';
  static const String Token = 'token';
  static const String Validade = 'expire';
  static const String Chave = 'chave';
  static const String DELETAR = 'deletar';
  static const String FINALIZAR = 'finalizar';
  static const String IndexCSC = 'indexCSC';
  static const String CSC = 'CSC';
  static const String OEAtual = 'oeatual';
  static const String OEData = 'oedata';
  static const String LojaVenda = 'lojavenda';
  static const String LojaEntrega = 'lojaentrega';
}

enum CliController {
  CPF,
  Nome,
  NomeFantasia,
  CEP,
  Endereco,
  Bairro,
  Cidade,
  Estado,
  IBGE,
  Telefone,
  Email,
  INS,
}
