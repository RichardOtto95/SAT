import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sat_movimento_de_caixa/app/modules/movimento_de_caixa/cash_movement_store.dart';
import 'package:sat_movimento_de_caixa/app/modules/movimento_de_caixa/widgets/info_page.dart';
import 'package:sat_movimento_de_caixa/app/shared/utilities.dart';

import 'dart:math' as math;

import 'package:sat_movimento_de_caixa/app/shared/widgets/info.dart';

class CashOptions extends StatefulWidget {
  const CashOptions({super.key});

  @override
  State<CashOptions> createState() => _CashOptionsState();
}

class _CashOptionsState extends State<CashOptions> {
  final CashMovementStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Observer(
        builder: (context) {
          return Column(
            children: [
              CashOptionsTile(
                title: "Relatórios demonstrativos",
                icon: "./assets/svg/reports.svg",
                subTiles: [
                  CheckTile(
                    title: "Exibir o Nº da NFC-e e NF-e",
                    onTap: () => store.changeShowNfNumber(),
                    check: store.showNfNumber,
                  ),
                  SubTile(
                    title: "Caixa detalhado",
                    icon: "./assets/svg/reports.svg",
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => InfoPage()));
                    },
                  ),
                  SubTile(
                    title: "Caixa resumido - Tipo 1",
                    icon: "./assets/svg/resumed_cash.svg",
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => InfoPage()));
                    },
                  ),
                  SubTile(
                    title: "Caixa resumido - Tipo 2",
                    icon: "./assets/svg/resumed_cash_2.svg",
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => InfoPage()));
                    },
                  ),
                  SubTile(
                    title: "Caixa - por Operador",
                    icon: "./assets/svg/resumed_cash_2.svg",
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => InfoPage()));
                    },
                  ),
                  SubTile(
                    title: "Caixa - Somente Vendas",
                    icon: "./assets/svg/cash_sells.svg",
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => InfoPage()));
                    },
                  ),
                  SubTile(
                    title: "Resumo diário das Vendas",
                    icon: "./assets/svg/graphic.svg",
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => InfoPage()));
                    },
                  ),
                  SubTile(
                    title: "Caixa PDV",
                    icon: "./assets/svg/reports.svg",
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => InfoPage()));
                    },
                  ),
                ],
              ),
              CashOptionsTile(
                title: "Opções para fechamento",
                icon: "./assets/svg/conclusion.svg",
                subTiles: [
                  SubTile(
                    title: "Fechar o Caixa Atual",
                    icon: "./assets/svg/conclusion.svg",
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => InfoPage()));
                    },
                  ),
                  SubTile(
                    title: "Estornar o caixa fechado",
                    icon: "./assets/svg/trash_out.svg",
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => InfoPage()));
                    },
                  ),
                  SubTile(
                    title: "Visualizar cancelamentos",
                    icon: "./assets/svg/report_cancel.svg",
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => InfoPage()));
                    },
                  ),
                  SubTile(
                    title: "Exibir Caixas fechados",
                    icon: "./assets/svg/cash_closed.svg",
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => InfoPage()));
                    },
                  ),
                  SubTile(
                    title: "Exibir caixas não fechados",
                    icon: "./assets/svg/cash_open.svg",
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => InfoPage()));
                    },
                  ),
                  SubTile(
                    title: "Exibir quem operou o caixa",
                    icon: "./assets/svg/who_operated.svg",
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => InfoPage()));
                    },
                  ),
                  const InfoWidget(
                    info:
                        "* É importante fechar o caixa todos os dias para que os pagamentos apareçam no \"Contas a receber\"",
                  )
                ],
              ),
              CashOptionsTile(
                title: "Carteira de cheques",
                icon: "./assets/svg/wallet.svg",
                subTiles: [
                  SubTile(
                    title: "Carteiras e custódias",
                    icon: "./assets/svg/printer.svg",
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => InfoPage()));
                    },
                  ),
                  SubTile(
                    title: "Alterar Data da Carteira",
                    icon: "./assets/svg/calendar.svg",
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => InfoPage()));
                    },
                  ),
                  SubTile(
                    title: "Depositar Carteira",
                    icon: "./assets/svg/wallet_deposit.svg",
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => InfoPage()));
                    },
                  ),
                ],
              ),
              CashOptionsTile(
                title: "Impressões",
                icon: "./assets/svg/printer.svg",
                subTiles: [
                  SubTile(
                    title: "Movimento atual",
                    icon: "./assets/svg/printer.svg",
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => InfoPage()));
                    },
                  ),
                  SubTile(
                    title: "Caixa fechado",
                    icon: "./assets/svg/printer.svg",
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => InfoPage()));
                    },
                  ),
                  SubTile(
                    title: "Pagamento do caixa",
                    icon: "./assets/svg/printer.svg",
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => InfoPage()));
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class CashOptionsTile extends StatefulWidget {
  final String title;
  final String icon;
  final List<Widget> subTiles;

  const CashOptionsTile({
    super.key,
    required this.title,
    required this.icon,
    required this.subTiles,
  });

  @override
  State<CashOptionsTile> createState() => _CashOptionsTileState();
}

class _CashOptionsTileState extends State<CashOptionsTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
      value: 0,
    );
    super.initState();
  }

  Future animateTo(double value) async => await controller.animateTo(value,
      duration: const Duration(milliseconds: 300), curve: Curves.fastOutSlowIn);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => controller.value < .5 ? animateTo(1) : animateTo(0),
          child: Container(
            width: maxWidth(context),
            padding: EdgeInsets.symmetric(
              vertical: 25,
              horizontal: 15,
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: getColors(context).outline),
              ),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  widget.icon,
                  width: 20,
                ),
                hSpace(12),
                Text(
                  widget.title,
                  style: getStyles(context).labelLarge?.copyWith(
                        color: getColors(context).onBackground,
                      ),
                ),
                Spacer(),
                AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: math.pi * controller.value,
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: getColors(context).onBackground.withOpacity(.7),
                        size: 35,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        // if (showTiles)
        SizeTransition(
          sizeFactor: controller,
          axisAlignment: 1,
          axis: Axis.vertical,
          child: Column(
            // key: columnKey,
            children: widget.subTiles,
          ),
        ),
      ],
    );
  }
}

class SubTile extends StatelessWidget {
  final String title;
  final String? icon;
  final void Function() onTap;

  const SubTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: maxWidth(context) - 40,
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: getColors(context).outline),
            ),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                icon!,
                width: 20,
              ),
              hSpace(12),
              Text(
                title,
                style: getStyles(context).labelMedium?.copyWith(
                      color: getColors(context).onBackground,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CheckTile extends SubTile {
  final bool check;
  final EdgeInsets? edgeInsets;

  const CheckTile({
    super.key,
    required void Function() onTap,
    required this.check,
    required String title,
    this.edgeInsets,
  }) : super(
          title: title,
          icon: null,
          onTap: onTap,
        );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: super.onTap,
      child: Padding(
        padding: edgeInsets ??
            const EdgeInsets.only(
              left: 35,
              right: 35,
              top: 15,
              bottom: 5,
            ),
        child: Row(
          children: [
            Container(
              height: 21,
              width: 21,
              decoration: BoxDecoration(
                border: Border.all(color: getColors(context).primaryContainer),
                borderRadius: BorderRadius.circular(6),
                color: check
                    ? getColors(context).primary
                    : getColors(context).onPrimary,
              ),
              child: Icon(
                Icons.check_rounded,
                size: 15,
              ),
              // child: SvgPicture.asset(
              //   "./assets/svg/check.svg",
              //   width: 10,
              // ),
            ),
            hSpace(10),
            Text(
              title,
              style: getStyles(context).labelMedium?.copyWith(
                    color: getColors(context).onBackground,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
