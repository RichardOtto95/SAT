import 'dart:math' as math;
import 'package:comum/utilities/custom_scroll_behavior.dart';
import 'package:comum/utilities/utilities.dart';
import 'package:comum/widgets/action_popup.dart';
import 'package:comum/widgets/default_app_bar.dart';
import 'package:comum/widgets/default_text_field.dart';
import 'package:comum/widgets/default_title.dart';
import 'package:comum/widgets/grid_base.dart';
import 'package:comum/widgets/responsive.dart';
import 'package:comum/widgets/secondary_button.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'award_report_store.dart';

class AwardReportPage extends StatefulWidget {
  final String title;
  const AwardReportPage({Key? key, this.title = 'AwardReportPage'})
      : super(key: key);
  @override
  AwardReportPageState createState() => AwardReportPageState();
}

class AwardReportPageState extends State<AwardReportPage>
    with TickerProviderStateMixin {
  final AwardReportStore store = Modular.get();

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
                SizedBox(
                  height: 200,
                  width: maxWidth(context),
                  child: MyGrid(),
                ),
                const Expanded(
                  child: MyGrid(),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      PaginationActionButton("first", () {}),
                      hSpace(10),
                      PaginationActionButton("preview", () {}),
                      Spacer(),
                      PaginationActionButton(
                        "remove",
                        () {},
                        color: Colors.red,
                      ),
                      hSpace(10),
                      PaginationActionButton(
                        "add_new",
                        () {},
                        color: Colors.red,
                      ),
                      Spacer(),
                      PaginationActionButton("next", () {}),
                      hSpace(10),
                      PaginationActionButton("last", () {}),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                DefaultAppBar(
                  title: "Relatório de premiação",
                  actions: [
                    PopupMenuButton(
                      constraints: const BoxConstraints(maxWidth: 405),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      onSelected: (value) {
                        switch (value) {
                          case 0:
                            showDialog(
                              context: context,
                              useRootNavigator: true,
                              builder: (context) => getPrintPopup(),
                            );
                            break;
                          default:
                        }
                      },
                      child: SvgPicture.asset(
                        "assets/svg/light_printer.svg",
                        width: 24,
                      ),
                      itemBuilder: (context) {
                        List<Map> menuItens = [
                          {
                            "icon": "printer",
                            "title": "Imprimir em quantidade",
                          },
                          {
                            "icon": "printer",
                            "title": "Imprimir em valores",
                          },
                        ];
                        return List.generate(
                          menuItens.length,
                          (index) => PopupMenuItem<int>(
                            value: index,
                            height: 46,
                            child: Row(
                              children: [
                                Container(
                                  height: 46,
                                  alignment: Alignment.centerLeft,
                                  child: SvgPicture.asset(
                                    "./assets/svg/${menuItens[index]["icon"]}.svg",
                                    width: 20,
                                  ),
                                ),
                                hSpace(10),
                                Text(
                                  menuItens[index]["title"],
                                  style: Responsive.isDesktop(context)
                                      ? getStyles(context).displayLarge
                                      : getStyles(context)
                                          .displaySmall
                                          ?.copyWith(),
                                )
                              ],
                            ),
                          ),
                        );
                      },
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
                const DefaultTextField(label: "Campanha", height: 55),
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
                                const DefaultTitle(
                                  title: "Em quantidade",
                                  top: 15,
                                  bottom: 15,
                                  isLeft: true,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SecondaryButton(
                                      label: "Números",
                                      icon: "report",
                                      width: splitWidth(context, 2),
                                      onTap: () {},
                                    ),
                                    SecondaryButton(
                                      label: "Percentual",
                                      icon: "report",
                                      width: splitWidth(context, 2),
                                      onTap: () {},
                                    ),
                                  ],
                                ),
                                const DefaultTitle(
                                  title: "Em valores",
                                  top: 15,
                                  bottom: 15,
                                  isLeft: true,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SecondaryButton(
                                      label: "Valor Ven.",
                                      icon: "report",
                                      width: splitWidth(context, 2),
                                      onTap: () {},
                                    ),
                                    SecondaryButton(
                                      label: "Percentual",
                                      icon: "report",
                                      width: splitWidth(context, 2),
                                      onTap: () {},
                                    ),
                                  ],
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
              label: "Relatórios",
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
