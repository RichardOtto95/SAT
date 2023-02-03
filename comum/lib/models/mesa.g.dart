// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mesa.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mesa _$MesaFromJson(Map<String, dynamic> json) => Mesa(
      json['pedido'] as int,
      data:
          json['data'] == null ? null : DateTime.parse(json['data'] as String),
      codcli: json['codcli'] as int?,
      matr: json['matr'] as int?,
      total: (json['total'] as num?)?.toDouble(),
      reservado: json['reservado'] as String?,
      cli: json['cli'] == null
          ? null
          : Cli.fromJson(json['cli'] as Map<String, dynamic>),
      loja: json['loja'] as int?,
    )
      ..id_oe = json['id_oe'] as int?
      ..acrescimo = (json['acrescimo'] as num?)?.toDouble()
      ..troco = (json['troco'] as num?)?.toDouble()
      ..cpf = json['cpf'] as String?
      ..garcom = json['garcom'] as String?
      ..obs = json['obs'] as String?;

const _$MesaFieldMap = <String, String>{
  'pedido': 'pedido',
  'data': 'data',
  'id_oe': 'id_oe',
  'codcli': 'codcli',
  'matr': 'matr',
  'loja': 'loja',
  'total': 'total',
  'acrescimo': 'acrescimo',
  'cli': 'cli',
  'troco': 'troco',
  'cpf': 'cpf',
  'garcom': 'garcom',
  'reservado': 'reservado',
  'obs': 'obs',
};

Map<String, dynamic> _$MesaToJson(Mesa instance) => <String, dynamic>{
      'pedido': instance.pedido,
      'data': instance.data?.toIso8601String(),
      'id_oe': instance.id_oe,
      'codcli': instance.codcli,
      'matr': instance.matr,
      'loja': instance.loja,
      'total': instance.total,
      'acrescimo': instance.acrescimo,
      'cli': instance.cli,
      'troco': instance.troco,
      'cpf': instance.cpf,
      'garcom': instance.garcom,
      'reservado': instance.reservado,
      'obs': instance.obs,
    };
