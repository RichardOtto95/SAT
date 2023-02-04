import 'package:comum/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../orders_store.dart';
import 'dart:math' as math;

class DefaultClientGrid extends StatefulWidget {
  final OrdersStore store;
  final bool withListener;
  final void Function(DataGridCellTapDetails details)? onCellTap;

  const DefaultClientGrid({
    super.key,
    required this.store,
    this.withListener = true,
    this.onCellTap,
  });

  @override
  State<DefaultClientGrid> createState() => _DefaultClientGridState();
}

class _DefaultClientGridState extends State<DefaultClientGrid> {
  ScrollController? scrollController;
  ScrollController? horizontalScrollController;

  @override
  void initState() {
    widget.store.suppliersDataGridSource = null;
    widget.store.getSuppliersDataGridSource();
    // scrollController = ScrollController();
    if (widget.withListener) {
      scrollController = ScrollController();
      scrollController!.addListener(() {
        if (scrollController!.position.userScrollDirection ==
                ScrollDirection.reverse &&
            widget.store.showCheckFloat) {
          widget.store.setShowCheckFloat(false);
        } else if (scrollController!.position.userScrollDirection ==
                ScrollDirection.forward &&
            !widget.store.showCheckFloat) {
          widget.store.setShowCheckFloat(true);
        }
      });
      horizontalScrollController = ScrollController();
      horizontalScrollController!.addListener(() {
        if (horizontalScrollController!.position.userScrollDirection ==
                ScrollDirection.reverse &&
            widget.store.showCheckFloat) {
          widget.store.setShowCheckFloat(false);
        } else if (horizontalScrollController!.position.userScrollDirection ==
                ScrollDirection.forward &&
            !widget.store.showCheckFloat) {
          widget.store.setShowCheckFloat(true);
        }
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    if (scrollController != null) {
      scrollController!.removeListener(() {});
      scrollController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      if (widget.store.suppliersDataGridSource == null) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return SfDataGridTheme(
        data: SfDataGridThemeData(
          gridLineColor: getColors(context).onSurfaceVariant,
        ),
        child: SfDataGrid(
          headerGridLinesVisibility: GridLinesVisibility.both,
          gridLinesVisibility: GridLinesVisibility.both,
          source: widget.store.suppliersDataGridSource!,
          rowHeight: 26,
          headerRowHeight: 26,
          verticalScrollController: scrollController,
          horizontalScrollController: horizontalScrollController,
          onCellTap: widget.onCellTap,
          columns: [
            GridColumn(
              width: 81,
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
              width: 60,
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
              width: 120,
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
              width: 105,
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
              width: 105,
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
              width: 105,
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
      );
    });
  }
}

class DefaultDataPager extends StatelessWidget {
  const DefaultDataPager(
      {super.key, required this.dataPagerController, required this.store});

  final DataPagerController dataPagerController;

  final OrdersStore store;

  @override
  Widget build(BuildContext context) {
    if (store.suppliersDataGridSource == null) return Container();
    return SfDataPagerTheme(
      data: SfDataPagerThemeData(
        itemBorderRadius: BorderRadius.circular(4),
      ),
      child: SfDataPager(
        pageCount: store.suppliersDataGridSource!.rows.length / 10,
        controller: dataPagerController,
        delegate: store.suppliersDataGridSource!,
        pageItemBuilder: (text) {
          if (text == "First" || text == "Previous") {
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
              text,
              style: getStyles(context).labelLarge?.copyWith(
                    color:
                        dataPagerController.selectedPageIndex.toString() == text
                            ? getColors(context).onPrimary
                            : getColors(context).primary,
                  ),
            ),
          );
        },
      ),
    );
  }
}
