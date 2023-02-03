import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sat_movimento_de_caixa/app/modules/movimento_de_caixa/cash_movement_store.dart';
import 'package:sat_movimento_de_caixa/app/shared/utilities.dart';
import 'package:sat_movimento_de_caixa/app/shared/widgets/default_text_field.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'dart:math' as math;

class InfoPage extends StatefulWidget {
  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final CashMovementStore store = Modular.get();

  final DataPagerController dataPagerController = DataPagerController();

  double getXDProportion(double value) => (value / 426) * maxWidth(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Informações",
          style: getStyles(context).titleMedium,
        ),
      ),
      body: Column(
        children: [
          vSpace(15),
          Row(
            children: [
              hSpace(20),
              Expanded(
                child: DefaultTextField(
                  label: "Data Inicial",
                  width: double.infinity,
                  onFocus: () {},
                ),
              ),
              hSpace(16),
              Expanded(
                child: DefaultTextField(
                  label: "Data Final",
                  width: double.infinity,
                  onFocus: () {},
                ),
              ),
              hSpace(20),
            ],
          ),
          Expanded(
            // width: maxWidth(context),
            // height: double.infinity,'
            // color: Colors.red,
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
                    angle: text == "First" || text == "Previous" ? math.pi : 0,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: getColors(context).primary),
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
      ),
    );
  }
}
