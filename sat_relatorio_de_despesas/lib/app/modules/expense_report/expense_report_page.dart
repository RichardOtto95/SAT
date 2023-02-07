import 'dart:math' as math;
import 'package:comum/utilities/custom_scroll_behavior.dart';
import 'package:comum/utilities/utilities.dart';
import 'package:comum/widgets/action_popup.dart';
import 'package:comum/widgets/default_app_bar.dart';
import 'package:comum/widgets/default_overlay_slider.dart';
import 'package:comum/widgets/default_text_field.dart';
import 'package:comum/widgets/default_title.dart';
import 'package:comum/widgets/grid_base.dart';
import 'package:comum/widgets/secondary_button.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'expense_report_store.dart';

class ExpenseReportPage extends StatefulWidget {
  final String title;
  const ExpenseReportPage({Key? key, this.title = 'ExpenseReportPage'})
      : super(key: key);
  @override
  ExpenseReportPageState createState() => ExpenseReportPageState();
}

class ExpenseReportPageState extends State<ExpenseReportPage>
    with TickerProviderStateMixin {
  final ExpenseReportStore store = Modular.get();

  late final AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(vsync: this);
    super.initState();
  }

  Future<void> animate() => animationController.animateTo(
        animationController.value == 0 ? 1 : 0,
        duration: const Duration(milliseconds: 350),
        curve: Curves.decelerate,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: CustomScrollBehavior(),
        child: Stack(
          children: [
            Column(
              children: [
                vSpace(viewPaddingTop(context) + 65 + 32 + 20 + 55),
                Expanded(
                  child: MyGrid(
                    onSelect: (selectEvent) {
                      showDialog(
                        context: context,
                        builder: (context) => DefaultOverlaySlider(
                          onBack: () {
                            Modular.to.pop();
                          },
                          child: Column(
                            children: [
                              const DefaultTitle(
                                title: "Código: 01",
                                top: 20,
                                bottom: 20,
                              ),
                              SecondaryButton(
                                label: "Alterar data da despesa",
                                icon: "calendar_edit",
                                width: wXD(332, context),
                                onTap: () {},
                              ),
                              SecondaryButton(
                                label: "Alterar loja",
                                icon: "store_edit",
                                width: wXD(332, context),
                                onTap: () {},
                              ),
                              SecondaryButton(
                                label: "Alterar Despesa",
                                icon: "monetization_edit",
                                width: wXD(332, context),
                                onTap: () {},
                              ),
                              SecondaryButton(
                                label: "Alterar histórico",
                                icon: "report_edit",
                                width: wXD(332, context),
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Column(
              children: [
                DefaultAppBar(
                  title: "Relatório de despesas",
                  actions: [
                    IconButton(
                      onPressed: () => showDialog(
                        context: context,
                        useRootNavigator: true,
                        builder: (context) => getPrintPopup(),
                      ),
                      icon: SvgPicture.asset(
                        "assets/svg/light_printer.svg",
                        width: 24,
                      ),
                    ),

                    hSpace(10),
                    IconButton(
                      onPressed: () => animate(),
                      icon: SvgPicture.asset(
                        "./assets/svg/filter_light.svg",
                        width: 22,
                      ),
                    ),
                    // hSpace(10),
                  ],
                ),
                vSpace(10),
                const DefaultTextField(label: "Tipo de busca", height: 55),
                AnimatedBuilder(
                  animation: animationController,
                  child: Material(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        SizeTransition(
                          sizeFactor: animationController,
                          axisAlignment: 1,
                          child: SizedBox(
                            width: maxWidth(context),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Expanded(
                                      child: DefaultTextField(
                                        label: "Data Inicial",
                                        width: double.infinity,
                                        left: 10,
                                        right: 5,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        "a",
                                        style: getStyles(context).titleSmall,
                                      ),
                                    ),
                                    const Expanded(
                                      child: DefaultTextField(
                                        label: "Data Inicial",
                                        width: double.infinity,
                                        left: 5,
                                        right: 10,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    DefaultTextField(
                                      label: "Loja",
                                      width: splitWidth(context, 2),
                                      onTap: () {},
                                    ),
                                    DefaultTextField(
                                      label: "Despesa",
                                      width: splitWidth(context, 2),
                                      onTap: () {},
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    DefaultTextField(
                                      label: "Fornecedor",
                                      width: splitWidth(context, 2),
                                      onTap: () {},
                                    ),
                                    DefaultTextField(
                                      label: "Parceiro",
                                      width: splitWidth(context, 2),
                                      onTap: () {},
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    DefaultTextField(
                                      label: "Situação",
                                      width: splitWidth(context, 2),
                                      dropDown: true,
                                    ),
                                    DefaultTextField(
                                      label: "Exibir",
                                      width: splitWidth(context, 2),
                                      dropDown: true,
                                    ),
                                  ],
                                ),
                                SecondaryButton(
                                  label: "Despesas",
                                  icon: "monetization_report",
                                  onTap: () {},
                                ),
                                SecondaryButton(
                                  label:
                                      "DRE - Demonstrativo de Resultadodo Exercício",
                                  icon: "monetization_report",
                                  onTap: () {},
                                ),
                                SecondaryButton(
                                  label: "DRE - por Loja",
                                  icon: "monetization_report",
                                  onTap: () {},
                                ),
                                SecondaryButton(
                                  label: "Balanço Patrimonial - a Pagar mensal",
                                  icon: "balance",
                                  onTap: () {},
                                ),
                                SecondaryButton(
                                  label: "Balanço Patrimonial - a Pagar na DRE",
                                  icon: "balance",
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => animate(),
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(15),
                          ),
                          child: Container(
                            height: 32,
                            width: maxWidth(context),
                            alignment: Alignment.center,
                            child: AnimatedBuilder(
                              animation: animationController,
                              child: SvgPicture.asset(
                                "assets/svg/arrow_down.svg",
                                width: 28,
                              ),
                              builder: (context, child) => Transform.rotate(
                                angle: math.pi * animationController.value,
                                child: child,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  builder: (context, child) => Container(
                    width: maxWidth(context),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(15),
                      ),
                      color: getColors(context).surface,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 6,
                          offset: Offset(0, 3),
                          color: getColors(context)
                              .shadow
                              .withOpacity(.3 * animationController.value),
                        )
                      ],
                    ),
                    child: child,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getPrintPopup() => ActionPopup(
        onCancel: () => Modular.to.pop(),
        onConfirm: () => Modular.to.pop(),
        children: const [
          DefaultTitle(
            title: "Imprimir Relatório",
            fontSize: 25,
            top: 20,
            bottom: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: DefaultTextField(
              label: "Modo de impressão",
              dropDown: true,
              width: double.infinity,
              bottom: 20,
            ),
          ),
        ],
      );
}

class PaginationActionButton extends StatelessWidget {
  const PaginationActionButton(this.icon, this.onTap, {super.key, this.color});

  final String icon;
  final void Function() onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          border: Border.all(color: color ?? getColors(context).primary),
          borderRadius: BorderRadius.circular(4),
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          "assets/svg/$icon.svg",
          height: 20,
          width: 20,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
