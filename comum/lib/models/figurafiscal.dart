import 'package:json_annotation/json_annotation.dart';

import '../reflector.dart';

part 'figurafiscal.g.dart';

class FiguraFiscalWrapper {
  FiguraFiscal? figurafiscal;
}

@reflector
@JsonSerializable()
class FiguraFiscal {
  FiguraFiscal(this.codfigurafiscal, {this.descricao});

  int codfigurafiscal;

  String? descricao;

  factory FiguraFiscal.fromJson(Map<String, dynamic> json) =>
      _$FiguraFiscalFromJson(json);
  Map<String, dynamic> toJson() => _$FiguraFiscalToJson(this);

  static FiguraFiscal fromJsonModel(Map<String, dynamic> json) =>
      FiguraFiscal.fromJson(json);
}
