import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../models/pgto.dart';
import '../models/cli.dart';
import '../models/prod.dart';
import '../models/ioe.dart';
import '../models/oe.dart';
import '../models/param.dart';
import '../models/grupo.dart';
import '../models/mesa.dart';
import '../models/forn.dart';
import '../models/marcas.dart';

import '../models/subgrupo.dart';

import 'sharedpreferences_utils.dart';
import 'constantes.dart';
import 'funcoes.dart';
import 'data_structures.dart';

class MesasListner {
  static Stream<List<Mesa>> start() async* {
    await Models.initParam();
    await ConnectionData.load();
    while (true) {
      await Future.delayed(const Duration(seconds: 1));

      if (!Funcoes.verifyToken()) await WebService.login();

      var protocol = 'http';
      if (PreferenceUtils.getBool(Keys.UseSSL) == true) {
        protocol = 'https';
      }
      final url = Uri.parse(
          '${protocol}://${ConnectionData.data[Keys.IP]}${(ConnectionData.data[Keys.Porta]!.isNotEmpty ? ':' : '')}${ConnectionData.data[Keys.Porta]}/api/v1/mesas');

      var response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json',
        'Authentication': 'Bearer ${TokenData.data[Keys.Token]!}',
        'SAT-BD': LoginData.data[Keys.Empresa]!,
      });
      Cache.mesas = (json.decode(response.body) as List)
          .map((e) => Mesa.fromJson(e))
          .toList();

      yield Cache.mesas!;
    }
  }
}

class WebService {
  static Future<String> login() async {
    ConnectionData.load();
    LoginData.load();

    var protocol = 'http';
    if (PreferenceUtils.getBool(Keys.UseSSL) == true) {
      protocol = 'https';
    }
    try {
      final response = await http
          .post(
              Uri.parse(
                  '${protocol}://${ConnectionData.data[Keys.IP]}${(ConnectionData.data[Keys.Porta]!.isNotEmpty ? ':' : '')}${ConnectionData.data[Keys.Porta]}/api/v1/auth'),
              headers: {"SAT-BD": LoginData.data[Keys.Empresa]!},
              body: jsonEncode(<String, String>{
                Keys.SATPasswd: LoginData.data[Keys.SATPasswd]!,
                Keys.Matr: LoginData.data[Keys.Matr]!,
                Keys.Chave: ConnectionData.chave,
              }))
          .timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException;
        },
      );
      if (response.statusCode == 200) {
        var decoded = json.decode(response.body);

        PreferenceUtils.setString(Keys.Token, decoded[Keys.Token]);
        PreferenceUtils.setString(Keys.Validade, decoded[Keys.Validade]);

        PreferenceUtils.setBool(
          Keys.DELETAR,
          decoded['permissao'][Keys.DELETAR],
        );
        PreferenceUtils.setBool(
          Keys.FINALIZAR,
          decoded['permissao'][Keys.FINALIZAR],
        );

        PreferenceUtils.setString(Keys.IndexCSC, decoded[Keys.IndexCSC]);
        PreferenceUtils.setString(Keys.CSC, decoded[Keys.CSC]);

        return 'conectado';
      } else {
        var decoded = json.decode(response.body);

        return decoded['erro'];
      }
    } on Exception {
      return 'errodeconexao';
    }
  }

  static Future<String> testConnection() async {
    ConnectionData.load();
    var protocol = 'http';
    if (PreferenceUtils.getBool(Keys.UseSSL) == true) {
      protocol = 'https';
    }
    try {
      final response = await http
          .post(
        Uri.parse(
            '${protocol}://${ConnectionData.data[Keys.IP]}${(ConnectionData.data[Keys.Porta]!.isNotEmpty ? ':' : '')}${ConnectionData.data[Keys.Porta]}/api/v1/auth/connection'),
      )
          .timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          throw TimeoutException;
        },
      );
      if (response.statusCode == 200)
        return response.body;
      else
        return '{"webservice":"Falha de conexão"}';
    } on Exception {
      return '{"webservice":"Falha de conexão"}';
    }
  }

  static Future<dynamic> insert(String path,
      {Map<String, dynamic> map = const {}, String jsonString = ''}) async {
    if (!Funcoes.verifyToken())
      await login();
    else
      ConnectionData.load();
    var protocol = 'http';
    if (PreferenceUtils.getBool(Keys.UseSSL) == true) {
      protocol = 'https';
    }
    final url = Uri.parse(
        '${protocol}://${ConnectionData.data[Keys.IP]}${(ConnectionData.data[Keys.Porta]!.isNotEmpty ? ':' : '')}${ConnectionData.data[Keys.Porta]}/api/v1/$path');

    var body;
    if (map.isNotEmpty)
      body = jsonEncode(map);
    else
      body = jsonString;

    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authentication': 'Bearer ${TokenData.data[Keys.Token]!}',
          'SAT-BD': LoginData.data[Keys.Empresa]!,
        },
        body: body);

    var decoded;
    try {
      decoded = json.decode(response.body);
    } catch (e) {
      decoded = [];
    }

    return decoded;
  }

  static Future<bool> delete(
    String path, {
    Map<String, dynamic> body = const {},
  }) async {
    if (!Funcoes.verifyToken())
      await login();
    else
      ConnectionData.load();
    var protocol = 'http';
    if (PreferenceUtils.getBool(Keys.UseSSL) == true) {
      protocol = 'https';
    }
    final url = Uri.parse(
        '${protocol}://${ConnectionData.data[Keys.IP]}${(ConnectionData.data[Keys.Porta]!.isNotEmpty ? ':' : '')}${ConnectionData.data[Keys.Porta]}/api/v1/$path');

    var response = await http.delete(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authentication': 'Bearer ${TokenData.data[Keys.Token]!}',
        'SAT-BD': LoginData.data[Keys.Empresa]!
      },
      body: jsonEncode(body),
    );

    return response.statusCode == 200 ? true : false;
  }

  static Future<dynamic> update(String path, Map<String, dynamic> body) async {
    if (!Funcoes.verifyToken())
      await login();
    else
      ConnectionData.load();
    var protocol = 'http';
    if (PreferenceUtils.getBool(Keys.UseSSL) == true) {
      protocol = 'https';
    }
    final url = Uri.parse(
        '${protocol}://${ConnectionData.data[Keys.IP]}${(ConnectionData.data[Keys.Porta]!.isNotEmpty ? ':' : '')}${ConnectionData.data[Keys.Porta]}/api/v1/$path');

    var response;
    try {
      response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authentication': 'Bearer ${TokenData.data[Keys.Token]!}',
          'SAT-BD': LoginData.data[Keys.Empresa]!
        },
        body: jsonEncode(body),
      );
    } catch (e) {}

    if (response.statusCode == 400 &&
        json.decode(response.body)['erro'].toString().isNotEmpty) {
      return json.decode(response.body)['erro'];
    } else {
      return response.statusCode == 200 ? true : false;
    }
  }

  static Future<dynamic> consultar<T>(String path,
      {String contentType = 'application/json'}) async {
    if (!Funcoes.verifyToken())
      await login();
    else
      ConnectionData.load();
    var protocol = 'http';
    if (PreferenceUtils.getBool(Keys.UseSSL) == true) {
      protocol = 'https';
    }
    final url = Uri.parse(
        '${protocol}://${ConnectionData.data[Keys.IP]}${(ConnectionData.data[Keys.Porta]!.isNotEmpty ? ':' : '')}${ConnectionData.data[Keys.Porta]}/api/v1/$path');

    var response = await http.get(url, headers: <String, String>{
      'Content-Type': contentType,
      'Authentication': 'Bearer ${TokenData.data[Keys.Token]!}',
      'SAT-BD': LoginData.data[Keys.Empresa]!
    });

    switch (T) {
      case Cli:
        return (json.decode(response.body) as List)
            .map((e) => Cli.fromJson(e))
            .toList();
      case Prod:
        return (json.decode(response.body) as List)
            .map((e) => Prod.fromJson(e))
            .toList();
      case SubGrupo:
        return (json.decode(response.body) as List)
            .map((e) => SubGrupo.fromJson(e))
            .toList();
      case IOE:
        return (json.decode(response.body) as List)
            .map((e) => IOE.fromJson(e))
            .toList();
      case OE:
        return (json.decode(response.body) as List)
            .map((e) => OE.fromJson(e))
            .toList();
      case Param:
        return (json.decode(response.body) as List)
            .map((e) => Param.fromJson(e))
            .toList();
      case Mesa:
        return (json.decode(response.body) as List)
            .map((e) => Mesa.fromJson(e))
            .toList();
      case Grupo:
        return (json.decode(response.body) as List)
            .map((e) => Grupo.fromJson(e))
            .toList();
      case Pgto:
        return (json.decode(response.body) as List)
            .map((e) => Pgto.fromJson(e))
            .toList();
      case Marcas:
        return (json.decode(response.body) as List)
            .map((e) => Marcas.fromJson(e))
            .toList();
      case FormasPagamento:
        return (json.decode(response.body) as List)
            .map((e) => FormasPagamento.fromJson(e))
            .toList();
      case String:
        return response.body;
      default:
        return (json.decode(response.body) as List)
            .map((e) => Map<String, String>.from(e))
            .toList();
    }
  }
}
