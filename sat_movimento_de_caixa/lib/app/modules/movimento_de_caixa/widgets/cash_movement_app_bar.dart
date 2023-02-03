import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sat_movimento_de_caixa/app/constants/properties.dart';
import 'package:sat_movimento_de_caixa/app/modules/movimento_de_caixa/cash_movement_store.dart';
import 'package:sat_movimento_de_caixa/app/modules/movimento_de_caixa/widgets/cash_options.dart';
import 'package:sat_movimento_de_caixa/app/shared/utilities.dart';
import 'package:sat_movimento_de_caixa/app/shared/widgets/default_text_field.dart';
import 'package:sat_movimento_de_caixa/app/shared/widgets/observation.dart';

import 'dart:math' as math;

import 'package:sat_movimento_de_caixa/app/shared/widgets/primary_button.dart';

class CashMovementAppBar extends StatefulWidget {
  const CashMovementAppBar({super.key});

  @override
  State<CashMovementAppBar> createState() => _CashMovementAppBarState();
}

class _CashMovementAppBarState extends State<CashMovementAppBar>
    with SingleTickerProviderStateMixin {
  final CashMovementStore store = Modular.get();

  final _movementsMenuLink = LayerLink();

  @override
  void initState() {
    store.filterController = AnimationController(vsync: this, value: 0);
    super.initState();
  }

  @override
  void dispose() {
    store.filterController!.dispose();
    super.dispose();
  }

  Future animateTo(double value) async =>
      await store.filterController!.animateTo(value,
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getOverlayStyleFromColor(getColors(context).primary),
      child: Column(
        children: [
          Container(
            // height: viewPaddingTop(context) + 97,
            width: maxWidth(context),
            padding: EdgeInsets.only(
              top: viewPaddingTop(context) + 15,
            ),
            decoration: BoxDecoration(
              color: getColors(context).primary,
            ),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: maxWidth(context),
                      alignment: Alignment.center,
                      child: Text(
                        "Movimento de caixa",
                        style: getStyles(context).titleMedium,
                      ),
                    ),
                    Positioned(
                      left: 0,
                      child: Container(
                        padding: const EdgeInsets.only(left: 10),
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_rounded),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.only(right: 10),
                        alignment: Alignment.centerRight,
                        child: Observer(
                          builder: (context) {
                            return Row(
                              children: [
                                IconButton(
                                  icon: AnimatedBuilder(
                                    animation: store.filterController!,
                                    builder: (context, child) {
                                      return Transform.rotate(
                                        angle: math.pi *
                                            store.filterController!.value,
                                        child: const Icon(
                                          Icons.arrow_drop_down,
                                        ),
                                      );
                                    },
                                  ),
                                  onPressed: () =>
                                      store.filterController!.value > .5
                                          ? animateTo(0)
                                          : animateTo(1),
                                ),
                                Visibility(
                                  visible: store.page == 1,
                                  child: CompositedTransformTarget(
                                    link: _movementsMenuLink,
                                    child: IconButton(
                                      icon: SvgPicture.asset(
                                        "./assets/svg/printer_light.svg",
                                        width: 19,
                                      ),
                                      onPressed: () => getMovementsOverlay(),
                                    ),
                                  ),
                                ),
                                if (store.page == 3)
                                  CompositedTransformTarget(
                                    link: _movementsMenuLink,
                                    child: IconButton(
                                      onPressed: () =>
                                          getInputsOutputsOverlay(),
                                      icon: Icon(
                                        Icons.more_vert,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: maxWidth(context),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      left: 15,
                      top: 12,
                      bottom: 10,
                    ),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        NavigationTab(label: "Opções de caixa", page: 0),
                        NavigationTab(label: "Movimentos", page: 1),
                        NavigationTab(label: "Despesas", page: 2),
                        NavigationTab(label: "Entradas e saídas", page: 3),
                        NavigationTab(
                          label: "Recebimentos anteriores",
                          page: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizeTransition(
            sizeFactor: store.filterController!,
            axis: Axis.vertical,
            axisAlignment: 1,
            child: Container(
              width: maxWidth(context),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    offset: Offset(0, 3),
                    color: getColors(context).shadow,
                  ),
                ],
                color: getColors(context).surface,
              ),
              child: Column(
                children: [
                  FilterField(label: "Data:"),
                  FilterField(label: "Nº do terminal:"),
                  FilterField(label: "Loja:"),
                  FilterField(label: "Operador de caixa:"),
                  vSpace(35),
                  PrimaryButton(
                    height: 57,
                    width: 190,
                    title: "Consultar",
                    onTap: () {
                      animateTo(0);
                    },
                  ),
                  vSpace(20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  getMovementsOverlay() {
    late OverlayEntry overlay;
    overlay = OverlayEntry(
      builder: (context) => Positioned(
        width: maxHeight(context),
        height: maxWidth(context),
        child: Stack(
          children: [
            GestureDetector(
              onTap: () => overlay.remove(),
              child: Container(
                height: maxHeight(context),
                width: maxWidth(context),
                color: Colors.transparent,
              ),
            ),
            CompositedTransformFollower(
              offset: Offset(
                -200,
                15,
              ),
              link: _movementsMenuLink,
              child: Container(
                width: 220,
                height: 92,
                decoration: BoxDecoration(
                  border:
                      Border.all(color: getColors(context).onPrimaryContainer),
                  color: getColors(context).surface,
                  boxShadow: [defBoxShadow(context)],
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 16, right: 8),
                            child: SvgPicture.asset(
                              "./assets/svg/printer_light.svg",
                              width: 19,
                            ),
                          ),
                          Text(
                            "Imprimir modo Texto",
                            style: getStyles(context).displaySmall?.copyWith(
                                  color: getColors(context).primary,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 16, right: 8),
                            child: SvgPicture.asset(
                              "./assets/svg/printer.svg",
                              width: 19,
                            ),
                          ),
                          Text(
                            "Imprimir modo Gráfico",
                            style: getStyles(context).displaySmall?.copyWith(
                                  color: getColors(context).primary,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    Overlay.of(context)?.insert(overlay);
  }

  getInputsOutputsOverlay() {
    late OverlayEntry overlay;
    overlay = OverlayEntry(
      builder: (context) => Positioned(
        width: maxHeight(context),
        height: maxWidth(context),
        child: Material(
          color: Colors.transparent,
          child: Stack(
            children: [
              GestureDetector(
                onTap: () => overlay.remove(),
                child: Container(
                  height: maxHeight(context),
                  width: maxWidth(context),
                  color: Colors.transparent,
                ),
              ),
              CompositedTransformFollower(
                offset: Offset(
                  -180,
                  15,
                ),
                link: _movementsMenuLink,
                child: Container(
                  width: 200,
                  height: 138,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: getColors(context).onPrimaryContainer),
                    color: getColors(context).surface,
                    boxShadow: [defBoxShadow(context)],
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 16, right: 12),
                              child: SvgPicture.asset(
                                "./assets/svg/supply.svg",
                                width: 19,
                              ),
                            ),
                            Text(
                              "Suprimento",
                              style: getStyles(context).displaySmall?.copyWith(
                                    color: getColors(context).primary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => getInsertBleedOverlay(),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 16, right: 12),
                                child: SvgPicture.asset(
                                  "./assets/svg/bleed.svg",
                                  width: 19,
                                ),
                              ),
                              Text(
                                "Sangria",
                                style:
                                    getStyles(context).displaySmall?.copyWith(
                                          color: getColors(context).primary,
                                        ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 16, right: 12),
                              child: SvgPicture.asset(
                                "./assets/svg/printer.svg",
                                width: 19,
                              ),
                            ),
                            Text(
                              "Imprimir Relatório de\nLançamentos",
                              style: getStyles(context).displaySmall?.copyWith(
                                    color: getColors(context).primary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    Overlay.of(context)?.insert(overlay);
  }

  getInsertBleedOverlay() {
    late OverlayEntry entry;
    entry = OverlayEntry(
        builder: (context) => InsertBleed(
              onBack: () => entry.remove(),
            ));
    Overlay.of(context)?.insert(entry);
  }
}

class InsertBleed extends StatefulWidget {
  final void Function() onBack;
  const InsertBleed({super.key, required this.onBack});

  @override
  State<InsertBleed> createState() => _InsertBleedState();
}

class _InsertBleedState extends State<InsertBleed>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  @override
  void initState() {
    animationController = AnimationController(vsync: this, value: 0);
    animateTo(1);
    super.initState();
  }

  Future<void> animateTo(double value) => animationController.animateTo(
        value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.decelerate,
      );

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              await animateTo(0);
              widget.onBack();
            },
            child: AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: animationController.value * 2 + .001,
                    sigmaY: animationController.value * 2 + .001,
                  ),
                  child: Container(
                    height: maxHeight(context),
                    width: maxWidth(context),
                    color: getColors(context)
                        .shadow
                        .withOpacity(.3 * animationController.value),
                  ),
                );
              },
            ),
          ),
          ScaleTransition(
            scale: animationController,
            child: Container(
              height: 503,
              width: 305,
              decoration: BoxDecoration(
                  color: getColors(context).surface,
                  borderRadius: BorderRadius.circular(17)),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(17)),
                      color: getColors(context).primary,
                    ),
                    child: Text(
                      "Inserir sangria",
                      style: getStyles(context).titleLarge?.copyWith(
                            color: getColors(context).onPrimary,
                          ),
                    ),
                  ),
                  vSpace(20),
                  DefaultTextField(
                    label: "Forma de pagamento",
                    onFocus: () {},
                    width: 238,
                  ),
                  const DefaultTextField(
                    label: "Valor",
                    width: 238,
                  ),
                  const Observation(
                    label: "Observação",
                    width: 238,
                    height: 122,
                  ),
                  CheckTile(
                    onTap: () {},
                    check: true,
                    title: "Imprimir comprovantes",
                    edgeInsets: const EdgeInsets.only(bottom: 20, left: 34),
                  ),
                  PrimaryButton(
                    title: "Inserir",
                    onTap: () async {
                      await animateTo(0);
                      widget.onBack();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationTab extends StatelessWidget {
  final String label;
  final int page;

  NavigationTab({
    super.key,
    required this.label,
    required this.page,
  });

  final CashMovementStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(right: 15),
          child: InkWell(
            borderRadius: BorderRadius.circular(5),
            onTap: () => store.setPage(page),
            child: Container(
              height: 32,
              padding: EdgeInsets.symmetric(
                horizontal: 15,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: getColors(context).onPrimary),
                borderRadius: BorderRadius.circular(5),
                color: page == store.page
                    ? getColors(context).onPrimary
                    : getColors(context).primary,
              ),
              alignment: Alignment.center,
              child: Text(
                label,
                style: getStyles(context).labelMedium!.copyWith(
                      color: page != store.page
                          ? getColors(context).onPrimary
                          : getColors(context).primary,
                    ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class FilterField extends StatelessWidget {
  final String label;

  const FilterField({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      width: 318,
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              textAlign: TextAlign.left,
              style: getStyles(context).labelMedium?.copyWith(
                    color: getColors(context).onSurface,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Spacer(),
          Container(
            width: 172,
            height: 44,
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: getColors(context).primaryContainer),
              borderRadius: BorderRadius.circular(15),
              color: getColors(context).primaryContainer.withOpacity(.2),
            ),
            alignment: Alignment.centerLeft,
            child: TextField(
              style: getStyles(context).bodyMedium?.copyWith(
                    color: getColors(context).onSurface,
                  ),
              decoration: const InputDecoration.collapsed(hintText: ""),
            ),
          )
        ],
      ),
    );
  }
}
