import 'package:json_annotation/json_annotation.dart';

part 'forn.g.dart';

class FornWrapper {
  Forn? forn;
}

@JsonSerializable()
class Forn {
  Forn(this.forn,
      {this.nome,
      this.razao,
      this.email,
      this.cgc,
      this.ins,
      this.cont,
      this.repr,
      this.nire,
      this.inscricaomunicipal,
      this.tel,
      this.foner,
      this.fax,
      this.faxr,
      this.ende,
      this.complemento,
      this.pais,
      this.cep,
      this.estado,
      this.bairro,
      this.cidade,
      this.site,
      this.trans,
      this.ibgecodigodomunicipio,
      this.codigodopais});

  int? forn;

  @JsonKey(defaultValue: "")
  String? nome;

  @JsonKey(defaultValue: "")
  String? razao;

  @JsonKey(defaultValue: "")
  String? email;

  @JsonKey(defaultValue: "")
  String? cgc;

  @JsonKey(defaultValue: "")
  String? ins;

  @JsonKey(defaultValue: "")
  String? cont;

  @JsonKey(defaultValue: "")
  String? repr;

  @JsonKey(defaultValue: "")
  String? nire;

  @JsonKey(defaultValue: "")
  String? inscricaomunicipal;
  String? tel;

  @JsonKey(defaultValue: "")
  String? foner;

  @JsonKey(defaultValue: "")
  String? fax;

  @JsonKey(defaultValue: "")
  String? faxr;

  @JsonKey(defaultValue: "")
  String? ende;

  @JsonKey(defaultValue: "")
  String? complemento;

  @JsonKey(defaultValue: "")
  String? cep;

  @JsonKey(defaultValue: "")
  String? pais;

  @JsonKey(defaultValue: "")
  String? estado;

  @JsonKey(defaultValue: "")
  String? bairro;

  @JsonKey(defaultValue: "")
  String? cidade;

  @JsonKey(defaultValue: "")
  String? site;

  @JsonKey(defaultValue: "")
  String? trans;

  @JsonKey(defaultValue: 0)
  int? ibgecodigodomunicipio;

  @JsonKey(defaultValue: 0)
  int? codigodopais;

  factory Forn.fromJson(Map<String, dynamic> json) => _$FornFromJson(json);
  Map<String, dynamic> toJson() => _$FornToJson(this);

  static Forn fromJsonModel(Map<String, dynamic> json) => Forn.fromJson(json);
}
