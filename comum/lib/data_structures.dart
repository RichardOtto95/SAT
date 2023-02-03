import '../models/grupo.dart';
import '../models/ioe.dart';
import '../models/mesa.dart';
import '../models/param.dart';
import '../models/pgto.dart';
import '../models/prod.dart';

import 'sharedpreferences_utils.dart';
import 'constantes.dart';
import 'webservice.dart';

bool isElgin = false;

// Estruturas usadas apenas para carregar os dados do sharedpreferences.
class ConnectionData {
  static String chave = '';
  static Map<String, String> data = {
    Keys.IP: '',
    Keys.Porta: '',
    Keys.IPBanco: '',
    Keys.Banco: '',
    Keys.Porta_Banco: '',
    Keys.User: '',
    Keys.Senha: '',
  };

  static load() async {
    for (var key in data.keys) {
      data[key] = PreferenceUtils.getString(key);
    }
  }
}

class LoginData {
  static Map<String, String> data = {
    Keys.Matr: '',
    Keys.SATPasswd: '',
    Keys.Empresa: '',
  };

  static load() async {
    for (var key in data.keys) {
      data[key] = PreferenceUtils.getString(key);
    }
  }
}

class TokenData {
  static Map<String, String> data = {
    Keys.Token: '',
    Keys.Validade: '',
  };

  static load() async {
    for (var key in data.keys) {
      data[key] = PreferenceUtils.getString(key);
    }
  }
}

class Models {
  static Param? param;

  static Future initParam() async {
    if (param != null) return;

    param = Param(1);
    param?.restaurantecomissaodogarcom = 0;

    await WebService.consultar<Param>('parametros')
        .then((value) => param = value.first);
  }
}

class Cache {
  static List<IOE>? itens;
  static List<Mesa>? mesas;
  static List<Prod>? prods;
  static List<Grupo>? grupos;
  static List<Pgto>? pgtos;
  static List<FormasPagamento>? ents;
  static void initItens() => Cache.itens = <IOE>[];

  static Future<void> loadPgtos(idOe, date) async =>
      pgtos = await WebService.consultar<Pgto>('pagamentos/$idOe/$date');

  static Future<void> loadEnt() async {
    if ((ents ?? []).isNotEmpty) return;
    ents = await WebService.consultar<FormasPagamento>('pagamentos/ents');
  }

  static Future<void> loadProd() async {
    if ((prods ?? []).isNotEmpty) return;
    prods = await WebService.consultar<Prod>('produtos');
  }

  static Future<void> loadGrupo() async {
    if ((grupos ?? []).isNotEmpty) return;
    grupos = await WebService.consultar<Grupo>('produtos/grupos');
  }
}
