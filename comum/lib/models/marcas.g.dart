// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marcas.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Marcas _$MarcasFromJson(Map<String, dynamic> json) => Marcas(
      json['cod'] as int,
      marca: json['marca'] as String? ?? '',
      dispnoecommerce: json['dispnoecommerce'] as String? ?? 'F',
    );

const _$MarcasFieldMap = <String, String>{
  'cod': 'cod',
  'marca': 'marca',
  'dispnoecommerce': 'dispnoecommerce',
};

Map<String, dynamic> _$MarcasToJson(Marcas instance) => <String, dynamic>{
      'cod': instance.cod,
      'marca': instance.marca,
      'dispnoecommerce': instance.dispnoecommerce,
    };
