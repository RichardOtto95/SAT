import 'package:json_annotation/json_annotation.dart';

part 'cli.g.dart';

class CliWrapper {
  Cli? cli;
}

@JsonSerializable()
class Cli {
  Cli(
    this.codcli, {
    this.cli,
    this.nomefantasia,
    this.cpf,
    this.ins,
    this.endr,
    this.bair,
    this.cepr,
    this.cidr,
    this.estr,
    this.telr,
    this.email,
    this.ibgecodigodomunicipio,
    this.indicadorIEDestinatario,
    this.indFinal,
  });

  int codcli;
  String? cli;
  String? nomefantasia;
  String? cpf;
  String? ins;
  String? endr;
  String? bair;
  String? cepr;
  String? cidr;
  String? estr;
  String? telr;
  String? email;
  int? ibgecodigodomunicipio;
  int? indicadorIEDestinatario;
  int? indFinal;

  factory Cli.fromJson(Map<String, dynamic> json) => _$CliFromJson(json);
  Map<String, dynamic> toJson() => _$CliToJson(this);

  static Cli fromJsonModel(Map<String, dynamic> json) => Cli.fromJson(json);
}
