// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'ioe.g.dart';

@JsonSerializable()
class IOE {
  IOE(
      {required this.id_oe,
      required this.id_item,
      required this.data,
      this.dataentr,
      this.quant,
      this.valor,
      this.codfunc,
      this.cod,
      this.precodevenda,
      this.produto,
      this.obs,
      this.nome,
      this.lojaentr,
      this.naocalcularcomissaodogarcom});

  @JsonKey(required: true)
  int id_oe;
  DateTime data;
  DateTime? dataentr;
  int? cod;
  int? codfunc;
  int? lojaentr;
  double? quant;
  int id_item;
  double? valor;
  double? precodevenda;
  String? produto;
  String? nome;
  String? obs;
  String? naocalcularcomissaodogarcom;

  factory IOE.fromJson(Map<String, dynamic> json) => _$IOEFromJson(json);
  Map<String, dynamic> toJson() => _$IOEToJson(this);
}
