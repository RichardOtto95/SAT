import 'package:comum/utilities/custom_scroll_behavior.dart';
import 'package:comum/utilities/utilities.dart';

import 'package:comum/widgets/default_app_bar.dart';
import 'package:comum/widgets/default_overlay_slider.dart';
import 'package:comum/widgets/default_text_field.dart';
import 'package:comum/widgets/filter_overlay.dart';
import 'package:comum/widgets/grid_base.dart';
import 'package:comum/widgets/responsive.dart';
import 'package:comum/widgets/secondary_button.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'comissions_and_gulls_store.dart';

class CommissionsAndGullsPage extends StatefulWidget {
  final String title;
  const CommissionsAndGullsPage(
      {Key? key, this.title = 'CommissionsAndGullsPage'})
      : super(key: key);
  @override
  CommissionsAndGullsPageState createState() => CommissionsAndGullsPageState();
}

class CommissionsAndGullsPageState extends State<CommissionsAndGullsPage>
    with TickerProviderStateMixin {
  final CommissionsAndGullsStore store = Modular.get();

  final slideryKey = GlobalKey<DefaultOverlaySliderState>();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: ScrollConfiguration(
        behavior: CustomScrollBehavior(),
        child: Column(
          children: [
            DefaultAppBar(
              title: "Comissões e gueltas",
              actions: [
                PopupMenuButton(
                  constraints: const BoxConstraints(maxWidth: 405),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  onSelected: (value) {},
                  splashRadius: 50,
                  itemBuilder: (context) {
                    List<Map> menuItens = [
                      {
                        "icon": "printer",
                        "title": "Imprimir modo Texto",
                      },
                      {
                        "icon": "printer",
                        "title": "Imprimir modo Gráfico",
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
                                  : getStyles(context).displaySmall?.copyWith(),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  child: SvgPicture.asset(
                    "./assets/svg/printer_light.svg",
                    width: 25,
                  ),
                ),
                hSpace(10),
                IconButton(
                  onPressed: () {
                    scaffoldKey.currentState!.openEndDrawer();
                  },
                  icon: SvgPicture.asset(
                    "./assets/svg/filter_light.svg",
                    width: 22,
                  ),
                ),
                // hSpace(10),
                // hSpace(10),
              ],
            ),
            const Expanded(
              child: MyGrid(),
            ),
          ],
        ),
      ),
      endDrawer: buildDrawer(),
    );
  }

  Widget buildDrawer() => FilterDrawer(
        children: [
          Row(
            children: [
              const Expanded(
                child: DefaultTextField(
                  label: "Data Inicial",
                  right: 5,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  "a",
                  style: getStyles(context).titleSmall,
                ),
              ),
              const Expanded(
                child: DefaultTextField(
                  label: "Data Final",
                  left: 5,
                  width: double.infinity,
                ),
              ),
            ],
          ),
          const DefaultTextField(
            label: "Nº NF Inicial",
            width: double.infinity,
            dropDown: true,
          ),
          SecondaryButton(
            label: "Comissões por pedido",
            icon: "monetization",
            width: double.infinity - 20,
            onTap: () {},
          ),
          Row(
            children: [
              Expanded(
                child: DefaultTextField(
                  label: "Vendedor",
                  right: 5,
                  width: double.infinity,
                  onTap: () {},
                ),
              ),
              Expanded(
                child: DefaultTextField(
                  label: "Loja",
                  left: 5,
                  width: double.infinity,
                  onTap: () {},
                ),
              ),
            ],
          ),
          SecondaryButton(
            label: "Totais por pedido",
            icon: "monetization",
            width: double.infinity - 20,
            onTap: () {},
          ),
          SecondaryButton(
            label: "Consultar pedido",
            icon: "search",
            width: double.infinity - 20,
            onTap: () {},
          ),
          DefaultTextField(
            label: "Estrutura",
            left: 5,
            width: double.infinity,
            onTap: () {},
          ),
          DefaultTextField(
            label: "Marca",
            left: 5,
            width: double.infinity,
            onTap: () {},
          ),
          DefaultTextField(
            label: "Fornecedor",
            left: 5,
            width: double.infinity,
            onTap: () {},
            info: "Esses Filtros só funcionam para esse Botões",
          ),
          SecondaryButton(
            label: "Comissões por item",
            icon: "monetization",
            width: double.infinity - 20,
            onTap: () {},
          ),
          SecondaryButton(
            label: "Gueltas por item",
            icon: "monetization",
            width: double.infinity - 20,
            onTap: () {},
          ),
          SecondaryButton(
            label: "Comissões Recebidas - Analítico",
            icon: "monetization",
            width: double.infinity - 20,
            onTap: () {},
          ),
          SecondaryButton(
            label: "Comissões Recebidas - Sintético",
            icon: "monetization",
            width: double.infinity - 20,
            onTap: () {},
          ),
          SecondaryButton(
            label: "Comissões por Estrutura Mercadológica",
            icon: "monetization",
            twoLines: true,
            width: double.infinity - 20,
            onTap: () {},
          ),
        ],
      );
}
