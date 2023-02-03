import 'package:comum/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

class MyGrid extends StatefulWidget {
  const MyGrid({
    Key? key,
    this.onSelect,
    this.mode = PlutoGridMode.selectWithOneTap,
    // this.scroll,
  }) : super(key: key);

  final void Function(PlutoGridOnSelectedEvent selectEvent)? onSelect;

  final PlutoGridMode mode;

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
      mode: widget.mode,
      onLoaded: (PlutoGridOnLoadedEvent event) {
        stateManager = event.stateManager;
        stateManager.setShowColumnFilter(false);
        stateManager.setSelectingMode(PlutoGridSelectingMode.row);
        stateManager.handleOnSelected();
        // stateManager.scroll = widget.scoll ?? PlutoGridScrollController();
      },
      rowColorCallback: (rowColorContext) {
        return rowColorContext.rowIdx % 2 == 0
            ? getColors(context).background
            : getColors(context).surface;
      },
      onSelected: (event) {
        mounted;
        if (!firstBuild && widget.onSelect != null) {
          widget.onSelect!(event);
        } else if (widget.onSelect != null) {
          firstBuild = false;
        }
      },
      configuration: PlutoGridConfiguration(
        localeText: const PlutoGridLocaleText(),
        style: PlutoGridStyleConfig(
          activatedBorderColor: Colors.primaries.first,
          inactivatedBorderColor: getColors(context).primary,
          borderColor: getColors(context).onSurface,
          gridBorderColor: getColors(context).onSurface,
          iconColor: Colors.transparent,
          gridBackgroundColor: getColors(context).primary,
          columnHeight: 26,
          rowHeight: 26,
          cellTextStyle: getStyles(context).bodySmall!,
          columnTextStyle: TextStyle(
            color: getColors(context).onPrimary,
          ),
          activatedColor: getColors(context).secondary,
        ),
      ),
    );
  }
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
      "width": 60.0,
    },
    {
      "productCode": "Código",
      "width": 80.0,
    },
    {
      "barcode": "Código de Barras",
      "width": 130.0,
    },
    {
      "sizeColor": "Tam/Cor",
      "width": 100.0,
    },
    {
      "description": "Descrição do Item",
      "width": 150.0,
    },
    {
      "additionalDescription": "Descrição Adicional",
      "width": 150.0,
    },
    {
      "detailedDescription": "Descrição Detalhada",
      "width": 150.0,
    },
    {
      "unitType": "UN",
      "width": 100.0,
    },
    {
      "amountDemanded": "Qtd Pedida",
      "width": 100.0,
    },
    {
      "amountChecked": "Qtd Recebida",
      "width": 120.0,
    },
    {
      "amountArrived": "Qtd Conferida",
      "width": 120.0,
    },
    {
      "packingAmount": "Qtd Chegada",
      "width": 120.0,
    },
    {
      "totalPackingAmount": "Qtd Embalagem",
      "width": 120.0,
    },
    {
      "unitaryValue": "Valor Unitário",
      "width": 120.0,
    },
    {
      "totalValue": "Valor Total",
      "width": 120.0,
    },
    {
      "discount": "Desconto",
      "width": 100.0,
    },
    {
      "cost": "Preço de Compra",
      "width": 130.0,
    },
    {
      "ncm": "NCM",
      "width": 100.0,
    },
    {
      "ncmDescription": "NCM Descrição",
      "width": 150.0,
    },
    {
      "cest": "CEST",
      "width": 100.0,
    },
    {
      "fiscalFigure": "Figura Fiscal",
      "width": 100.0,
    },
    {
      "fiscalFiguraDescription": "Figura Fiscal Descrição",
      "width": 160.0,
    },
    {
      "cfop": "CFOP",
      "width": 80.0,
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
