import 'package:comum/constants/properties.dart';
import 'package:comum/utilities/utilities.dart';
import 'package:comum/widgets/confirm_popup.dart';
import 'package:comum/widgets/container_text_field.dart';
import 'package:comum/widgets/custom_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sat_orders/app/modules/orders/widgets/custom_dialog.dart';
import 'package:sat_orders/app/modules/orders/widgets/test_data.dart';

import '../orders_store.dart';

class OrderAppBar extends StatefulWidget {
  const OrderAppBar({super.key});

  @override
  State<OrderAppBar> createState() => OrderAppBarState();
}

class TabModel {
  final String label;
  final int page;

  TabModel(this.label, this.page);
}

class OrderAppBarState extends State<OrderAppBar>
    with SingleTickerProviderStateMixin {
  OverlayEntry? menuOverlay;

  // late final AnimationController filterController;

  final _layerLink = LayerLink();

  final OrdersStore store = Modular.get();

  final List<TabModel> horizontalTabs = [
    TabModel("Produtos / Serviços", 0),
    TabModel("Cliente", 1),
    TabModel("Ordem de Serviço", 2),
    TabModel("Requisição", 3),
    TabModel("Entrega e Montagem", 4),
    TabModel("Informações", 5),
    TabModel("Observações", 6),
    TabModel("Condições", 7),
    TabModel("Históricos", 8),
    TabModel("Despesas", 9),
    TabModel("Outras Opções", 10),
    TabModel("Impressões", 11),
    TabModel("Comissões", 12),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: viewPaddingTop(context) + 104,
          width: maxWidth(context),
          decoration: BoxDecoration(
            color: getColors(context).primary,
            boxShadow: [defBoxShadow(context)],
          ),
          padding: EdgeInsets.only(top: viewPaddingTop(context)),
          alignment: Alignment.topCenter,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Material(
                color: Colors.transparent,
                child: Column(
                  children: [
                    vSpace(5),
                    Row(
                      children: [
                        hSpace(5),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              // radius: 300,
                              borderRadius: BorderRadius.circular(300),

                              child: Container(
                                height: 50,
                                width: 50,
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.arrow_back_rounded,
                                  // size:
                                ),
                              ),
                              onTap: () {
                                store.setShowCheckFloat(true);
                                // Modular.to.pop();
                              },
                            ),
                          ),
                        ),
                        Text(
                          "Pedidos",
                          style: getStyles(context).titleMedium,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  late OverlayEntry entry;
                                  entry = OverlayEntry(
                                    builder: (context) => CustomDialog(
                                      onBack: () {
                                        entry.remove();
                                      },
                                      onSearch: (text) => () {},
                                      onConfirm: (data) {
                                        if (kDebugMode) {
                                          print("Data: $data");
                                        }
                                      },
                                      title: "Lista de Figura Fiscal",
                                      focus: FocusNode(),
                                      data: suppliers,
                                      gridColumns: sellerGridData,
                                    ),
                                  );
                                  Overlay.of(context)?.insert(entry);
                                },
                                icon: SvgPicture.asset(
                                  "./assets/svg/search.svg",
                                  color: getColors(context).onPrimary,
                                  width: 25,
                                ),
                              ),
                              hSpace(10),
                              CompositedTransformTarget(
                                link: _layerLink,
                                child: IconButton(
                                  onPressed: () {
                                    menuOverlay = getMenuOverlay();
                                    Overlay.of(context)?.insert(menuOverlay!);
                                  },
                                  icon: SvgPicture.asset(
                                    "./assets/svg/menu.svg",
                                    color: getColors(context).onPrimary,
                                    width: 25,
                                  ),
                                ),
                              ),
                              hSpace(10),
                            ],
                          ),
                        ),
                        hSpace(5),
                      ],
                    ),
                    vSpace(5),
                    tabs(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<GridColumnData> sellerGridData = [
    GridColumnData("date", "Data", 81),
    GridColumnData("store", "Loja", 60),
    GridColumnData("name", "Nome", 120),
    GridColumnData("value", "Valor", 105),
    GridColumnData("payed_to", "Pago à", 105),
    GridColumnData("user", "Usuário", 105),
    GridColumnData("date", "Data", 81),
    GridColumnData("store", "Loja", 60),
    GridColumnData("name", "Nome", 120),
    GridColumnData("value", "Valor", 105),
    GridColumnData("payed_to", "Pago à", 105),
    GridColumnData("user", "Usuário", 105),
    GridColumnData("date", "Data", 81),
    GridColumnData("store", "Loja", 60),
    GridColumnData("name", "Nome", 120),
    GridColumnData("value", "Valor", 105),
    GridColumnData("payed_to", "Pago à", 105),
    GridColumnData("user", "Usuário", 105),
  ];

  tabs() {
    return SizedBox(
      width: maxWidth(context),
      height: 44,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 10, bottom: 10),
        child: Row(
          children: horizontalTabs
              .map<Widget>(
                (tab) => Observer(
                  builder: (context) {
                    return Material(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () => store.setPage(tab.page),
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: getColors(context).onPrimary),
                                borderRadius: BorderRadius.circular(5),
                                color: store.page == tab.page
                                    ? getColors(context).onPrimary
                                    : getColors(context).primary,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                tab.label,
                                style: getStyles(context).labelMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: store.page != tab.page
                                          ? getColors(context).onPrimary
                                          : getColors(context).primary,
                                    ),
                              ),
                            ),
                          ),
                          hSpace(10),
                        ],
                      ),
                    );
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  OverlayEntry getMenuOverlay() {
    return OverlayEntry(
      builder: (context) => Positioned(
        height: maxHeight(context),
        width: maxWidth(context),
        child: Stack(
          children: [
            Listener(
              onPointerDown: (_) => menuOverlay!.remove(),
              child: Container(
                height: maxHeight(context),
                width: maxWidth(context),
                color: Colors.transparent,
              ),
            ),
            CompositedTransformFollower(
              link: _layerLink,
              offset: const Offset(-150, 25),
              child: Material(
                color: Colors.transparent,
                child: CustomCard(
                  height: 92,
                  width: 180,
                  border:
                      Border.all(color: getColors(context).onPrimaryContainer),
                  radius: 9,
                  child: Column(
                    children: [
                      Expanded(
                        child: InkWell(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(9),
                          ),
                          onTap: () {},
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              hSpace(15),
                              SvgPicture.asset(
                                "./assets/svg/list.svg",
                                width: 19,
                              ),
                              hSpace(10),
                              Text(
                                "Novo Pedido",
                                style: getStyles(context).labelMedium!.copyWith(
                                      color: getColors(context).primary,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            hSpace(15),
                            SvgPicture.asset(
                              "./assets/svg/save.svg",
                              width: 19,
                            ),
                            hSpace(10),
                            Text(
                              "Salvar",
                              style: getStyles(context).labelMedium!.copyWith(
                                    color: getColors(context).primary,
                                  ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget filterField(String title) => Padding(
        padding: const EdgeInsets.only(
          left: 30,
          right: 30,
          bottom: 15,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                maxLines: 2,
                style: getStyles(context).labelMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: getColors(context).primary,
                    ),
              ),
            ),
            const ContainerTextField(
              height: 44,
            ),
          ],
        ),
      );
}
