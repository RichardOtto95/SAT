import 'package:json_annotation/json_annotation.dart';
import '../reflector.dart';

part 'subgrupo.g.dart';

class SubGrupoWrapper {
  SubGrupo? subgrupo;
}

@reflector
@JsonSerializable()
class SubGrupo {
  SubGrupo(this.subclas,
      {this.clasd,
      this.dispnoecommerce,
      this.clas,
      this.pfobm3,
      this.marcacao,
      this.pcustom3});

  int subclas;
  int? clas;

  double? pcustom3;
  double? marcacao;
  double? pfobm3;

  @JsonKey(defaultValue: "")
  String? clasd;

  @JsonKey(defaultValue: "F")
  String? dispnoecommerce;

  factory SubGrupo.fromJson(Map<String, dynamic> json) =>
      _$SubGrupoFromJson(json);
  Map<String, dynamic> toJson() => _$SubGrupoToJson(this);

  static SubGrupo fromJsonModel(Map<String, dynamic> json) =>
      SubGrupo.fromJson(json);
}
