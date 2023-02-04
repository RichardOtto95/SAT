import 'dart:ui';

import 'package:comum/constants/properties.dart';
import 'package:comum/utilities/custom_scroll_behavior.dart';
import 'package:comum/utilities/utilities.dart';
import 'package:comum/widgets/default_title.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({
    super.key,
    this.hint,
    required this.onBack,
    required this.title,
    required this.onSearch,
    required this.onConfirm,
    required this.focus,
    required this.gridColumns,
    required this.data,
  });

  final void Function() onBack;

  final void Function(String text) onSearch;

  final void Function(Map<String, dynamic>) onConfirm;

  final String title;

  final FocusNode focus;

  final String? hint;

  final List<GridColumnData> gridColumns;

  final List<Map<String, dynamic>> data;

  @override
  State<CustomDialog> createState() => CustomDialogState();
}

class GridColumnData {
  final String name;
  final String title;
  double width;

  GridColumnData(
    this.name,
    this.title,
    this.width,
  );
}

class CustomDialogState extends State<CustomDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  Map<String, dynamic> _selectedData = {};

  String _searchText = "";

  late List<GridColumnData> _gridColumns;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    _gridColumns = widget.gridColumns;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      animateTo(1);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> animateTo(double target) => _controller.animateTo(
        target,
        curve: Curves.decelerate,
        duration: const Duration(milliseconds: 450),
      );

  Future<CustomDataGridSource> getData() => Future.delayed(
        const Duration(seconds: 3),
        () => CustomDataGridSource(
          widget.data,
          rowsPerPage: 10,
          gridColumnDataList: widget.gridColumns,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: maxHeight(context),
      width: maxWidth(context),
      child: Material(
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
                animation: _controller,
                builder: (context, child) {
                  return BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: _controller.value + .001,
                      sigmaY: _controller.value + .001,
                    ),
                    child: Container(
                      height: maxHeight(context),
                      width: maxWidth(context),
                      color: getColors(context).shadow.withOpacity(
                            .3 * _controller.value,
                          ),
                    ),
                  );
                },
              ),
            ),
            ScaleTransition(
              scale: _controller,
              child: Container(
                // height: 612,
                // width: maxWidth(context) - 54,
                constraints: const BoxConstraints(
                  minHeight: 300,
                  maxHeight: 612,
                  minWidth: 350,
                  maxWidth: 800,
                ),
                margin: const EdgeInsets.fromLTRB(27, 80, 27, 100),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [defBoxShadow(context)],
                  color: getColors(context).surface,
                  border: Border.all(color: getColors(context).onSurface),
                ),
                child: Column(
                  children: [
                    DefaultTitle(
                      title: widget.title,
                      top: 15,
                      bottom: 15,
                    ),
                    DialogSearchField(
                      focus: FocusNode(),
                      onChanged: (String text) => _searchText = text,
                      onSearch: () {
                        widget.onSearch(_searchText);
                      },
                    ),
                    vSpace(15),
                    Expanded(
                      child: Container(
                        // height: double.infinity,
                        // width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: FutureBuilder<CustomDataGridSource>(
                          future: getData(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return ScrollConfiguration(
                              behavior: CustomScrollBehavior(),
                              child: SfDataGridTheme(
                                data: SfDataGridThemeData(
                                  gridLineColor:
                                      getColors(context).onSurfaceVariant,
                                  selectionColor:
                                      getColors(context).primaryContainer,
                                ),
                                child: SfDataGrid(
                                  headerGridLinesVisibility:
                                      GridLinesVisibility.both,
                                  gridLinesVisibility: GridLinesVisibility.both,
                                  source: snapshot.data!,
                                  rowHeight: 26,
                                  headerRowHeight: 26,
                                  selectionMode: SelectionMode.single,
                                  isScrollbarAlwaysShown: true,
                                  columnResizeMode: ColumnResizeMode.onResize,
                                  allowColumnsResizing: true,
                                  onColumnResizeUpdate: (details) {
                                    if (kDebugMode) {
                                      print(
                                          "details: ${details.column.columnName}");
                                    }
                                    _gridColumns
                                        .firstWhere((element) =>
                                            element.name ==
                                            details.column.columnName)
                                        .width = details.width;
                                    setState(() {});
                                    return true;
                                  },
                                  onCellTap: (details) {
                                    _selectedData = snapshot.data!._inputs[
                                        details.rowColumnIndex.rowIndex];
                                  },
                                  columns: [
                                    ..._gridColumns
                                        .map(((columnData) => GridColumn(
                                              width: columnData.width,
                                              columnName: columnData.name,
                                              label: Container(
                                                color:
                                                    getColors(context).primary,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  columnData.title,
                                                  style: getStyles(context)
                                                      .labelMedium!
                                                      .copyWith(
                                                          color:
                                                              getColors(context)
                                                                  .onPrimary,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                ),
                                              ),
                                            )))
                                        .toList(),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    vSpace(15),
                    BottomButtons(
                      onCancel: () async {
                        await animateTo(0);
                        widget.onBack();
                      },
                      onConclude: () async {
                        widget.onConfirm(_selectedData);
                        await animateTo(0);
                        widget.onBack();
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomDataGridSource extends DataGridSource {
  final int rowsPerPage;

  final List<Map<String, dynamic>> _inputs;

  final List<GridColumnData> gridColumnDataList;

  CustomDataGridSource(
    this._inputs, {
    required this.rowsPerPage,
    required this.gridColumnDataList,
  }) {
    _inputsData = _inputs
        .map<DataGridRow>((input) => DataGridRow(
            cells: gridColumnDataList
                .map((columnData) => DataGridCell(
                      columnName: columnData.name,
                      value: input[columnData.name],
                    ))
                .toList()))
        .toList();
  }

  List<Map<String, dynamic>> paginatedDataSource = [];

  List<DataGridRow> _inputsData = [];

  @override
  List<DataGridRow> get rows => _inputsData;

  setRows(movementsData) {
    _inputsData = movementsData;
    notifyListeners();
  }

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    // await Future.delayed(const Duration(seconds: 3));
    int startIndex = newPageIndex * rowsPerPage;
    int endIndex = startIndex + rowsPerPage;
    if (startIndex < _inputs.length) {
      if (endIndex > _inputs.length) {
        endIndex = _inputs.length;
      }
      paginatedDataSource =
          _inputs.getRange(startIndex, endIndex).toList(growable: false);
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
    _inputsData = _inputs
        .map<DataGridRow>((input) => DataGridRow(
            cells: gridColumnDataList
                .map((columnData) => DataGridCell(
                      columnName: columnData.name,
                      value: input[columnData.name],
                    ))
                .toList()))
        .toList();
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>(
      (e) {
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

class DialogSearchField extends StatelessWidget {
  const DialogSearchField({
    super.key,
    this.focus,
    this.hint,
    required this.onChanged,
    required this.onSearch,
  });

  final FocusNode? focus;

  final String? hint;

  final void Function(String text) onChanged;
  final void Function() onSearch;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: getColors(context).surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: getColors(context).primaryContainer),
        boxShadow: [defBoxShadow(context)],
      ),
      child: Row(
        children: [
          hSpace(20),
          Flexible(
            child: TextField(
              onChanged: onChanged,
              focusNode: focus,
              style: getStyles(context)
                  .displayMedium
                  ?.copyWith(color: getColors(context).onSurface),
              decoration: InputDecoration.collapsed(
                hintText: hint ?? "Buscar por código, nome, preço, etc.",
                hintStyle: getStyles(context).displayMedium?.copyWith(
                    color: getColors(context).onSurface.withOpacity(.4)),
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: 1,
            color: getColors(context).onPrimaryContainer,
          ),
          Material(
            color: Colors.transparent,
            child: IconButton(
              icon: SvgPicture.asset(
                "./assets/svg/search_blue.svg",
                width: 20,
              ),
              onPressed: onSearch,
            ),
          ),
        ],
      ),
    );
  }
}

class BottomButtons extends StatefulWidget {
  const BottomButtons(
      {super.key, required this.onCancel, required this.onConclude});

  final void Function() onCancel;

  final void Function() onConclude;
  @override
  State<BottomButtons> createState() => _BottomButtonsState();
}

class _BottomButtonsState extends State<BottomButtons> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                ),
                color: getColors(context).surface,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, -3),
                    blurRadius: 3,
                    color: getColors(context).shadow,
                  )
                ],
              ),
              position: DecorationPosition.background,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                  ),
                  onTap: widget.onCancel,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Cancelar",
                      style: getStyles(context).labelMedium?.copyWith(
                            color: Colors.red,
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(20),
                  ),
                  color: getColors(context).surface,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, -3),
                      blurRadius: 3,
                      color: getColors(context).shadow,
                    )
                  ]),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(20),
                  ),
                  onTap: () {
                    widget.onConclude();
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Concluir",
                      style: getStyles(context).labelMedium?.copyWith(
                            color: getColors(context).primary,
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
