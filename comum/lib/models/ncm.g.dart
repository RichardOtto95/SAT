// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ncm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NCM _$NCMFromJson(Map<String, dynamic> json) => NCM(
      json['codncm'] as int,
      ncm: json['ncm'] as String? ?? '',
    )
      ..cest = json['cest'] as String? ?? ''
      ..descricao = json['descricao'] as String? ?? '';

const _$NCMFieldMap = <String, String>{
  'codncm': 'codncm',
  'ncm': 'ncm',
  'cest': 'cest',
  'descricao': 'descricao',
};

Map<String, dynamic> _$NCMToJson(NCM instance) => <String, dynamic>{
      'codncm': instance.codncm,
      'ncm': instance.ncm,
      'cest': instance.cest,
      'descricao': instance.descricao,
    };
