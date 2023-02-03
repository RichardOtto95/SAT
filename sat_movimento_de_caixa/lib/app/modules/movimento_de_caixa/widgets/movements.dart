import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sat_movimento_de_caixa/app/modules/movimento_de_caixa/cash_movement_store.dart';
import 'package:sat_movimento_de_caixa/app/shared/utilities.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'dart:math' as math;

class Movements extends StatefulWidget {
  const Movements({super.key});

  @override
  State<Movements> createState() => _MovementsState();
}

class _MovementsState extends State<Movements> {
  final CashMovementStore store = Modular.get();

  final DataPagerController dataPagerController = DataPagerController();

  @override
  void initState() {
    store.getMovementsDataGridSource();
    super.initState();
  }

  @override
  void dispose() {
    dataPagerController.dispose();
    super.dispose();
  }

  double getXDProportion(double value) => (value / 426) * maxWidth(context);

  @override
  Widget build(BuildContext context) {
    return Observer(
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
                      angle:
                          text == "First" || text == "Previous" ? math.pi : 0,
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
        );
      },
    );
  }
}

class Employee {
  Employee(this.id, this.name, this.designation, this.salary);
  final int id;
  final String name;
  final String designation;
  final int salary;
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({required List<Employee> employees}) {
    dataGridRows = employees
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: dataGridRow.id),
              DataGridCell<String>(columnName: 'name', value: dataGridRow.name),
              DataGridCell<String>(
                  columnName: 'designation', value: dataGridRow.designation),
              DataGridCell<int>(
                  columnName: 'salary', value: dataGridRow.salary),
            ]))
        .toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
          alignment: (dataGridCell.columnName == 'id' ||
                  dataGridCell.columnName == 'salary')
              ? Alignment.centerRight
              : Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis,
          ));
    }).toList());
  }
}
