import 'dart:math' as math;
import 'package:comum/utilities/custom_scroll_behavior.dart';
import 'package:comum/utilities/utilities.dart';

import 'package:comum/widgets/action_popup.dart';
import 'package:comum/widgets/custom_floating_button.dart';
import 'package:comum/widgets/custom_separator.dart';
import 'package:comum/widgets/default_app_bar.dart';
import 'package:comum/widgets/default_overlay_slider.dart';
import 'package:comum/widgets/default_text_field.dart';
import 'package:comum/widgets/default_title.dart';
import 'package:comum/widgets/grid_base.dart';
import 'package:comum/widgets/secondary_button.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'answer_representative_store.dart';

class AnswerRepresentativePage extends StatefulWidget {
  const AnswerRepresentativePage({Key? key}) : super(key: key);

  @override
  AnswerRepresentativePageState createState() =>
      AnswerRepresentativePageState();
}

class AnswerRepresentativePageState extends State<AnswerRepresentativePage>
    with TickerProviderStateMixin {
  final AnswerRepresentativeStore store = Modular.get();

  late OverlayEntry optionsSlider;

  final slideryKey = GlobalKey<DefaultOverlaySliderState>();

  // final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    optionsSlider = getOptionsSliderOverlay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scaffoldKey,
      body: ScrollConfiguration(
        behavior: CustomScrollBehavior(),
        child: Column(
          children: [
            DefaultAppBar(
              title: "Atender Representante",
              actions: [
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      useRootNavigator: true,
                      builder: (context) => getPrintPopup(),
                    );
                  },
                  icon: SvgPicture.asset(
                    "./assets/svg/printer_light.svg",
                    width: 22,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Modular.to.pushNamed("/answer-representative/filter");
                  },
                  icon: SvgPicture.asset(
                    "./assets/svg/filter_light.svg",
                    width: 22,
                  ),
                ),
              ],
            ),
            Expanded(
              child: MyGrid(
                onSelect: (selectEvent) =>
                    Overlay.of(context)!.insert(optionsSlider),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: CustomFloatButton(
        onTap: () {
          Overlay.of(context)!.insert(optionsSlider);
        },
        child: const Icon(Icons.more_vert),
      ),
    );
  }

  Widget getPrintPopup() => ActionPopup(
        onCancel: () => Modular.to.pop(),
        onConfirm: () => Modular.to.pop(),
        children: const [
          DefaultTitle(
            title: "Imprimir Rotatividade",
            fontSize: 25,
            top: 20,
            bottom: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: DefaultTextField(
              label: "Layout",
              dropDown: true,
              dropDownOptions: [
                "Retrato",
                "Paisagem",
              ],
              width: double.infinity,
              bottom: 20,
            ),
          ),
        ],
      );

  OverlayEntry getOptionsSliderOverlay() {
    Future<void> removeSlider() async {
      await slideryKey.currentState!.animateTo(0);
      optionsSlider.remove();
    }

    return OverlayEntry(
      builder: (context) => DefaultOverlaySlider(
        key: slideryKey,
        height: maxHeight(context) - 100,
        onBack: () {
          optionsSlider.remove();
        },
        child: Column(
          children: [
            vSpace(30),
            SecondaryButton(
              label: "Consultar Pedidos",
              icon: "search",
              width: wXD(332, context),
              onTap: () {},
            ),
            SecondaryButton(
              label: "Propostas",
              icon: "proposes",
              width: wXD(332, context),
              onTap: () {},
            ),
            SecondaryButton(
              label: "Consultar Produto Atual",
              icon: "search",
              width: wXD(332, context),
              onTap: () {},
            ),
            SecondaryButton(
              label: "Últimas Compras do Produto Atual",
              icon: "export",
              width: wXD(332, context),
              onTap: () {},
            ),
            SecondaryButton(
              label: "Buscar Dados para Emitir Pedido",
              icon: "search",
              width: wXD(332, context),
              onTap: () {},
            ),
            SecondaryButton(
              label: "Zerar Coluna Pedido do Grid",
              icon: "delete",
              width: wXD(332, context),
              onTap: () {},
            ),
            SecondaryButton(
              label: "Alterar Coluna Sugestão por Quantidade mínima",
              icon: "insert_something",
              width: wXD(332, context),
              onTap: () {},
            ),
            SecondaryButton(
              label: "Alterar sugestão pelo Estoque do Depósito",
              icon: "search",
              width: wXD(332, context),
              onTap: () {},
            ),
            SecondaryButton(
              label: "Enviar Pedido para Cotação de Preços",
              icon: "search",
              width: wXD(332, context),
              onTap: () {},
              bottom: 20,
            ),
          ],
        ),
      ),
    );
  }
}
