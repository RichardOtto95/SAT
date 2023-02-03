import 'package:json_annotation/json_annotation.dart';

part 'param.g.dart';

@JsonSerializable()
class Param {
  Param(this.param);

  @JsonKey(required: true)
  int param;
  int? restaurantequantidadedemesas;
  double? restaurantecomissaodogarcom;
  int? matr;

  factory Param.fromJson(Map<String, dynamic> json) => _$ParamFromJson(json);
  Map<String, dynamic> toJson() => _$ParamToJson(this);
}
