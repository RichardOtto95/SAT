import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sat_movimento_de_caixa/app/modules/movimento_de_caixa/widgets/expenses.dart';
import 'package:sat_movimento_de_caixa/app/shared/widgets/default_overlay_slider.dart';
import 'package:sat_movimento_de_caixa/app/shared/widgets/secondary_button.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'dart:math' as math;
import '../../../shared/utilities.dart';
import '../cash_movement_page.dart';
import '../cash_movement_store.dart';

class PreviousReceipts extends StatefulWidget {
  const PreviousReceipts({super.key});

  @override
  State<PreviousReceipts> createState() => _PreviousReceiptsState();
}

class _PreviousReceiptsState extends State<PreviousReceipts>
    with SingleTickerProviderStateMixin {
  ScrollController scrollController = ScrollController();

  final DataPagerController dataPagerController = DataPagerController();

  final CashMovementStore store = Modular.get();

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

  double getXDProportion(double value) => (value / 426) * maxWidth(context);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                        onCellTap: (_) {
                          late OverlayEntry entry;
                          entry = OverlayEntry(
                            builder: (context) => DefaultOverlaySlider(
                              height: 300,
                              onBack: () => entry.remove(),
                              child: Column(
                                children: [
                                  const CustomTitle(
                                    title: "Nome da despesa",
                                    top: 25,
                                    bottom: 25,
                                  ),
                                  SecondaryButton(
                                    label: "Estornar",
                                    onTap: () {},
                                    icon: "trash_out",
                                  ),
                                  SecondaryButton(
                                    label: "Visualizar origem",
                                    onTap: () {},
                                    icon: "visualizar_origem",
                                  ),
                                  SecondaryButton(
                                    label: "Imprimir recibo",
                                    onTap: () {},
                                    icon: "imprimir_recibo",
                                  ),
                                ],
                              ),
                            ),
                          );
                          Overlay.of(context)?.insert(entry);
                        },
                        columns: [
                          GridColumn(
                            width: getXDProportion(81),
                            columnName: 'date',
                            label: Container(
                              color: getColors(context).primary,
                              alignment: Alignment.center,
                              child: Text(
                                'Data',
                                style: getStyles(context).labelMedium!.copyWith(
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
                                style: getStyles(context).labelMedium!.copyWith(
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
                                style: getStyles(context).labelMedium!.copyWith(
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
                                style: getStyles(context).labelMedium!.copyWith(
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
                                style: getStyles(context).labelMedium!.copyWith(
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
                                style: getStyles(context).labelMedium!.copyWith(
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
                    pageCount: store.movementsDataGridSource!.rows.length / 10,
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
                              border:
                                  Border.all(color: getColors(context).primary),
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
                          border: Border.all(color: getColors(context).primary),
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
        // Positioned(
        //   right: 25,
        //   bottom: 75,
        //   child: AnimatedBuilder(
        //     animation: animationController,
        //     child: CustomFloatButton(
        //       child: SvgPicture.asset("./assets/svg/trash_in.svg"),
        //       onTap: () {
        //         late OverlayEntry overlay;
        //         overlay = OverlayEntry(
        //           builder: (context) => ConfirmPopup(
        //             text:
        //                 "Tem certeza que deseja excluir a despesa selecionada?",
        //             onConfirm: () => overlay.remove(),
        //             onBack: () => overlay.remove(),
        //           ),
        //         );
        //         Overlay.of(context)!.insert(overlay);
        //       },
        //     ),
        //     builder: (context, child) {
        //       return Transform.translate(
        //         offset: Offset(animationController.value * 100, 0),
        //         child: child,
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }
}
