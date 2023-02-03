import 'package:json_annotation/json_annotation.dart';

import '../reflector.dart';

part 'marcas.g.dart';

class MarcasWrapper {
  Marcas? marcas;
}

@reflector
@JsonSerializable()
class Marcas {
  Marcas(this.cod, {this.marca, this.dispnoecommerce});

  int cod;

  @JsonKey(defaultValue: "")
  String? marca;

  @JsonKey(defaultValue: "F")
  String? dispnoecommerce;

  factory Marcas.fromJson(Map<String, dynamic> json) => _$MarcasFromJson(json);
  Map<String, dynamic> toJson() => _$MarcasToJson(this);

  static Marcas fromJsonModel(Map<String, dynamic> json) =>
      Marcas.fromJson(json);
}
