// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grupo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Grupo _$GrupoFromJson(Map<String, dynamic> json) => Grupo(
      json['clas'] as int,
      clasd: json['clasd'] as String?,
      subgrupo: (json['subgrupo'] as List<dynamic>?)
          ?.map((e) => Grupo.fromJson(e as Map<String, dynamic>))
          .toList(),
      garantia: json['garantia'] as String?,
      dispnoecommerce: json['dispnoecommerce'] as String? ?? 'F',
      alterarnoecommerce: json['alterarnoecommerce'] as String? ?? 'F',
    );

const _$GrupoFieldMap = <String, String>{
  'clas': 'clas',
  'clasd': 'clasd',
  'garantia': 'garantia',
  'dispnoecommerce': 'dispnoecommerce',
  'alterarnoecommerce': 'alterarnoecommerce',
  'subgrupo': 'subgrupo',
};

Map<String, dynamic> _$GrupoToJson(Grupo instance) => <String, dynamic>{
      'clas': instance.clas,
      'clasd': instance.clasd,
      'garantia': instance.garantia,
      'dispnoecommerce': instance.dispnoecommerce,
      'alterarnoecommerce': instance.alterarnoecommerce,
      'subgrupo': instance.subgrupo,
    };
