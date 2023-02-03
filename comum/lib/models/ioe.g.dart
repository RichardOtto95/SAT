// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ioe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IOE _$IOEFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id_oe'],
  );
  return IOE(
    id_oe: json['id_oe'] as int,
    id_item: json['id_item'] as int,
    data: DateTime.parse(json['data'] as String),
    dataentr: json['dataentr'] == null
        ? null
        : DateTime.parse(json['dataentr'] as String),
    quant: (json['quant'] as num?)?.toDouble(),
    valor: (json['valor'] as num?)?.toDouble(),
    codfunc: json['codfunc'] as int?,
    cod: json['cod'] as int?,
    precodevenda: (json['precodevenda'] as num?)?.toDouble(),
    produto: json['produto'] as String?,
    obs: json['obs'] as String?,
    nome: json['nome'] as String?,
    lojaentr: json['lojaentr'] as int?,
    naocalcularcomissaodogarcom: json['naocalcularcomissaodogarcom'] as String?,
  );
}

const _$IOEFieldMap = <String, String>{
  'id_oe': 'id_oe',
  'data': 'data',
  'dataentr': 'dataentr',
  'cod': 'cod',
  'codfunc': 'codfunc',
  'lojaentr': 'lojaentr',
  'quant': 'quant',
  'id_item': 'id_item',
  'valor': 'valor',
  'precodevenda': 'precodevenda',
  'produto': 'produto',
  'nome': 'nome',
  'obs': 'obs',
  'naocalcularcomissaodogarcom': 'naocalcularcomissaodogarcom',
};

Map<String, dynamic> _$IOEToJson(IOE instance) => <String, dynamic>{
      'id_oe': instance.id_oe,
      'data': instance.data.toIso8601String(),
      'dataentr': instance.dataentr?.toIso8601String(),
      'cod': instance.cod,
      'codfunc': instance.codfunc,
      'lojaentr': instance.lojaentr,
      'quant': instance.quant,
      'id_item': instance.id_item,
      'valor': instance.valor,
      'precodevenda': instance.precodevenda,
      'produto': instance.produto,
      'nome': instance.nome,
      'obs': instance.obs,
      'naocalcularcomissaodogarcom': instance.naocalcularcomissaodogarcom,
    };
