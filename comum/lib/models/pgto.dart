// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'pgto.g.dart';

@JsonSerializable(includeIfNull: false)
class Pgto {
  Pgto({
    this.id_oe,
    this.id_pg,
    this.data_pg,
    this.autorizacao,
    this.cartao,
    this.cartaonsu,
    this.cnpjcredenciadora,
    this.codfunc,
    this.data,
    this.doc,
    this.ent,
    this.nome,
    this.nsuautorizadora,
    this.operacao,
    this.operadora,
    this.pgtos,
    this.tefexecutado,
    this.valor_pg,
    this.tef,
  });

  int? id_oe;
  int? id_pg;
  DateTime? data;
  DateTime? data_pg;
  int? ent;
  double? valor_pg;
  String? pgtos;
  String? tefexecutado;
  String? doc;
  String? tef;
  String? autorizacao;
  String? cartaonsu;
  String? nsuautorizadora;
  String? codfunc;
  String? nome;
  String? cartao;
  String? operadora;
  String? operacao;
  String? cnpjcredenciadora;
  String? dep;

  factory Pgto.fromJson(Map<String, dynamic> json) => _$PgtoFromJson(json);
  Map<String, dynamic> toJson() => _$PgtoToJson(this);
}

@JsonSerializable(includeIfNull: false)
class FormasPagamento {
  FormasPagamento(this.ent, this.entd, this.tipo, this.ativartefelginpay);

  final int ent;
  final String entd;
  final String? tipo;
  final String? ativartefelginpay;

  factory FormasPagamento.fromJson(Map<String, dynamic> json) =>
      _$FormasPagamentoFromJson(json);
  Map<String, dynamic> toJson() => _$FormasPagamentoToJson(this);
}
