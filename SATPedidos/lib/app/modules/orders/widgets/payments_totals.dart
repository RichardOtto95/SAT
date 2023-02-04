import 'package:comum/utilities/utilities.dart';
import 'package:comum/widgets/custom_navigation_tile.dart';
import 'package:comum/widgets/default_text_field.dart';
import 'package:comum/widgets/default_title.dart';

import 'package:comum/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../orders_store.dart';
import 'float_button_text_field.dart';

import 'dart:math' as math;

import 'grid_base.dart';

class PaymentsTotals extends StatefulWidget {
  final void Function(bool opening) onClick;
  const PaymentsTotals({super.key, required this.onClick});

  @override
  State<PaymentsTotals> createState() => _PaymenstTotalStates();
}

class _PaymenstTotalStates extends State<PaymentsTotals>
    with TickerProviderStateMixin {
  late AnimationController paymentsAnimation;

  late AnimationController totalsAnimation;

  @override
  void initState() {
    paymentsAnimation = AnimationController(vsync: this, value: 0);
    totalsAnimation = AnimationController(vsync: this, value: 0);
    super.initState();
  }

  Future<void> animatePayments(double value) => paymentsAnimation.animateTo(
        value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.decelerate,
      );

  Future<void> animateTotals(double value) => totalsAnimation.animateTo(
        value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.decelerate,
      );

  @override
  void dispose() {
    paymentsAnimation.dispose();
    totalsAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Column(
        children: [
          Container(
            height: 10,
            width: maxWidth(context),
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15)),
              color: getColors(context).surface,
              boxShadow: [
                BoxShadow(
                  blurRadius: 6,
                  color: getColors(context).shadow,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
          ),
          ColoredBox(
            color: getColors(context).surface,
            child: SizeTransition(
              sizeFactor: paymentsAnimation,
              axisAlignment: -1,
              child: const Payments(),
            ),
          ),
          ColoredBox(
            color: getColors(context).surface,
            child: SizeTransition(
              sizeFactor: totalsAnimation,
              axisAlignment: -1,
              child: Totals(),
            ),
          ),
          ColoredBox(
            color: getColors(context).surface,
            child: Row(
              children: [
                FloatButtonTextField(
                  label: "Total pago",
                  data: "R\$ 7.462,00",
                  width: (maxWidth(context) - 30) / 2,
                  onTap: () async {
                    if (paymentsAnimation.value > .5) {
                      widget.onClick(true);
                      await animatePayments(0);
                    } else {
                      if (totalsAnimation.value == 1) {
                        await animateTotals(0);
                      } else {
                        widget.onClick(false);
                      }
                      animatePayments(1);
                    }
                  },
                  icon: AnimatedBuilder(
                    animation: paymentsAnimation,
                    child: Icon(
                      Icons.more_horiz,
                      size: 30,
                      color: getColors(context).primary,
                    ),
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: math.pi * paymentsAnimation.value,
                        child: child,
                      );
                    },
                  ),
                ),
                hSpace(10),
                FloatButtonTextField(
                  label: "Total",
                  data: "R\$ 7.462,00",
                  width: (maxWidth(context) - 30) / 2,
                  onTap: () async {
                    if (totalsAnimation.value > .5) {
                      widget.onClick(true);
                      await animateTotals(0);
                    } else {
                      if (paymentsAnimation.value == 1) {
                        await animatePayments(0);
                      } else {
                        widget.onClick(false);
                      }
                      animateTotals(1);
                    }
                  },
                  icon: AnimatedBuilder(
                    animation: totalsAnimation,
                    child: Icon(
                      Icons.arrow_drop_up_rounded,
                      size: 30,
                      color: getColors(context).primary,
                    ),
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: math.pi * totalsAnimation.value,
                        child: child,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Totals extends StatelessWidget {
  Totals({super.key});

  final OrdersStore store = Modular.get();

  final tileKey = GlobalKey<CustomNavigationTileState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        vSpace(5),
        Observer(
          builder: (context) {
            return CustomNavigationTile(
              key: tileKey,
              tiles: const ["Totais", "Adicionais", "Impostos"],
              horizontalPadding: maxWidth(context) / 6,
              width: maxWidth(context) - 44,
              onPageChange: (page) => store.setTotalsPage(page),
              page: store.totalsPage,
            );
          },
        ),
        vSpace(15),
        Observer(
          builder: (context) {
            return AnimatedContainer(
              height: store.totalsHeight,
              duration: const Duration(milliseconds: 400),
              curve: Curves.decelerate,
              width: maxWidth(context),
              child: PageView(
                controller: store.totalsPageController,
                scrollDirection: Axis.horizontal,
                onPageChanged: (page) {
                  store.setTotalsPage(page);
                  tileKey.currentState?.changePosition(page);
                },
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DefaultTextField(
                            label: "Produtos R\$",
                            textColor: Colors.red,
                            width: (maxWidth(context) - 30) / 2,
                            // dropDown: true,
                            dropDownOptions: const [],
                            hint: "",
                            bottom: 10,
                          ),
                          hSpace(10),
                          DefaultTextField(
                            label: "Serviços",
                            textColor: Colors.red,
                            width: (maxWidth(context) - 30) / 2,
                            hint: "",
                            // dropDown: true,
                            dropDownOptions: const [],
                            bottom: 10,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DefaultTextField(
                            label: "Descondo %",
                            textColor: Colors.red,
                            width: (maxWidth(context) - 30) / 2,
                            // dropDown: true,
                            dropDownOptions: const [],
                            hint: "",
                            bottom: 10,
                          ),
                          hSpace(10),
                          DefaultTextField(
                            label: "Desconto R\$",
                            textColor: Colors.red,
                            width: (maxWidth(context) - 30) / 2,
                            hint: "",
                            // dropDown: true,
                            dropDownOptions: const [],
                            bottom: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DefaultTextField(
                            label: "Ac. Financeiro",
                            textColor: Colors.red,
                            width: (maxWidth(context) - 30) / 2,
                            // dropDown: true,
                            dropDownOptions: const [],
                            hint: "",
                            bottom: 10,
                          ),
                          hSpace(10),
                          DefaultTextField(
                            label: "Acréscimo",
                            textColor: Colors.red,
                            width: (maxWidth(context) - 30) / 2,
                            hint: "",
                            // dropDown: true,
                            dropDownOptions: const [],
                            bottom: 10,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          hSpace(10),
                          DefaultTextField(
                            label: "Frete",
                            textColor: Colors.red,
                            width: (maxWidth(context) - 30) / 2,
                            // dropDown: true,
                            dropDownOptions: const [],
                            hint: "",
                            bottom: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DefaultTextField(
                              label: "Total IPI",
                              textColor: Colors.red,
                              width: (maxWidth(context) - 30) / 2,
                              hint: "",
                              isBlue: true,
                              bottom: 10,
                            ),
                            hSpace(10),
                            DefaultTextField(
                              label: "ICMS Desonerado",
                              textColor: Colors.red,
                              width: (maxWidth(context) - 30) / 2,
                              hint: "",
                              isBlue: true,
                              bottom: 10,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            hSpace(10),
                            DefaultTextField(
                              label: "ICMS ST",
                              textColor: Colors.red,
                              width: (maxWidth(context) - 30) / 2,
                              isBlue: true,
                              hint: "",
                              bottom: 10,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SecondaryButton(
                              label: "Inserir ST",
                              onTap: () {},
                              height: 55,
                              width: (maxWidth(context) - 30) / 2,
                              icon: "insert_st",
                            ),
                            hSpace(10),
                            SecondaryButton(
                              label: "Inserir IPI",
                              onTap: () {},
                              height: 55,
                              width: (maxWidth(context) - 30) / 2,
                              icon: "insert_st",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class Payments extends StatelessWidget {
  const Payments({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 386,
      child: Column(
        children: [
          const DefaultTitle(
            title: "Pagamentos",
            top: 10,
            bottom: 20,
          ),
          SizedBox(
            height: 183,
            width: maxWidth(context),
            child: const MyGrid(),
          ),
          vSpace(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SecondaryButton(
                label: "Inserir Pagamento",
                onTap: () {},
                width: (maxWidth(context) - 30) / 2,
                icon: "insert_payment",
                height: 55,
                bottom: 10,
              ),
              hSpace(10),
              SecondaryButton(
                label: "Excluir Pagamento",
                onTap: () {},
                icon: "delete",
                width: (maxWidth(context) - 30) / 2,
                height: 55,
                bottom: 10,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultTextField(
                label: "Total Convertido",
                textColor: Colors.red,
                width: (maxWidth(context) - 30) / 2,
                hint: "",
                bottom: 10,
              ),
              hSpace(10),
              SecondaryButton(
                label: "TEF - Cartão",
                onTap: () {},
                icon: "insert_st",
                width: (maxWidth(context) - 30) / 2,
                height: 55,
                bottom: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
