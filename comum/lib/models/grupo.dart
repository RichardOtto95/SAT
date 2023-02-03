import 'package:json_annotation/json_annotation.dart';

import '../reflector.dart';

part 'grupo.g.dart';

class GrupoWrapper {
  Grupo? grupo;
}

@reflector
@JsonSerializable()
class Grupo {
  Grupo(this.clas,
      {this.clasd,
      this.subgrupo,
      this.garantia,
      this.dispnoecommerce,
      this.alterarnoecommerce});

  int clas;
  String? clasd;
  String? garantia;

  @JsonKey(defaultValue: "F")
  String? dispnoecommerce;

  @JsonKey(defaultValue: "F")
  String? alterarnoecommerce;
  List<Grupo>? subgrupo;

  factory Grupo.fromJson(Map<String, dynamic> json) => _$GrupoFromJson(json);
  Map<String, dynamic> toJson() => _$GrupoToJson(this);

  static Grupo fromJsonModel(Map<String, dynamic> json) => Grupo.fromJson(json);
}
