// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'oe.g.dart';

@JsonSerializable()
class OE {
  OE(this.id_oe, this.data);

  int id_oe;
  DateTime data;

  factory OE.fromJson(Map<String, dynamic> json) => _$OEFromJson(json);
  Map<String, dynamic> toJson() => _$OEToJson(this);
}
