// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OE _$OEFromJson(Map<String, dynamic> json) => OE(
      json['id_oe'] as int,
      DateTime.parse(json['data'] as String),
    );

const _$OEFieldMap = <String, String>{
  'id_oe': 'id_oe',
  'data': 'data',
};

Map<String, dynamic> _$OEToJson(OE instance) => <String, dynamic>{
      'id_oe': instance.id_oe,
      'data': instance.data.toIso8601String(),
    };
