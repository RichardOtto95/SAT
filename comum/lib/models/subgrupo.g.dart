// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subgrupo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubGrupo _$SubGrupoFromJson(Map<String, dynamic> json) => SubGrupo(
      json['subclas'] as int,
      clasd: json['clasd'] as String? ?? '',
      dispnoecommerce: json['dispnoecommerce'] as String? ?? 'F',
      clas: json['clas'] as int?,
      pfobm3: (json['pfobm3'] as num?)?.toDouble(),
      marcacao: (json['marcacao'] as num?)?.toDouble(),
      pcustom3: (json['pcustom3'] as num?)?.toDouble(),
    );

const _$SubGrupoFieldMap = <String, String>{
  'subclas': 'subclas',
  'clas': 'clas',
  'pcustom3': 'pcustom3',
  'marcacao': 'marcacao',
  'pfobm3': 'pfobm3',
  'clasd': 'clasd',
  'dispnoecommerce': 'dispnoecommerce',
};

Map<String, dynamic> _$SubGrupoToJson(SubGrupo instance) => <String, dynamic>{
      'subclas': instance.subclas,
      'clas': instance.clas,
      'pcustom3': instance.pcustom3,
      'marcacao': instance.marcacao,
      'pfobm3': instance.pfobm3,
      'clasd': instance.clasd,
      'dispnoecommerce': instance.dispnoecommerce,
    };
