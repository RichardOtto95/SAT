import 'dart:math' as math;
import 'package:comum/utilities/custom_scroll_behavior.dart';
import 'package:comum/utilities/utilities.dart';

import 'package:comum/widgets/action_popup.dart';
import 'package:comum/widgets/custom_floating_button.dart';
import 'package:comum/widgets/default_app_bar.dart';
import 'package:comum/widgets/default_overlay_slider.dart';
import 'package:comum/widgets/default_text_field.dart';
import 'package:comum/widgets/default_title.dart';
import 'package:comum/widgets/expand_item.dart';
import 'package:comum/widgets/filter_overlay.dart';
import 'package:comum/widgets/grid_base.dart';
import 'package:comum/widgets/primary_button.dart';
import 'package:comum/widgets/secondary_button.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'bills_to_receive_store.dart';

class BillsToReceivePage extends StatefulWidget {
  const BillsToReceivePage({Key? key}) : super(key: key);

  @override
  BillsToReceivePageState createState() => BillsToReceivePageState();
}

class BillsToReceivePageState extends State<BillsToReceivePage>
    with TickerProviderStateMixin {
  late final AnimationController animationController;

  final BillsToReceiveStore store = Modular.get();

  late OverlayEntry optionsSlider;

  final slideryKey = GlobalKey<DefaultOverlaySliderState>();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    optionsSlider = getOptionsSliderOverlay();
    animationController = AnimationController(vsync: this, value: 0);
    super.initState();
  }

  Future<void> animate() async => await animationController.animateTo(
        animationController.value == 0 ? 1 : 0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.decelerate,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: ScrollConfiguration(
        behavior: CustomScrollBehavior(),
        child: Column(
          children: [
            DefaultAppBar(
              title: "Contas a Receber",
              actions: [
                IconButton(
                  onPressed: () {
                    scaffoldKey.currentState!.openEndDrawer();
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
            InkWell(
              onTap: () => animate(),
              child: SizedBox(
                width: maxWidth(context),
                height: 32,
                child: Center(
                  child: AnimatedBuilder(
                    animation: animationController,
                    child: SvgPicture.asset(
                      "./assets/svg/arrow_up${brightness == Brightness.dark ? '_dark' : ''}.svg",
                      width: 29,
                    ),
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: math.pi * animationController.value,
                        child: child,
                      );
                    },
                  ),
                ),
              ),
            ),
            SizeTransition(
              sizeFactor: animationController,
              axisAlignment: 1,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DefaultTextField(
                        label: "Quantidade Selecionada",
                        width: splitWidth(context, 2),
                      ),
                      DefaultTextField(
                        label: "Quantidade Total",
                        width: splitWidth(context, 2),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DefaultTextField(
                        label: "Valor Convertido Selecionado",
                        width: splitWidth(context, 2),
                      ),
                      DefaultTextField(
                        label: "Valor Convertido",
                        width: splitWidth(context, 2),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DefaultTextField(
                        label: "Diferença Selecionada",
                        width: splitWidth(context, 2),
                      ),
                      DefaultTextField(
                        label: "Diferença",
                        width: splitWidth(context, 2),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DefaultTextField(
                        label: "Valor Total",
                        width: splitWidth(context, 2),
                      ),
                      DefaultTextField(
                        label: "Juros",
                        width: splitWidth(context, 2),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DefaultTextField(
                  label: "Valor Total Selecionado",
                  width: splitWidth(context, 2),
                ),
                DefaultTextField(
                  label: "Valor Total Recebido",
                  width: splitWidth(context, 2),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 90),
        child: CustomFloatButton(
          onTap: () {
            Modular.to.pushNamed("/bills-to-receive/create-bill-to-receive");
          },
          child: SvgPicture.asset(
            "./assets/svg/add.svg",
            width: 33,
          ),
        ),
      ),
      endDrawer: getEndDrawer(),
    );
  }

  Widget getEndDrawer() => FilterDrawer(
        width: 360,
        children: [
          const DefaultTextField(
            label: "Tipo de Busca",
            dropDown: true,
            width: double.infinity,
            right: 10,
            left: 10,
          ),
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
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  "a",
                  style: getStyles(context).titleSmall,
                ),
              ),
              const Expanded(
                child: DefaultTextField(
                  label: "Data Final",
                  width: double.infinity,
                  left: 5,
                  right: 10,
                ),
              ),
            ],
          ),
          const DefaultTextField(
            label: "Ordenar por",
            dropDown: true,
            width: double.infinity,
            right: 10,
            left: 10,
          ),
          Row(
            children: [
              const Expanded(
                child: DefaultTextField(
                  label: "Exibir somente",
                  width: double.infinity,
                  dropDown: true,
                  left: 10,
                ),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
          const DefaultTextField(
            label: "Tipo de Cheque",
            dropDown: true,
            width: double.infinity,
            right: 10,
            left: 10,
          ),
          const DefaultTextField(
            label: "Boleto gerado",
            dropDown: true,
            width: double.infinity,
            right: 10,
            left: 10,
          ),
          const DefaultTextField(
            label: "Boleto Enviado",
            dropDown: true,
            width: double.infinity,
            right: 10,
            left: 10,
          ),
          Row(
            children: const [
              Expanded(
                child: DefaultTextField(
                  label: "Loja",
                  width: double.infinity,
                  left: 10,
                  right: 5,
                  dropDown: true,
                ),
              ),
              Expanded(
                child: DefaultTextField(
                  label: "Cliente",
                  width: double.infinity,
                  left: 5,
                  right: 10,
                  dropDown: true,
                ),
              ),
            ],
          ),
          Row(
            children: const [
              Expanded(
                child: DefaultTextField(
                  label: "Forma de Pagamento",
                  width: double.infinity,
                  left: 10,
                  right: 5,
                  dropDown: true,
                ),
              ),
              Expanded(
                child: DefaultTextField(
                  label: "Vendedor",
                  width: double.infinity,
                  left: 5,
                  right: 10,
                  dropDown: true,
                ),
              ),
            ],
          ),
          Row(
            children: const [
              Expanded(
                child: DefaultTextField(
                  label: "Parceiro",
                  width: double.infinity,
                  left: 10,
                  right: 5,
                  dropDown: true,
                ),
              ),
              Expanded(
                child: DefaultTextField(
                  label: "Conta Corrente",
                  width: double.infinity,
                  left: 5,
                  right: 10,
                  dropDown: true,
                ),
              ),
            ],
          ),
          Row(
            children: const [
              Expanded(
                child: DefaultTextField(
                  label: "Autorizada",
                  width: double.infinity,
                  left: 10,
                  right: 5,
                  dropDown: true,
                ),
              ),
              Expanded(
                child: DefaultTextField(
                  label: "Cartão",
                  width: double.infinity,
                  left: 5,
                  right: 10,
                  dropDown: true,
                ),
              ),
            ],
          ),
          Row(
            children: const [
              Expanded(
                child: DefaultTextField(
                  label: "Autorizada",
                  width: double.infinity,
                  left: 10,
                  right: 5,
                  dropDown: true,
                ),
              ),
              Expanded(
                child: SizedBox(),
              ),
            ],
          ),
          Row(
            children: [
              const Expanded(
                child: DefaultTextField(
                  label: "Mínimo Parcelas",
                  width: double.infinity,
                  left: 10,
                  right: 5,
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
                  label: "Máximo Parcelas",
                  width: double.infinity,
                  left: 5,
                  right: 10,
                ),
              ),
            ],
          ),
          vSpace(20),
          PrimaryButton(
            label: "Consultar Contas",
            width: 230,
            onTap: () {},
          ),
        ],
      );

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
        constraints: BoxConstraints(
          minHeight: 300,
          maxHeight: maxHeight(context) - 100,
        ),
        key: slideryKey,
        // height: maxHeight(context) - 100,
        onBack: () {
          optionsSlider.remove();
        },
        child: Column(
          children: [
            vSpace(30),
            SecondaryButton(
              label: "Editar",
              icon: "edit_orange",
              width: wXD(332, context),
              onTap: removeSlider,
            ),
            SecondaryButton(
              label: "Excluir Conta",
              icon: "delete",
              width: wXD(332, context),
              onTap: removeSlider,
            ),
            DefaultTextField(
              label: "Tipo de Reltório",
              width: wXD(332, context),
            ),
            SecondaryButton(
              label: "Editar",
              icon: "printer",
              width: wXD(332, context),
              onTap: removeSlider,
            ),
            ExpandItem(
              icon: "check",
              title: "Opçoes para Recebimentos",
              children: [
                SecondaryButton(
                  label: "Receber na Conta Corrente",
                  icon: "add",
                  width: wXD(332, context),
                  onTap: removeSlider,
                ),
                SecondaryButton(
                  label: "Receber no Caixa",
                  icon: "check",
                  width: wXD(332, context),
                  onTap: removeSlider,
                ),
                SecondaryButton(
                  label: "Receber no Contas a Receber",
                  icon: "check",
                  width: wXD(332, context),
                  onTap: removeSlider,
                ),
                SecondaryButton(
                  label: "Selecionar Todos",
                  icon: "select_all",
                  width: wXD(332, context),
                  onTap: removeSlider,
                ),
                SecondaryButton(
                  label: "Exibir Observação",
                  icon: "observation",
                  width: wXD(332, context),
                  onTap: removeSlider,
                ),
                SecondaryButton(
                  label: "Exibir Cliente",
                  icon: "search",
                  width: wXD(332, context),
                  onTap: removeSlider,
                ),
                SecondaryButton(
                  label: "Exibir Pedido",
                  icon: "search",
                  width: wXD(332, context),
                  onTap: removeSlider,
                ),
              ],
            ),
            ExpandItem(
              icon: "credit_card",
              title: "Conciliação de Cartões",
              children: [
                DefaultTextField(
                  label: "Cartão",
                  width: wXD(332, context),
                  dropDown: true,
                ),
                SecondaryButton(
                  label: "Importar Cartões",
                  icon: "credit_card",
                  width: wXD(332, context),
                  onTap: removeSlider,
                ),
                SecondaryButton(
                  label: "Excluit Conta",
                  icon: "count_report",
                  width: wXD(332, context),
                  onTap: removeSlider,
                ),
              ],
            ),
            ExpandItem(
              icon: "credit_card",
              title: "Conciliação de Cartões",
              children: [
                SecondaryButton(
                  label: "Gerar Boleto",
                  icon: "check_printer",
                  width: wXD(332, context),
                  onTap: removeSlider,
                ),
                SecondaryButton(
                  label: "Excluit Boleto",
                  icon: "delete",
                  width: wXD(332, context),
                  onTap: removeSlider,
                ),
                SecondaryButton(
                  label: "Imprimir Boleto",
                  icon: "printer",
                  width: wXD(332, context),
                  onTap: removeSlider,
                ),
                SecondaryButton(
                  label: "Salvar PDF",
                  icon: "printer",
                  width: wXD(332, context),
                  onTap: removeSlider,
                ),
                SecondaryButton(
                  label: "Enviar E-mail",
                  icon: "email",
                  width: wXD(332, context),
                  onTap: removeSlider,
                ),
                SecondaryButton(
                  label: "Gerar Remessa",
                  icon: "store_report",
                  width: wXD(332, context),
                  onTap: removeSlider,
                ),
                SecondaryButton(
                  label: "Excluir Boleto",
                  icon: "return",
                  width: wXD(332, context),
                  onTap: removeSlider,
                ),
              ],
            ),
            ExpandItem(
              icon: "cancel_cheque",
              title: "Boletos Bancários",
              children: [
                SecondaryButton(
                  label: "Processar Retorno",
                  icon: "cancel_cheque",
                  width: wXD(332, context),
                  onTap: removeSlider,
                ),
              ],
            ),
            vSpace(20),
          ],
        ),
      ),
    );
  }
}
