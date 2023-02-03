import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sat_movimento_de_caixa/app/modules/movimento_de_caixa/cash_movement_page.dart';
import 'package:sat_movimento_de_caixa/app/shared/widgets/confirm_popup.dart';
import 'package:sat_movimento_de_caixa/app/shared/widgets/custom_floating_button.dart';
import 'package:sat_movimento_de_caixa/app/shared/widgets/info.dart';
import 'package:sat_movimento_de_caixa/app/shared/widgets/secondary_button.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../constants/properties.dart';
import '../../../shared/utilities.dart';
import '../../../shared/widgets/default_text_field.dart';
import '../cash_movement_store.dart';

import 'dart:math' as math;

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses>
    with SingleTickerProviderStateMixin {
  ScrollController scrollController = ScrollController();

  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, value: 0);
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
              ScrollDirection.forward &&
          animationController.value == 1) {
        animationController.animateTo(0,
            curve: Curves.decelerate,
            duration: const Duration(milliseconds: 300));
      } else if (scrollController.position.userScrollDirection ==
              ScrollDirection.reverse &&
          animationController.value == 0) {
        animationController.animateTo(1,
            curve: Curves.decelerate,
            duration: const Duration(milliseconds: 300));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              const CustomTitle(
                title: "Dados da Despesa",
                top: 15,
              ),
              Row(
                children: [
                  hSpace(15),
                  Expanded(
                    child: DefaultTextField(
                      label: "Loja",
                      width: double.infinity,
                      onFocus: () {},
                    ),
                  ),
                  hSpace(16),
                  Expanded(
                    child: DefaultTextField(
                      label: "Despesa",
                      width: double.infinity,
                      onFocus: () {},
                    ),
                  ),
                  hSpace(15),
                ],
              ),
              DefaultTextField(
                label: "Operador de caixa",
                onFocus: () {},
              ),
              const DefaultTextField(
                label: "Histórico",
              ),
              const DefaultTextField(
                label: "Pago à",
              ),
              Row(
                children: [
                  hSpace(15),
                  Expanded(
                    child: DefaultTextField(
                      label: "Valor R\$",
                      width: double.infinity,
                      onFocus: () {},
                    ),
                  ),
                  hSpace(16),
                  Expanded(
                    child: DefaultTextField(
                      label: "Nota Fiscal",
                      width: double.infinity,
                      onFocus: () {},
                    ),
                  ),
                  hSpace(15),
                ],
              ),
              const CustomTitle(
                title: "Despesa para funcionários",
                isLeft: true,
                fontSize: 18,
              ),
              DefaultTextField(
                label: "Matrícula",
                onFocus: () {},
              ),
              DefaultTextField(
                label: "Dias para descontar",
                onFocus: () {},
              ),
              SecondaryButton(
                label: "Inserir Despesa no Caixa",
                icon: "insert",
                onTap: () {},
              ),
              const CustomTitle(
                title: "Quebra de Caixa",
              ),
              SecondaryButton(
                label: "Lançar quebra de Caixa",
                icon: "insert",
                onTap: () {},
              ),
              const InfoWidget(
                info:
                    "Uitilize esse botão para lançar um Vale para o Funcionário"
                    " no valor da Quebra de caixa",
              ),
            ],
          ),
        ),
        Positioned(
          right: 25,
          bottom: 75,
          child: AnimatedBuilder(
            animation: animationController,
            child: CustomFloatButton(
              child: SvgPicture.asset("./assets/svg/search.svg"),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ExpensesData(),
                  )),
            ),
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(animationController.value * 100, 0),
                child: child,
              );
            },
          ),
        ),
      ],
    );
  }
}

class ExpensesData extends StatefulWidget {
  const ExpensesData({super.key});

  @override
  State<ExpensesData> createState() => _ExpensesDataState();
}

class _ExpensesDataState extends State<ExpensesData>
    with SingleTickerProviderStateMixin {
  ScrollController scrollController = ScrollController();

  final CashMovementStore store = Modular.get();

  final DataPagerController dataPagerController = DataPagerController();

  late AnimationController animationController;

  final _menuLink = LayerLink();

  @override
  void initState() {
    animationController = AnimationController(vsync: this, value: 0);
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
              ScrollDirection.forward &&
          animationController.value == 1) {
        animationController.animateTo(0,
            curve: Curves.decelerate,
            duration: const Duration(milliseconds: 300));
      } else if (scrollController.position.userScrollDirection ==
              ScrollDirection.reverse &&
          animationController.value == 0) {
        animationController.animateTo(1,
            curve: Curves.decelerate,
            duration: const Duration(milliseconds: 300));
      }
    });
    super.initState();
  }

  double getXDProportion(double value) => (value / 426) * maxWidth(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Despesas",
          style: getStyles(context).titleMedium,
        ),
        actions: [
          InkWell(
            onTap: () => getOverlay(),
            child: CompositedTransformTarget(
              link: _menuLink,
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: SvgPicture.asset(
                  "./assets/svg/printer_light.svg",
                  width: 19,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Observer(
            builder: (context) {
              if (store.movementsDataGridSource == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                children: [
                  Container(
                    height: 1,
                    width: maxWidth(context),
                    color: getColors(context).onPrimary,
                  ),
                  Expanded(
                    // width: maxWidth(context),
                    // height: double.infinity,'
                    // color: Colors.red,
                    child: ScrollConfiguration(
                      behavior: MyCustomScrollBehavior(),
                      child: SfDataGridTheme(
                        data: SfDataGridThemeData(
                          gridLineColor: getColors(context).onSurfaceVariant,
                        ),
                        child: SfDataGrid(
                          verticalScrollController: scrollController,
                          headerGridLinesVisibility: GridLinesVisibility.both,
                          gridLinesVisibility: GridLinesVisibility.both,
                          source: store.movementsDataGridSource!,

                          // source: MovementsDataGridSource(
                          //   movements,
                          //   rowsPerPage: 30,
                          // ),
                          rowHeight: 26,
                          headerRowHeight: 26,
                          columns: [
                            GridColumn(
                              width: getXDProportion(81),
                              columnName: 'date',
                              label: Container(
                                color: getColors(context).primary,
                                alignment: Alignment.center,
                                child: Text(
                                  'Data',
                                  style: getStyles(context)
                                      .labelMedium!
                                      .copyWith(
                                          color: getColors(context).onPrimary,
                                          fontWeight: FontWeight.w900),
                                ),
                              ),
                            ),
                            GridColumn(
                              width: getXDProportion(60),
                              columnName: 'store',
                              label: Container(
                                color: getColors(context).primary,
                                alignment: Alignment.center,
                                child: Text(
                                  'Loja',
                                  style: getStyles(context)
                                      .labelMedium!
                                      .copyWith(
                                          color: getColors(context).onPrimary),
                                ),
                              ),
                            ),
                            GridColumn(
                              width: getXDProportion(120),
                              columnName: 'name',
                              label: Container(
                                color: getColors(context).primary,
                                alignment: Alignment.center,
                                child: Text(
                                  'Nome',
                                  style: getStyles(context)
                                      .labelMedium!
                                      .copyWith(
                                          color: getColors(context).onPrimary),
                                ),
                              ),
                            ),
                            GridColumn(
                              width: getXDProportion(105),
                              columnName: 'value',
                              label: Container(
                                color: getColors(context).primary,
                                alignment: Alignment.center,
                                child: Text(
                                  'Valor',
                                  style: getStyles(context)
                                      .labelMedium!
                                      .copyWith(
                                          color: getColors(context).onPrimary),
                                ),
                              ),
                            ),
                            GridColumn(
                              width: getXDProportion(105),
                              columnName: 'payed_to',
                              label: Container(
                                color: getColors(context).primary,
                                alignment: Alignment.center,
                                child: Text(
                                  'Pago a',
                                  style: getStyles(context)
                                      .labelMedium!
                                      .copyWith(
                                          color: getColors(context).onPrimary),
                                ),
                              ),
                            ),
                            GridColumn(
                              width: getXDProportion(105),
                              columnName: 'user',
                              label: Container(
                                color: getColors(context).primary,
                                alignment: Alignment.center,
                                child: Text(
                                  'Usuário',
                                  style: getStyles(context)
                                      .labelMedium!
                                      .copyWith(
                                          color: getColors(context).onPrimary),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SfDataPagerTheme(
                    data: SfDataPagerThemeData(
                      itemBorderRadius: BorderRadius.circular(4),
                    ),
                    child: SfDataPager(
                      pageCount:
                          store.movementsDataGridSource!.rows.length / 10,
                      controller: dataPagerController,
                      delegate: store.movementsDataGridSource!,
                      pageItemBuilder: (text) {
                        late int item;
                        try {
                          item = int.parse(text);
                        } catch (e) {
                          // print("e: $e");
                          return Transform.rotate(
                            angle: text == "First" || text == "Previous"
                                ? math.pi
                                : 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: getColors(context).primary),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                "./assets/svg/${text.toLowerCase()}.svg",
                                height: 16,
                              ),
                            ),
                          );
                        }
                        return Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: getColors(context).primary),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            (++item).toString(),
                            style: getStyles(context).labelLarge?.copyWith(
                                  color: dataPagerController.selectedPageIndex
                                              .toString() ==
                                          text
                                      ? getColors(context).onPrimary
                                      : getColors(context).primary,
                                ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            right: 25,
            bottom: 75,
            child: AnimatedBuilder(
              animation: animationController,
              child: CustomFloatButton(
                child: SvgPicture.asset("./assets/svg/trash_in.svg"),
                onTap: () {
                  late OverlayEntry overlay;
                  overlay = OverlayEntry(
                    builder: (context) => ConfirmPopup(
                      text:
                          "Tem certeza que deseja excluir a despesa selecionada?",
                      onConfirm: () => overlay.remove(),
                      onBack: () => overlay.remove(),
                    ),
                  );
                  Overlay.of(context)!.insert(overlay);
                },
              ),
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(animationController.value * 100, 0),
                  child: child,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  getOverlay() {
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
              offset: const Offset(-150, 15),
              link: _menuLink,
              child: Container(
                width: 169,
                height: 46,
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
                            padding: EdgeInsets.only(left: 10, right: 8),
                            child: SvgPicture.asset(
                              "./assets/svg/printer.svg",
                              width: 19,
                            ),
                          ),
                          Text(
                            "Imprimir recibo",
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
}

class CustomTitle extends StatelessWidget {
  const CustomTitle({
    super.key,
    required this.title,
    this.left,
    this.right,
    this.fontSize,
    this.isLeft = false,
    this.top,
    this.bottom = 15,
  });

  final String title;
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;
  final double? fontSize;
  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.fromLTRB(left ?? 15, top ?? 0, right ?? 15, bottom ?? 0),
      alignment: isLeft ? Alignment.centerLeft : Alignment.center,
      child: Text(
        title,
        style: getStyles(context).titleLarge!.copyWith(
              color: getColors(context).primary,
              fontSize: fontSize,
            ),
      ),
    );
  }
}
