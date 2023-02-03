import 'package:json_annotation/json_annotation.dart';

import '../reflector.dart';

part 'ncm.g.dart';

class NCMWrapper {
  NCM? ncm;
}

@reflector
@JsonSerializable()
class NCM {
  NCM(this.codncm, {this.ncm});

  int codncm;

  @JsonKey(defaultValue: "")
  String? ncm;

  @JsonKey(defaultValue: "")
  String? cest;

  @JsonKey(defaultValue: "")
  String? descricao;

  factory NCM.fromJson(Map<String, dynamic> json) => _$NCMFromJson(json);
  Map<String, dynamic> toJson() => _$NCMToJson(this);

  static NCM fromJsonModel(Map<String, dynamic> json) => NCM.fromJson(json);
}
