// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pgto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pgto _$PgtoFromJson(Map<String, dynamic> json) => Pgto(
      id_oe: json['id_oe'] as int?,
      id_pg: json['id_pg'] as int?,
      data_pg: json['data_pg'] == null
          ? null
          : DateTime.parse(json['data_pg'] as String),
      autorizacao: json['autorizacao'] as String?,
      cartao: json['cartao'] as String?,
      cartaonsu: json['cartaonsu'] as String?,
      cnpjcredenciadora: json['cnpjcredenciadora'] as String?,
      codfunc: json['codfunc'] as String?,
      data:
          json['data'] == null ? null : DateTime.parse(json['data'] as String),
      doc: json['doc'] as String?,
      ent: json['ent'] as int?,
      nome: json['nome'] as String?,
      nsuautorizadora: json['nsuautorizadora'] as String?,
      operacao: json['operacao'] as String?,
      operadora: json['operadora'] as String?,
      pgtos: json['pgtos'] as String?,
      tefexecutado: json['tefexecutado'] as String?,
      valor_pg: (json['valor_pg'] as num?)?.toDouble(),
      tef: json['tef'] as String?,
    )..dep = json['dep'] as String?;

const _$PgtoFieldMap = <String, String>{
  'id_oe': 'id_oe',
  'id_pg': 'id_pg',
  'data': 'data',
  'data_pg': 'data_pg',
  'ent': 'ent',
  'valor_pg': 'valor_pg',
  'pgtos': 'pgtos',
  'tefexecutado': 'tefexecutado',
  'doc': 'doc',
  'tef': 'tef',
  'autorizacao': 'autorizacao',
  'cartaonsu': 'cartaonsu',
  'nsuautorizadora': 'nsuautorizadora',
  'codfunc': 'codfunc',
  'nome': 'nome',
  'cartao': 'cartao',
  'operadora': 'operadora',
  'operacao': 'operacao',
  'cnpjcredenciadora': 'cnpjcredenciadora',
  'dep': 'dep',
};

Map<String, dynamic> _$PgtoToJson(Pgto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id_oe', instance.id_oe);
  writeNotNull('id_pg', instance.id_pg);
  writeNotNull('data', instance.data?.toIso8601String());
  writeNotNull('data_pg', instance.data_pg?.toIso8601String());
  writeNotNull('ent', instance.ent);
  writeNotNull('valor_pg', instance.valor_pg);
  writeNotNull('pgtos', instance.pgtos);
  writeNotNull('tefexecutado', instance.tefexecutado);
  writeNotNull('doc', instance.doc);
  writeNotNull('tef', instance.tef);
  writeNotNull('autorizacao', instance.autorizacao);
  writeNotNull('cartaonsu', instance.cartaonsu);
  writeNotNull('nsuautorizadora', instance.nsuautorizadora);
  writeNotNull('codfunc', instance.codfunc);
  writeNotNull('nome', instance.nome);
  writeNotNull('cartao', instance.cartao);
  writeNotNull('operadora', instance.operadora);
  writeNotNull('operacao', instance.operacao);
  writeNotNull('cnpjcredenciadora', instance.cnpjcredenciadora);
  writeNotNull('dep', instance.dep);
  return val;
}

FormasPagamento _$FormasPagamentoFromJson(Map<String, dynamic> json) =>
    FormasPagamento(
      json['ent'] as int,
      json['entd'] as String,
      json['tipo'] as String?,
      json['ativartefelginpay'] as String?,
    );

const _$FormasPagamentoFieldMap = <String, String>{
  'ent': 'ent',
  'entd': 'entd',
  'tipo': 'tipo',
  'ativartefelginpay': 'ativartefelginpay',
};

Map<String, dynamic> _$FormasPagamentoToJson(FormasPagamento instance) {
  final val = <String, dynamic>{
    'ent': instance.ent,
    'entd': instance.entd,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('tipo', instance.tipo);
  writeNotNull('ativartefelginpay', instance.ativartefelginpay);
  return val;
}
