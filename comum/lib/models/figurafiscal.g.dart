// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'figurafiscal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FiguraFiscal _$FiguraFiscalFromJson(Map<String, dynamic> json) => FiguraFiscal(
      json['codfigurafiscal'] as int,
      descricao: json['descricao'] as String?,
    );

const _$FiguraFiscalFieldMap = <String, String>{
  'codfigurafiscal': 'codfigurafiscal',
  'descricao': 'descricao',
};

Map<String, dynamic> _$FiguraFiscalToJson(FiguraFiscal instance) =>
    <String, dynamic>{
      'codfigurafiscal': instance.codfigurafiscal,
      'descricao': instance.descricao,
    };
