// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Param _$ParamFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['param'],
  );
  return Param(
    json['param'] as int,
  )
    ..restaurantequantidadedemesas =
        json['restaurantequantidadedemesas'] as int?
    ..restaurantecomissaodogarcom =
        (json['restaurantecomissaodogarcom'] as num?)?.toDouble()
    ..matr = json['matr'] as int?;
}

const _$ParamFieldMap = <String, String>{
  'param': 'param',
  'restaurantequantidadedemesas': 'restaurantequantidadedemesas',
  'restaurantecomissaodogarcom': 'restaurantecomissaodogarcom',
  'matr': 'matr',
};

Map<String, dynamic> _$ParamToJson(Param instance) => <String, dynamic>{
      'param': instance.param,
      'restaurantequantidadedemesas': instance.restaurantequantidadedemesas,
      'restaurantecomissaodogarcom': instance.restaurantecomissaodogarcom,
      'matr': instance.matr,
    };
