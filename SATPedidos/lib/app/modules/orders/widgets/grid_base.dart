import 'package:comum/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

class MyGrid extends StatefulWidget {
  const MyGrid({Key? key, this.onSelect}) : super(key: key);

  final void Function(PlutoGridOnSelectedEvent)? onSelect;

  @override
  State<MyGrid> createState() => _MyGridState();
}

class _MyGridState extends State<MyGrid> {
  static final List<Item> items = List.generate(
    40,
    (index) => Item(
      code: index++,
      productCode: 03677 + index,
      barcode: 21381832121 + index,
      sizeColor: "38-Preto",
      description: "description",
      additionalDescription: "additionalDescription",
      detailedDescription: "detailedDescription",
      unitType: "unitType",
      amountDemanded: 3 * index,
      packingAmount: 1,
      totalPackingAmount: 1,
      unitaryValue: 75.81 * index,
      totalValue: 0,
      discount: 0,
      cost: 75.81 * index,
      ncm: 85166000,
      ncmDescription: "Outros fornos; fogões",
      cest: 2104700 + index,
      fiscalFigure: 1,
      fiscalFiguraDescription: "Calçados geral",
      cfop: 2108 + index,
    ),
  );

  late final List<PlutoColumn> columns;

  late final List<PlutoRow> rows;

  final List<PlutoColumnGroup> columnGroups = [];

  late final PlutoGridStateManager stateManager;

  @override
  void initState() {
    columns = Item.fields
        .map((Map fieldMap) => PlutoColumn(
              width: fieldMap["width"].toDouble(),
              textAlign: PlutoColumnTextAlign.center,
              titleTextAlign: PlutoColumnTextAlign.center,
              title: fieldMap.values.first,
              field: fieldMap.keys.first,
              type: getColumnType(fieldMap.keys.first, fieldMap.values.first),
              enableFilterMenuItem: false,
            ))
        .toList();
    rows = items.map((item) => PlutoRow(cells: createCellsMap(item))).toList();
    super.initState();
  }

  PlutoColumnType getColumnType(String key, dynamic value) {
    return PlutoColumnType.text();
  }

  Map<String, PlutoCell> createCellsMap(Item item) {
    Map<String, dynamic> itemMap = item.toJson();
    Map<String, PlutoCell> cellsMap = {};
    for (String key in itemMap.keys) {
      cellsMap[key] = PlutoCell(value: itemMap[key].toString());
    }
    return cellsMap;
  }

  bool firstBuild = true;

  @override
  Widget build(BuildContext context) {
    return PlutoGrid(
      columns: columns,
      rows: rows,
      columnGroups: columnGroups,
      mode: PlutoGridMode.selectWithOneTap,
      onLoaded: (PlutoGridOnLoadedEvent event) {
        stateManager = event.stateManager;
        stateManager.setShowColumnFilter(false);
        stateManager.setSelectingMode(PlutoGridSelectingMode.row);
        stateManager.handleOnSelected();
      },
      rowColorCallback: (rowColorContext) {
        // print("${rowColorContext.rowIdx} & ${rowColorContext.rowIdx % 2}");
        return rowColorContext.rowIdx % 2 == 0
            ? const Color(0xffffffff)
            : const Color(0xfff8f8f8);
      },
      // onChanged: (event) => print(""),
      // onColumnsMoved: (event) => print(""),
      // onRowChecked: (event) => print(""),
      // onRowDoubleTap: (event) => print(""),
      // onRowSecondaryTap: (event) => print(""),
      // onRowsMoved: (event) => print(""),
      onSelected: (event) {
        mounted;
        if (!firstBuild && widget.onSelect != null) {
          widget.onSelect!(event);
        } else if (widget.onSelect != null) {
          firstBuild = false;
        }
      },
      // onSorted: (event) => print(""),
      configuration: PlutoGridConfiguration(
        localeText: const PlutoGridLocaleText(),
        style: PlutoGridStyleConfig(
          activatedBorderColor: Colors.primaries.first,
          inactivatedBorderColor: getColors(context).primary,
          borderColor: const Color(0xffE5E5E5),
          gridBorderColor: const Color(0xffE5E5E5),
          iconColor: Colors.transparent,
          gridBackgroundColor: getColors(context).primary,
          columnHeight: 26,
          rowHeight: 26,
          columnTextStyle: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class GridValues {
  GridValues() {
    columns = Item.fields
        .map((Map fieldMap) => PlutoColumn(
              width: fieldMap["width"],
              textAlign: PlutoColumnTextAlign.center,
              titleTextAlign: PlutoColumnTextAlign.center,
              title: fieldMap.values.first,
              field: fieldMap.keys.first,
              type: getColumnType(fieldMap.keys.first, fieldMap.values.first),
              enableFilterMenuItem: false,
            ))
        .toList();
    rows = items.map((item) => PlutoRow(cells: createCellsMap(item))).toList();
  }

  static final List<Item> items = List.generate(
    40,
    (index) => Item(
      code: index++,
      productCode: 03677 + index,
      barcode: 21381832121 + index,
      sizeColor: "38-Preto",
      description: "description",
      additionalDescription: "additionalDescription",
      detailedDescription: "detailedDescription",
      unitType: "unitType",
      amountDemanded: 3 * index,
      packingAmount: 1,
      totalPackingAmount: 1,
      unitaryValue: 75.81 * index,
      totalValue: 0,
      discount: 0,
      cost: 75.81 * index,
      ncm: 85166000,
      ncmDescription: "Outros fornos; fogões",
      cest: 2104700 + index,
      fiscalFigure: 1,
      fiscalFiguraDescription: "Calçados geral",
      cfop: 2108 + index,
    ),
  );

  late final List<PlutoColumn> columns;
  late final List<PlutoRow> rows;
  late final PlutoGridStateManager stateManager;
  PlutoColumnType getColumnType(String key, dynamic value) {
    return PlutoColumnType.text();
  }

  Map<String, PlutoCell> createCellsMap(Item item) {
    Map<String, dynamic> itemMap = item.toJson();
    Map<String, PlutoCell> cellsMap = {};
    for (String key in itemMap.keys) {
      cellsMap[key] = PlutoCell(value: itemMap[key].toString());
    }
    return cellsMap;
  }

  Widget grid(context) => PlutoGrid(
        columns: columns,
        rows: rows,
        onLoaded: (PlutoGridOnLoadedEvent event) {
          stateManager = event.stateManager;
          stateManager.setShowColumnFilter(false);
          stateManager.setSelectingMode(PlutoGridSelectingMode.row);
          stateManager.handleOnSelected();
        },
        rowColorCallback: (rowColorContext) {
          // print("${rowColorContext.rowIdx} & ${rowColorContext.rowIdx % 2}");
          return rowColorContext.rowIdx % 2 == 0
              ? const Color(0xffffffff)
              : const Color(0xfff8f8f8);
        },
        mode: PlutoGridMode.select,
        // onChanged: (event) => print(""),
        // onColumnsMoved: (event) => print(""),
        // onRowChecked: (event) => print(""),
        // onRowDoubleTap: (event) => print(""),
        // onRowSecondaryTap: (event) => print(""),
        // onRowsMoved: (event) => print(""),
        // onSelected: (event) => print(""),
        // onSorted: (event) => print(""),
        configuration: PlutoGridConfiguration(
          localeText: const PlutoGridLocaleText(),
          style: PlutoGridStyleConfig(
            activatedBorderColor: Colors.primaries.first,
            inactivatedBorderColor: getColors(context).primary,
            borderColor: const Color(0xffE5E5E5),
            gridBorderColor: const Color(0xffE5E5E5),
            iconColor: Colors.transparent,
            gridBackgroundColor: getColors(context).primary,
            columnHeight: 26,
            rowHeight: 26,
            columnTextStyle: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
}

class Item {
  final int code;
  final int productCode;
  final int? barcode;
  final String sizeColor;
  final String description;
  final String additionalDescription;
  final String detailedDescription;
  final String unitType;
  final int amountDemanded;
  final int? amountChecked;
  final int? amountArrived;
  final int packingAmount;
  final int totalPackingAmount;
  final double unitaryValue;
  final double totalValue;
  final double discount;
  final double cost;
  final int ncm;
  final String ncmDescription;
  final int cest;
  final int fiscalFigure;
  final String fiscalFiguraDescription;
  final int cfop;

  Item({
    required this.code,
    required this.productCode,
    this.barcode,
    required this.sizeColor,
    required this.description,
    required this.additionalDescription,
    required this.detailedDescription,
    required this.unitType,
    required this.amountDemanded,
    this.amountChecked,
    this.amountArrived,
    required this.packingAmount,
    required this.totalPackingAmount,
    required this.unitaryValue,
    required this.totalValue,
    required this.discount,
    required this.cost,
    required this.ncm,
    required this.ncmDescription,
    required this.cest,
    required this.fiscalFigure,
    required this.fiscalFiguraDescription,
    required this.cfop,
  });

  static List<Map<String, dynamic>> fields = [
    {
      "code": "Item",
      "width": 60,
    },
    {
      "productCode": "Código",
      "width": 80,
    },
    {
      "barcode": "Código de Barras",
      "width": 130,
    },
    {
      "sizeColor": "Tam/Cor",
      "width": 100,
    },
    {
      "description": "Descrição do Item",
      "width": 150,
    },
    {
      "additionalDescription": "Descrição Adicional",
      "width": 150,
    },
    {
      "detailedDescription": "Descrição Detalhada",
      "width": 150,
    },
    {
      "unitType": "UN",
      "width": 100,
    },
    {
      "amountDemanded": "Qtd Pedida",
      "width": 100,
    },
    {
      "amountChecked": "Qtd Recebida",
      "width": 120,
    },
    {
      "amountArrived": "Qtd Conferida",
      "width": 120,
    },
    {
      "packingAmount": "Qtd Chegada",
      "width": 120,
    },
    {
      "totalPackingAmount": "Qtd Embalagem",
      "width": 120,
    },
    {
      "unitaryValue": "Valor Unitário",
      "width": 120,
    },
    {
      "totalValue": "Valor Total",
      "width": 120,
    },
    {
      "discount": "Desconto",
      "width": 100,
    },
    {
      "cost": "Preço de Compra",
      "width": 130,
    },
    {
      "ncm": "NCM",
      "width": 100,
    },
    {
      "ncmDescription": "NCM Descrição",
      "width": 150,
    },
    {
      "cest": "CEST",
      "width": 100,
    },
    {
      "fiscalFigure": "Figura Fiscal",
      "width": 100,
    },
    {
      "fiscalFiguraDescription": "Figura Fiscal Descrição",
      "width": 160,
    },
    {
      "cfop": "CFOP",
      "width": 80,
    },
  ];

  Map<String, dynamic> toJson() => {
        "code": code,
        "productCode": productCode,
        "barcode": barcode,
        "sizeColor": sizeColor,
        "description": description,
        "additionalDescription": additionalDescription,
        "detailedDescription": detailedDescription,
        "unitType": unitType,
        "amountDemanded": amountDemanded,
        "amountChecked": amountChecked,
        "amountArrived": amountArrived,
        "packingAmount": packingAmount,
        "totalPackingAmount": totalPackingAmount,
        "unitaryValue": unitaryValue,
        "totalValue": totalValue,
        "discount": discount,
        "cost": cost,
        "ncm": ncm,
        "ncmDescription": ncmDescription,
        "cest": cest,
        "fiscalFigure": fiscalFigure,
        "fiscalFiguraDescription": fiscalFiguraDescription,
        "cfop": cfop
      };
}
