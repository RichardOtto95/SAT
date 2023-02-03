import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../shared/utilities.dart';
import '../../../shared/widgets/default_text_field.dart';
import '../cash_movement_store.dart';

class InputsOutputs extends StatefulWidget {
  const InputsOutputs({super.key});

  @override
  State<InputsOutputs> createState() => _InputsOutputsState();
}

class _InputsOutputsState extends State<InputsOutputs> {
  final CashMovementStore store = Modular.get();

  final DataPagerController dataPagerController = DataPagerController();

  double getXDProportion(double value) => (value / 426) * maxWidth(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
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
                child: SfDataGridTheme(
                  data: SfDataGridThemeData(
                    gridLineColor: getColors(context).onSurfaceVariant,
                  ),
                  child: SfDataGrid(
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
                            style: getStyles(context)
                                .labelMedium!
                                .copyWith(color: getColors(context).onPrimary),
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
                                .copyWith(color: getColors(context).onPrimary),
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
                                .copyWith(color: getColors(context).onPrimary),
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
                                .copyWith(color: getColors(context).onPrimary),
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
                                .copyWith(color: getColors(context).onPrimary),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              vSpace(15),
              Row(
                children: [
                  hSpace(15),
                  const Expanded(
                    child: DefaultTextField(
                      label: "Entrada",
                      color: Colors.green,
                      width: double.infinity,
                    ),
                  ),
                  hSpace(16),
                  const Expanded(
                    child: DefaultTextField(
                      label: "Saída",
                      color: Colors.red,
                      width: double.infinity,
                    ),
                  ),
                  hSpace(15),
                ],
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
                        angle:
                            text == "First" || text == "Previous" ? math.pi : 0,
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
    );
  }
}
