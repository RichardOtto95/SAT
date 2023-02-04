import 'package:comum/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../modules/orders/orders_store.dart';

class SuppliersDataGridSource extends DataGridSource {
  final int rowsPerPage;

  final List<Map<String, dynamic>> _movements;

  final OrdersStore store = Modular.get();

  SuppliersDataGridSource(this._movements, {required this.rowsPerPage}) {
    _movementsData = _movements
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell(columnName: 'date', value: e["date"]),
              DataGridCell(columnName: 'store', value: e["store"]),
              DataGridCell(columnName: 'name', value: e["name"]),
              DataGridCell(columnName: 'value', value: e["value"]),
              DataGridCell(columnName: 'payed_to', value: e["payed_to"]),
              DataGridCell(columnName: 'user', value: e["user"]),
              DataGridCell(columnName: 'value', value: e["value"]),
              DataGridCell(columnName: 'payed_to', value: e["payed_to"]),
              DataGridCell(columnName: 'user', value: e["user"]),
            ]))
        .toList();
  }

  List<Map<String, dynamic>> paginatedDataSource = [];

  List<DataGridRow> _movementsData = [];

  @override
  List<DataGridRow> get rows => _movementsData;

  setRows(movementsData) {
    _movementsData = movementsData;
    notifyListeners();
  }

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    // await Future.delayed(const Duration(seconds: 3));
    int startIndex = newPageIndex * rowsPerPage;
    int endIndex = startIndex + rowsPerPage;
    if (startIndex < _movements.length) {
      if (endIndex > _movements.length) {
        endIndex = _movements.length;
      }
      paginatedDataSource =
          _movements.getRange(startIndex, endIndex).toList(growable: false);
      buildDataGridRows();
    } else {
      paginatedDataSource = [];
    }
    notifyListeners();
    return true;
  }

  @override
  Future<void> handleRefresh() {
    return Future.delayed(const Duration(seconds: 2), () {
      buildDataGridRows();
      notifyListeners();
    });
  }

  void buildDataGridRows() {
    _movementsData = _movements
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell(columnName: 'date', value: e["date"]),
              DataGridCell(columnName: 'store', value: e["store"]),
              DataGridCell(columnName: 'name', value: e["name"]),
              DataGridCell(columnName: 'value', value: e["value"]),
              DataGridCell(columnName: 'payed_to', value: e["payed_to"]),
              DataGridCell(columnName: 'user', value: e["user"]),
              DataGridCell(columnName: 'value', value: e["value"]),
              DataGridCell(columnName: 'payed_to', value: e["payed_to"]),
              DataGridCell(columnName: 'user', value: e["user"]),
            ]))
        .toList();
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>(
      (e) {
        // print("value: ${e.value}");r
        switch (e.columnName) {
          default:
            String value;
            if (e.value == null) {
              value = '- - -';
            } else {
              value = e.value.toString();
            }
            return Builder(
              builder: (context) {
                return Container(
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  // padding: EdgeInsets.all(8.0),
                  child: Text(
                    value,
                    maxLines: 1,
                    style: getStyles(context).displayMedium,
                  ),
                );
              },
            );
        }
      },
    ).toList());
  }
}
