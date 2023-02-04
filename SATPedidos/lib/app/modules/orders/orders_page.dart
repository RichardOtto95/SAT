import 'package:comum/utilities/custom_scroll_behavior.dart';
import 'package:comum/utilities/utilities.dart';
import 'package:comum/widgets/confirm_popup.dart';
import 'package:comum/widgets/custom_card.dart';
import 'package:comum/widgets/custom_check.dart';
import 'package:comum/widgets/custom_drop_down.dart';
import 'package:comum/widgets/custom_floating_button.dart';
import 'package:comum/widgets/custom_navigation_tile.dart';
import 'package:comum/widgets/default_overlay_slider.dart';
import 'package:comum/widgets/default_text_field.dart';
import 'package:comum/widgets/default_title.dart';
import 'package:comum/widgets/observation.dart';
import 'package:comum/widgets/secondary_button.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:sat_orders/app/modules/orders/widgets/order_app_bar.dart';
import 'package:sat_orders/app/modules/orders/widgets/payments_totals.dart';
import 'package:sat_orders/app/modules/orders/widgets/test_data.dart';

import 'orders_store.dart';
import 'widgets/custom_dialog.dart';
import 'widgets/grid_base.dart';
import 'widgets/order_customer.dart';
import 'widgets/order_of_service.dart';
import 'widgets/orders_main.dart';

import 'dart:math' as math;

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage>
    with SingleTickerProviderStateMixin {
  final OrdersStore store = Modular.get();

  final _ordersMainKey = GlobalKey<OrdersMainState>();

  late OverlayEntry confirmOverlay;

  late AnimationController animationController;

  Future<void> animateTo(double value) => animationController.animateTo(
        value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );

  @override
  void initState() {
    animationController = AnimationController(vsync: this);
    // store.scrollController.addListener(() {
    //   if (store.scrollController.position.userScrollDirection ==
    //           ScrollDirection.reverse &&
    //       animationController.value == 0) {
    //     animateTo(1);
    //   } else if (store.scrollController.position.userScrollDirection ==
    //           ScrollDirection.forward &&
    //       animationController.value == 1) {
    //     animateTo(0);
    //   }
    // });

    // @override
    // void dispose() {
    //   animationController.dispose();
    //   super.dispose();
    // }

    confirmOverlay = OverlayEntry(
      builder: (context) => ConfirmPopup(
        height: 144,
        width: 300,
        text: "Salvar antes de sair?",
        onConfirm: () {
          confirmOverlay.remove();
        },
        onBack: () {
          confirmOverlay.remove();
        },
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (confirmOverlay.mounted) {
          confirmOverlay.remove();
          return false;
        }
        store.setShowCheckFloat(true);
        return true;
      },
      child: ScrollConfiguration(
        behavior: CustomScrollBehavior(),
        child: Listener(
          onPointerDown: (event) =>
              FocusScope.of(context).requestFocus(FocusNode()),
          // onPointerMove: (event) {
          //   if (event.localDelta.dy < 0 && animationController.value < 1) {
          //     animateTo(1);
          //   } else if (event.localDelta.dy > 0 &&
          //       animationController.value > 0) {
          //     animateTo(0);
          //   }
          // },
          child: NotificationListener<ScrollUpdateNotification>(
            onNotification: (notification) {
              if (notification.scrollDelta! > 0 &&
                  animationController.value == 0) {
                animateTo(1);
                if (store.page == 0) {
                  _ordersMainKey.currentState?.animateFloat(1);
                }
              } else if (notification.scrollDelta! < 0 &&
                  animationController.value == 1) {
                animateTo(0);
                if (store.page == 0) {
                  _ordersMainKey.currentState?.animateFloat(0);
                }
              }
              return true;
            },
            child: Scaffold(
              body: Stack(
                children: [
                  Column(
                    children: [
                      const OrderAppBar(),
                      Flexible(
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 75),
                              child: PageView(
                                controller: store.pageController,
                                onPageChanged: (value) => store.setPage(value),
                                children: [
                                  OrdersMain(
                                    key: _ordersMainKey,
                                    onSlide: (opening) =>
                                        opening ? animateTo(1) : animateTo(0),
                                  ),
                                  const OrderCustomer(),
                                  OrderOfService(),
                                  const Requisition(),
                                  const DeliveryAndAssembly(),
                                  const Informations(),
                                  const Observations(),
                                  const Conditions(),
                                  const Historic(),
                                  const Expenses(),
                                  const OtherOptions(),
                                  const Prints(),
                                  const Comissions(),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: PaymentsTotals(
                                onClick: (openning) {
                                  if (openning) {
                                    animateTo(0);
                                  } else {
                                    animateTo(1);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  AnimatedBuilder(
                    animation: animationController,
                    child: Column(
                      children: [
                        CustomFloatButton(
                          child: SvgPicture.asset(
                              "./assets/svg/insert_product.svg"),
                          onTap: () {
                            Modular.to.pushNamed("/products/");
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
                                title: "Lista de Produtos",
                                focus: FocusNode(),
                                data: suppliers,
                                gridColumns: sellerGridData,
                              ),
                            );
                            Overlay.of(context)?.insert(entry);
                          },
                          // onTap: () => Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const HoursCounter(),
                          //   ),
                          // ),
                        ),
                      ],
                    ),
                    builder: (context, child) {
                      return Positioned(
                        right: 20,
                        bottom: 185,
                        child: Visibility(
                          visible: animationController.value < 1,
                          child: Opacity(
                            opacity: 1 - animationController.value,
                            child: child!,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<GridColumnData> itemData = [
    GridColumnData("item", "Item", 81),
    GridColumnData("code", "Código", 60),
    GridColumnData("barcode", "Código de barras", 120),
    GridColumnData("size", "Tamanho", 105),
    GridColumnData("amount", "Quantidade", 105),
    GridColumnData("unity", "Unidade", 105),
    GridColumnData("description", "Descrição", 81),
    GridColumnData("price", "Preço", 60),
    GridColumnData("total_sell", "Total venda", 120),
    GridColumnData("discount", "Disconto", 105),
    GridColumnData("unity_value", "Valor unitário", 105),
    GridColumnData("total", "Total", 105),
    GridColumnData("cfop_nfe", "CFOP N-fe", 81),
    GridColumnData("seller", "Vendedor", 60),
    GridColumnData("detailed_description", "Descrição detalhada", 120),
    GridColumnData("fiscal description", "Valor", 105),
    GridColumnData("store_to_delivery", "Loja de entrega", 105),
    GridColumnData("send", "Enviar", 105),
  ];

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
}

class Requisition extends StatelessWidget {
  const Requisition({super.key});

  @override
  Widget build(BuildContext context) {
    return MyGrid(
      onSelect: (event) => getSlider(event, context),
    );
  }

  getSlider(PlutoGridOnSelectedEvent event, context) {
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => DefaultOverlaySlider(
        onBack: () => entry.remove(),
        height: 307,
        child: Column(
          children: [
            const DefaultTitle(
              title: "001",
              top: 15,
              bottom: 15,
            ),
            SecondaryButton(
              label: "Editar",
              icon: "show_customer_register",
              onTap: () {},
              width: 332,
              bottom: 15,
            ),
            SecondaryButton(
              label: "Editar",
              icon: "delete",
              iconWidth: 17,
              onTap: () {},
              width: 332,
              bottom: 15,
            ),
            SecondaryButton(
              label: "Entregar",
              icon: "order",
              onTap: () {},
              width: 332,
              bottom: 40,
            ),
          ],
        ),
      ),
    );
    Overlay.of(context)!.insert(entry);
  }
}

class DeliveryAndAssembly extends StatelessWidget {
  const DeliveryAndAssembly({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DefaultTitle(
            title: "Serviço ou Entrega",
            top: 15,
          ),
          const DefaultTextField(label: "Nome"),
          const DefaultTextField(label: "Data"),
          const DefaultTextField(label: "Motivo"),
          CustomDropDown(
            items: const [
              "Período",
            ],
            onChanged: (item) {},
            width: 130,
          ),
          SecondaryButton(
            label: "Consultar Relatório de Entrega",
            icon: "search_blue",
            onTap: () {},
          ),
          SecondaryButton(
            label: "Consultar Notas Fiscais",
            icon: "search_blue",
            onTap: () {},
          ),
          const DefaultTitle(
            title: "Montagem",
          ),
          const DefaultTextField(label: "Montador"),
          Row(
            children: [
              DefaultTextField(
                label: "Data",
                width: (maxWidth(context) - 45) / 2,
              ),
              Container(
                width: 25,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 10),
                child: Text(
                  "a",
                  style: getStyles(context).titleSmall,
                ),
              ),
              DefaultTextField(
                label: "",
                width: (maxWidth(context) - 45) / 2,
              ),
            ],
          ),
          const DefaultTextField(label: "Motivo"),
          DefaultTextField(
            label: "valor",
            width: (maxWidth(context) - 45) / 2,
          ),
          SecondaryButton(
            label: "Consultar Relatório de Montagem",
            icon: "search_blue",
            onTap: () {},
            bottom: 50,
          ),
        ],
      ),
    );
  }
}

class Informations extends StatefulWidget {
  const Informations({super.key});

  @override
  State<Informations> createState() => _InformationsState();
}

class _InformationsState extends State<Informations>
    with SingleTickerProviderStateMixin {
  final OrdersStore store = Modular.get();

  final _tileKey = GlobalKey<CustomNavigationTileState>();

  late final AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(vsync: this, value: 0);
    super.initState();
  }

  Future<void> animateTo(double value) async => controller.animateTo(value,
      duration: const Duration(milliseconds: 450), curve: Curves.decelerate);

  String? xmlDocument;

  @override
  Widget build(BuildContext context) {
    // print("height: ${maxHeight(context)}");
    return Column(
      children: [
        vSpace(15),
        CustomNavigationTile(
          key: _tileKey,
          tiles: const [
            "Pricipal",
            "Fiscal",
            "XML",
          ],
          horizontalPadding: 3,
          width: maxWidth(context) - 44,
          onPageChange: (page) => store.setInfoPage(page),
          page: store.infoPage,
        ),
        vSpace(10),
        Expanded(
          child: PageView(
            controller: store.infoPageController,
            onPageChanged: (value) {
              store.setInfoPage(value);
              _tileKey.currentState?.changePosition(value);
            },
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    const DefaultTitle(title: "Serviço ou Enrega"),
                    Row(
                      children: [
                        hSpace(10),
                        DefaultTextField(
                          label: "Usuário",
                          width: splitWidth(context, 2),
                          isBlue: true,
                        ),
                        hSpace(10),
                        DefaultTextField(
                          label: "Solicitada",
                          width: splitWidth(context, 2),
                          isBlue: true,
                        ),
                        hSpace(10),
                      ],
                    ),
                    const DefaultTextField(label: "Motivo"),
                    SecondaryButton(
                      label: "Autorizar Pedido",
                      onTap: () {},
                      icon: "check",
                    ),
                    SecondaryButton(
                      label: "Solicitar Autorização do Pedido",
                      onTap: () {},
                      icon: "order_status",
                    ),
                    SecondaryButton(
                      label: "Envio do Pedido",
                      onTap: () {},
                      icon: "order_status",
                    ),
                    Row(
                      children: [
                        hSpace(10),
                        DefaultTextField(
                          label: "Nº do Pedido",
                          width: splitWidth(context, 2),
                          isBlue: true,
                        ),
                        hSpace(10),
                        DefaultTextField(
                          label: "Terminal",
                          width: splitWidth(context, 2),
                          isBlue: true,
                        ),
                        hSpace(10),
                      ],
                    ),
                    Row(
                      children: [
                        hSpace(10),
                        DefaultTextField(
                          label: "Usuário",
                          width: splitWidth(context, 2),
                          isBlue: true,
                        ),
                        hSpace(10),
                        DefaultTextField(
                          label: "Hora do Pedido",
                          width: splitWidth(context, 2),
                          isBlue: true,
                        ),
                        hSpace(10),
                      ],
                    ),
                    Row(
                      children: [
                        hSpace(10),
                        DefaultTextField(
                          label: "Caixa",
                          width: splitWidth(context, 2),
                          isBlue: true,
                        ),
                        hSpace(10),
                        DefaultTextField(
                          label: "Data do Vínculo",
                          width: splitWidth(context, 2),
                          isBlue: true,
                        ),
                        hSpace(10),
                      ],
                    ),
                    Row(
                      children: [
                        hSpace(10),
                        DefaultTextField(
                          label: "Data e hora do envio",
                          width: splitWidth(context, 2),
                          isBlue: true,
                        ),
                        hSpace(10),
                        DefaultTextField(
                          label: "Número do Vínculo",
                          width: splitWidth(context, 2),
                          isBlue: true,
                        ),
                        hSpace(10),
                      ],
                    ),
                    const DefaultTextField(label: "Comissão do vendedor"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        hSpace(10),
                        DefaultTextField(
                          label: "Compilação",
                          width: splitWidth(context, 2),
                          isBlue: true,
                        ),
                      ],
                    ),
                    SecondaryButton(
                      label: "Exibir Localização no Navegador",
                      onTap: () {},
                      icon: "search_show",
                    ),
                    Row(
                      children: [
                        hSpace(10),
                        DefaultTextField(
                          label: "Latitude",
                          width: splitWidth(context, 2),
                          isBlue: true,
                        ),
                        hSpace(10),
                        DefaultTextField(
                          label: "Longitude",
                          width: splitWidth(context, 2),
                          isBlue: true,
                        ),
                        hSpace(10),
                      ],
                    ),
                    Row(
                      children: [
                        hSpace(10),
                        DefaultTextField(
                          label: "Impressões de OE",
                          width: splitWidth(context, 2),
                          isBlue: true,
                        ),
                        hSpace(10),
                        DefaultTextField(
                          label: "XPed",
                          width: splitWidth(context, 2),
                          isBlue: true,
                        ),
                        hSpace(10),
                      ],
                    ),
                    const DefaultTextField(
                      label: "Código de rastreio de Entrega",
                      isBlue: true,
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 32),
                    child: MyGrid(),
                  ),
                  Positioned(
                    bottom: 0,
                    child: AnimatedBuilder(
                      animation: controller,
                      child: SizeTransition(
                        sizeFactor: controller,
                        axisAlignment: -1,
                        child: Container(
                          color: getColors(context).surface,
                          height: maxHeight(context) < 760
                              ? maxHeight(context) - 020
                              : 460,
                          constraints: const BoxConstraints(
                            maxHeight: 460,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    hSpace(10),
                                    DefaultTextField(
                                      label: "NFC-e nº",
                                      width: splitWidth(context, 2),
                                    ),
                                    hSpace(10),
                                    DefaultTextField(
                                      label: "NFC-e Chave",
                                      width: splitWidth(context, 2),
                                    ),
                                    hSpace(10),
                                  ],
                                ),
                                Row(
                                  children: [
                                    hSpace(10),
                                    DefaultTextField(
                                      label: "NF-e nº",
                                      width: splitWidth(context, 2),
                                    ),
                                    hSpace(10),
                                    DefaultTextField(
                                      label: "NF-e Chave",
                                      width: splitWidth(context, 2),
                                    ),
                                    hSpace(10),
                                  ],
                                ),
                                const DefaultTextField(label: "Cupom Fiscal"),
                                SecondaryButton(
                                  label: "Consultar Notas Fiscais",
                                  icon: "search_blue",
                                  onTap: () {},
                                ),
                                SecondaryButton(
                                  label: "Alterar CFOP dos Ítens",
                                  icon: "change",
                                  onTap: () {},
                                ),
                                SecondaryButton(
                                  label: "Emitir NF-e de Devolução",
                                  icon: "nf_e",
                                  onTap: () {},
                                ),
                                Row(
                                  children: [
                                    hSpace(10),
                                    SecondaryButton(
                                      label: "Reimprimir",
                                      icon: "reprint",
                                      width: splitWidth(context, 2),
                                      onTap: () {},
                                    ),
                                    hSpace(10),
                                    SecondaryButton(
                                      label: "Número do Vínculo",
                                      icon: "discount_nf_e",
                                      width: splitWidth(context, 2),
                                      onTap: () {},
                                    ),
                                    hSpace(10),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      builder: (context, child) {
                        double value = controller.value;
                        return Column(
                          children: [
                            InkWell(
                              onTap: () =>
                                  animateTo(controller.value == 0 ? 1 : 0),
                              child: Container(
                                height: 32,
                                width: maxWidth(context),
                                decoration: BoxDecoration(
                                  color: getColors(context)
                                      .surface
                                      .withOpacity(value),
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(15 * value)),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 6,
                                      offset: const Offset(0, -3),
                                      color: getColors(context)
                                          .shadow
                                          .withOpacity(.3 * value),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: Transform.rotate(
                                  angle: math.pi * value,
                                  child: SvgPicture.asset(
                                    "./assets/svg/arrow_up.svg",
                                    width: 30,
                                    // height: 7,
                                  ),
                                ),
                              ),
                            ),
                            child!,
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                child: const Text(
                  """<?xml version="1.0" encoding="UTF-8"?>
<svg version="1.1" viewBox="49.74 90.48 94.98 46.88" xmlns="http://www.w3.org/2000/svg">
 <g transform="translate(-2.0038 -2.0038)">
  <g transform="matrix(.26458 0 0 .26458 37.951 73.915)">
   <g fill="#fff" fill-rule="evenodd">
    <path d="m210.5 110.02c4.824-4.8291 10.599-7.2451 17.324-7.2451 2.1441 0 3.217 1.3558 3.217 4.0669 0 2.711-1.0729 4.066-3.217 4.066-4.483 0-8.333 1.6081-11.549 4.822-3.2159 3.2162-4.824 7.064-4.824 11.546 0 4.5799 1.6081 8.475 4.824 11.692 3.2159 3.2159 7.0659 4.822 11.549 4.822 6.8221 0 12.619 2.3899 17.396 7.1679 4.775 4.7801 7.164 10.581 7.164 17.407 0 6.7281-2.389 12.504-7.1632 17.334-4.7758 4.824-10.575 7.2391-17.396 7.2391-2.0469 0-3.0699-1.3561-3.0699-4.066 0-2.7119 1.023-4.066 3.0699-4.066 4.5799 0 8.4529-1.607 11.62-4.8169 3.168-3.2142 4.752-7.0592 4.752-11.536 0-4.576-1.584-8.445-4.752-11.607-3.1672-3.1629-7.0402-4.7449-11.62-4.7449-6.726 0-12.501-2.4152-17.325-7.246-4.8228-4.8299-7.2348-10.66-7.2348-17.491 0-6.732 2.412-12.513 7.2348-17.344z"/>
    <path d="m269.78 111.98c6.139-6.1379 13.546-9.2081 22.222-9.2081 8.674 0 16.078 3.0702 22.22 9.2081 6.139 6.1401 9.2089 13.545 9.2089 22.217v28.355c0 2.0461-1.3581 3.068-4.0719 3.068-2.7151 0-4.072-1.0231-4.072-3.0711v-28.383c0-6.4358-2.2672-11.923-6.8-16.459-4.5332-4.5352-10.016-6.8032-16.449-6.8032-6.4318 0-11.915 2.266-16.448 6.7989-4.5351 4.534-6.7991 10.015-6.7991 16.448 0 6.4352 2.262 11.917 6.7909 16.452 4.5281 4.5311 10.005 6.7972 16.432 6.7972 2.7269 0 4.0909 1.3708 4.0909 4.1099 0 2.7408-1.366 4.11-4.0949 4.11-8.676 0-16.087-3.068-22.227-9.2061-6.1421-6.1399-9.2132-13.546-9.2132-22.217 0-8.6721 3.0682-16.077 9.2101-22.217z"/>
    <path d="m346.38 134.19c0 6.423 2.2658 11.899 6.7978 16.422 4.532 4.5272 9.9652 6.7881 16.301 6.7881 6.431 0 11.937-2.2799 16.52-6.8411 0.779-0.7759 1.7518-1.1648 2.9208-1.1648 2.7312 0 4.0961 1.3637 4.0961 4.0929 0 1.1699-0.4411 2.1459-1.317 2.924-6.1401 6.1421-13.547 9.2089-22.22 9.2089-8.674 0-16.057-3.0699-22.147-9.216-6.0931-6.143-9.1369-13.556-9.1369-22.238v-23.261h-3.5082c-2.0469 0-3.071-1.3581-3.071-4.0731s1.0241-4.072 3.071-4.072h3.5082v-24.09c0-2.1399 1.364-3.2131 4.0938-3.2131 2.728 0 4.0912 1.0732 4.0912 3.2131v24.09h36.109c2.0469 0 3.071 1.357 3.071 4.072s-1.0241 4.0731-3.071 4.0731h-36.109l-0.026 23.285z"/>
   </g>
   <path d="m123.83 83.052a59.209 59.408 0 0 1 59.209 59.408 59.209 59.408 0 1 1-59.209-59.408z" fill="#046da7" fill-rule="evenodd" stroke="#000" stroke-width=".5669"/>
   <g fill="#fff" fill-rule="evenodd">
    <path d="m63.745 234.73h-0.0366c-0.011 0-0.0288-6e-3 -0.0527-0.0189-1.0053-0.011-1.8982-0.3528-2.6786-1.027-0.7336-0.6513-1.1304-1.5033-1.189-2.5562-0.0121-0.0228-0.0189-0.0716-0.0189-0.1412v-7.4877h-2.0751c-0.4264 0-0.6392-0.2068-0.6392-0.6203 0-0.4287 0.2128-0.6395 0.6392-0.6395h2.0751v-2.3234c0-0.4275 0.2148-0.6403 0.6403-0.6403h0.6215c0.4134 0 0.6203 0.2128 0.6203 0.6403v2.3234h3.2988c0.4146 0 0.6223 0.2108 0.6223 0.6395 0 0.4135-0.2077 0.6203-0.6223 0.6203h-3.2988v7.4519h0.0177v0.0169c0 0.71 0.2418 1.2976 0.7269 1.7587 0.52 0.4475 1.1174 0.691 1.7916 0.7268h2.076c0.4267 0 0.6394 0.2108 0.6394 0.6375 0 0.4264-0.2127 0.6392-0.6394 0.6392z"/>
    <path d="m72.882 223.3h-0.0527c-0.8759 0.0347-1.6267 0.3717-2.2541 1.0121-0.6025 0.6036-0.9157 1.3601-0.9396 2.2698v2.0929h3.4073c0.721-0.01 1.3424-0.2773 1.8624-0.7973 0.5208-0.5219 0.7804-1.1473 0.7804-1.8801 0-0.7229-0.2486-1.3432-0.7446-1.8632-0.5211-0.5231-1.1245-0.7995-1.8108-0.8342h-0.1589zm-1.2251 11.416c-0.0347-4e-3 -0.0815-0.0138-0.1412-0.0268-1.0298-0.0578-1.9108-0.4605-2.6425-1.2051-0.711-0.7099-1.0768-1.5969-1.1008-2.6616v-4.471c0.0707-1.1831 0.538-2.1884 1.4018-3.0167 0.874-0.8391 1.9052-1.2776 3.0864-1.3123h1.3311l0.018 0.0178v-0.0178c1.0887 0 2.0174 0.3898 2.7859 1.1713 0.7804 0.7686 1.1702 1.7032 1.1702 2.8037 0 1.0639-0.3828 1.9985-1.1524 2.8028-0.7694 0.7694-1.6913 1.1522-2.7679 1.1522h-4.0099v0.8173c0.0239 0.7437 0.2894 1.3722 0.7984 1.8801 0.5558 0.5199 1.1882 0.7795 1.8982 0.7795 0.0228 0 0.0507 4e-3 0.0794 0.011 0.0308 6e-3 0.0685 0.013 0.1164 0.0259h3.1408c0.4114 0 0.6203 0.2086 0.6203 0.6212 0 0.4256-0.2089 0.6383-0.6203 0.6383h-3.9403c-0.0119 0-0.0358-4e-3 -0.0716-0.01z"/>
    <path d="m80.672 230.98c0.0231 0.7091 0.2765 1.3243 0.7618 1.8443 0.4741 0.5082 1.0766 0.7807 1.8105 0.8165h0.8869c0.6978-0.0358 1.3063-0.3143 1.8263-0.8334 0.5101-0.5098 0.7635-1.1304 0.7635-1.8632 0.0129-0.4036 0.2257-0.6054 0.6403-0.6054h0.6017c0.4146 0 0.6274 0.2018 0.6381 0.6054v0.0538c-0.0107 1.064-0.4075 1.9875-1.1879 2.7679-0.7449 0.7446-1.6555 1.1285-2.7324 1.1544h-1.9517c-1.0647-0.0259-1.9745-0.3988-2.7321-1.1186-0.7567-0.7237-1.1524-1.6157-1.189-2.6805v-4.6302c0.0118-1.2068 0.4504-2.242 1.3122-3.1058 0.8531-0.8511 1.8942-1.3066 3.1241-1.3663h1.5619c0.011 0.0121 0.0347 0.0189 0.0705 0.0189h0.1423c0.024 0 0.0406 4e-3 0.0527 0.016h0.0885c0.0118 0 0.0197 4e-3 0.0268 9e-3 0.0059 5e-3 0.0149 9e-3 0.0267 9e-3h0.0528c0.0248 0 0.0417 7e-3 0.0538 0.018h0.0358c0.0228 0 0.0397 6e-3 0.0527 0.0189h0.0535c0.011 0.011 0.0229 0.0178 0.0358 0.0178h0.0519c0 0.011 0.0177 0.016 0.0546 0.016l0.0358 0.0189c0.011 0 0.0198 2e-3 0.0248 8e-3 6e-3 6e-3 0.015 9e-3 0.0268 9e-3h0.0538c0.0237 0 0.0426 7e-3 0.0536 0.0189 0.011 0.0118 0.0228 0.0189 0.0349 0.0189 0.0119 0.01 0.0296 0.0169 0.0547 0.0169 0.0107 0.011 0.0217 0.0169 0.0338 0.0169 0.0248 0 0.0417 7e-3 0.0536 0.0178h0.0358c0.0239 0.025 0.0408 0.0349 0.0527 0.0349h0.0358c0.0239 0.0248 0.0408 0.0366 0.0538 0.0366 0.0107 0 0.0237 4e-3 0.0358 0.0161 0.0107 0 0.0197 4e-3 0.0268 9e-3 0.0048 7e-3 0.0129 9e-3 0.0259 9e-3h0.0347c0 0.0239 0.018 0.0369 0.0527 0.0369l0.0188 0.0169h0.0189c0.0229 0.013 0.0398 0.0169 0.0516 0.0169 0.013 0 0.024 7e-3 0.0358 0.0189 0 0.0248 0.0169 0.0358 0.0527 0.0358 0.0121 0 0.0251 6e-3 0.0358 0.0177l0.0349 0.0181c0.013 0.011 0.0248 0.0158 0.0358 0.0158 0 0.027 0.0189 0.0377 0.0536 0.0377 0.011 0 0.0239 6e-3 0.0358 0.0161 0 0.0248 0.0169 0.0358 0.0538 0.0358l0.0158 0.0177c0.0251 0.024 0.042 0.037 0.0538 0.037 0.013 0.0109 0.024 0.0169 0.0367 0.0169 0-0.011 0.018 0 0.0538 0.0346l0.0169 0.0181c0.0118 0 0.0197 7e-3 0.0268 0.0188 0.0059 0.0119 0.0141 0.0178 0.0267 0.0178v0.0169h0.017c0.0121 0.013 0.0298 0.0228 0.0527 0.035l0.018 0.0197 0.0535 0.0518h0.0181c0.0358 0.0367 0.0586 0.0547 0.0704 0.0547v0.0169c0.013 0.011 0.024 0.0209 0.035 0.0268 0.0118 5e-3 0.0248 0.0138 0.0366 0.0248v0.0189h0.0169l0.0358 0.0358 0.0189 0.0169 0.0519 0.0538 0.0188 0.0178 0.0527 0.0527h0.0178c0.024 0.0239 0.0409 0.0476 0.0527 0.0707 0.013 0.0248 0.0299 0.0477 0.0527 0.0716h0.0189c0.011 0.0228 0.029 0.0476 0.0538 0.0724l0.0169 0.0169c0.0107 0.0119 0.0237 0.0288 0.0358 0.0527 0.0107 0.0139 0.0209 0.0229 0.0268 0.035 0.0051 0.0127 0.0149 0.0248 0.0259 0.0358h0.0178c0.0118 0.0107 0.0208 0.0237 0.0268 0.0366 0.0062 0.013 0.0149 0.0229 0.0279 0.0338v0.0189c0 0.013 0.0169 0.0338 0.0527 0.0708 0 0.0107 0.0169 0.0358 0.0518 0.0716v0.0177l0.0527 0.0527v0.0169c0 0.013 0.0189 0.0378 0.0536 0.0725 0 0.0349 0.0129 0.0656 0.0369 0.0876 0.0228 0.0936 0.0366 0.1251 0.0366 0.0885h0.0169c0 0.024 0.011 0.0457 0.0339 0.0724 0.0118 0.0231 0.0248 0.0519 0.0357 0.0877 0.013 0.0366 0.0308 0.0645 0.0539 0.0885 0 0.0366 0.0118 0.0645 0.0358 0.0885-0.013-0.024-0.015-0.031-9e-3 -0.0181 0.0047 0.0122 0.0188 0.0479 0.0448 0.1066 0.0107 0.0138 0.0157 0.0307 0.0157 0.0546 0 0.0119 0.0071 0.0229 0.0189 0.0339 0.011 0.0715 0.026 0.1381 0.0448 0.1939 0.0169 0.0606 0.0327 0.1203 0.0437 0.1798 0.0229 0.0814 0.0417 0.153 0.0536 0.2128 0.0121 0.0597 0.0231 0.1172 0.0358 0.1769 0.011 0.024 0.0169 0.0775 0.0169 0.1601v0.1066c0 0.0476 0.0062 0.0884 0.0169 0.1231v0.1779c-0.0228 0.3909-0.2356 0.5856-0.6381 0.5856h-0.6017c-0.4146 0-0.6274-0.1947-0.6403-0.5856v-0.017c0-0.7217-0.2486-1.342-0.7446-1.8631-0.52-0.522-1.1245-0.7982-1.8105-0.834h-0.3013c-0.8869 0.0457-1.6386 0.3906-2.2529 1.029-0.6034 0.6025-0.9166 1.3562-0.9397 2.2529v3.9223z"/>
    <path d="m99.639 225.73v8.3554c0 0.4267-0.2136 0.6395-0.6391 0.6395h-0.6035c-0.4255 0-0.6383-0.2128-0.6383-0.6395v-8.0891c0-0.7226-0.2497-1.3432-0.7457-1.8632-0.5211-0.5228-1.1234-0.7993-1.8097-0.8342h-0.301c-0.8869 0.0459-1.6385 0.3897-2.2541 1.0281-0.6025 0.6026-0.9168 1.3562-0.9396 2.253v7.5054c0 0.4267-0.2066 0.6395-0.6214 0.6395h-0.6212c-0.4137 0-0.6206-0.2128-0.6206-0.6395v-11.212c0-0.4287 0.2069-0.6395 0.6206-0.6395h0.6212c0.4148 0 0.6214 0.2108 0.6214 0.6395v0.0527c0.7576-0.5699 1.6138-0.87 2.5723-0.905h1.5619c0.0228 0.011 0.0406 0.0181 0.0536 0.0181h0.1403c0.0366 0 0.0606 4e-3 0.0716 0.0169h0.0893c0.011 0 0.024 7e-3 0.0339 0.0169h0.1085c0.011 0.0118 0.0287 0.0177 0.0527 0.0177h0.0358c0.0118 0.0141 0.0287 0.0189 0.0535 0.0189l0.0169 0.0181h0.0716c0.0118 0 0.0209 2e-3 0.0248 8e-3 0.0062 6e-3 0.0169 9e-3 0.0279 9e-3 0.0228 0.0118 0.0409 0.0177 0.0538 0.0177h0.0358c0.0099 0.0121 0.0288 0.0181 0.0516 0.0181 0.0248 0 0.0358 7e-3 0.0358 0.0177 0.0228 0 0.0417 6e-3 0.0538 0.0189h0.0358c0.0107 0.011 0.0296 0.0169 0.0527 0.0169l0.0189 0.0169h0.0169c0.0228 0 0.0417 7e-3 0.0527 0.0189 0.0237 0 0.0426 4e-3 0.0536 0.0169 0.011 0.0119 0.0228 0.0181 0.0358 0.0181 0.0109 0.0118 0.0287 0.0177 0.0538 0.0177 0.0107 0.011 0.0228 0.018 0.0335 0.018l0.0358 0.0158c0.0121 0 0.024 7e-3 0.0358 0.0181 0.0121 0 0.022 4e-3 0.0271 0.01 0.0059 7e-3 0.0149 0.011 0.0267 0.011 0.011 0.01 0.0229 0.0158 0.0358 0.0158 0.011 0.013 0.0288 0.018 0.0527 0.018 0 0.0119 0.0119 0.0158 0.0358 0.0158l0.0178 0.0189c0.011 0 0.0231 7e-3 0.0338 0.0189 0.013 0.0118 0.0251 0.0169 0.0369 0.0169 0.024 0.013 0.0409 0.0189 0.0536 0.0189l0.016 0.0169c0 0.0239 0.0189 0.0349 0.0547 0.0349v0.0189h0.0169l0.0189 0.0158c0.011 0 0.0228 7e-3 0.0347 0.02 0.1175 0.0586 0.2187 0.1223 0.3024 0.1939 0.0236 0.0237 0.0476 0.0417 0.0704 0.0547 0.024 0.0107 0.0479 0.0287 0.0716 0.0527v0.0166h0.0169c0 0.0251 0.0181 0.0369 0.0539 0.0369l0.0177 0.017 0.0527 0.0515v0.0189h0.018c0 0.024 0.011 0.0358 0.0347 0.0358l0.018 0.0169 0.0547 0.0547h0.0169c0 0.0349 0.0169 0.0527 0.0527 0.0527l0.0189 0.0169c0 0.0141 0.0119 0.031 0.0358 0.0547l0.0169 0.016 0.0527 0.0547v0.0178h0.0178c0 0.0349 0.0118 0.0527 0.0358 0.0527l0.0169 0.0189c0.0118 0.0109 0.018 0.0231 0.018 0.0349l0.0189 0.0169h0.0169c0.0127 0.011 0.0209 0.0248 0.0268 0.0378 7e-3 0.01 0.0149 0.022 0.0259 0.0338v0.0169c0.0119 0 0.0307 0.0178 0.0536 0.0547v0.0169c0.0239 0.0347 0.0467 0.0744 0.0715 0.1153 0.0229 0.0428 0.0528 0.0746 0.0897 0.0983 0.2593 0.4267 0.4362 0.881 0.5318 1.3652v0.0178c0.0099 0.0141 0.0158 0.0358 0.0158 0.0696 0 0.0609 7e-3 0.0955 0.0189 0.1074v0.0896c0.0109 0.01 0.018 0.0487 0.018 0.1054v0.0905z"/>
    <path d="m106.08 223.3h-0.142c-0.8861 0.0597-1.6437 0.4027-2.2699 1.0281-0.6155 0.6153-0.9227 1.379-0.9227 2.2888v4.3298h0.018v0.0169c0 0.7099 0.2415 1.3254 0.7266 1.8462 0.5199 0.52 1.1236 0.7973 1.8105 0.8331h0.3539c0.863-0.0465 1.5969-0.3835 2.2003-1.01 0.6037-0.6046 0.9176-1.3669 0.9396-2.2908v-4.3447c0-0.7229-0.2474-1.3432-0.7446-1.8632-0.52-0.5231-1.1245-0.7995-1.8096-0.8342zm4.5964 2.4308v4.6113c-0.024 1.2669-0.4602 2.3257-1.3133 3.1777-0.8402 0.8739-1.8691 1.3423-3.0861 1.4029h-1.4557c-1.0529 0-1.9635-0.368-2.7332-1.1016-0.7564-0.7218-1.1532-1.6206-1.187-2.6975-0.013-0.0228-0.0189-0.0715-0.0189-0.14v-4.3667c0-1.2539 0.4315-2.3116 1.2956-3.1749 0.8519-0.8886 1.8978-1.3609 3.1387-1.4196h1.5619c0.024 0.0119 0.0417 0.0178 0.0527 0.0178h0.1432c0.0358 0 0.0586 4e-3 0.0705 0.0169h0.0896c0.011 0 0.0239 7e-3 0.0358 0.0181h0.1062c0.011 0.0109 0.0291 0.0169 0.0527 0.0169h0.0358c0.0121 0.0138 0.0291 0.0197 0.0527 0.0197l0.0181 0.0169h0.0704c0.013 0 0.022 2e-3 0.0271 8e-3 5e-3 6e-3 0.0138 9e-3 0.0276 9e-3 0.0228 0.013 0.0409 0.018 0.0527 0.018h0.0349c0.013 0.0119 0.0299 0.0178 0.0528 0.0178 0.0236 0 0.0357 7e-3 0.0357 0.0189 0.0248 0 0.0418 5e-3 0.0536 0.018h0.0358c0.011 0.011 0.029 0.0178 0.0527 0.0178l0.018 0.016h0.0178c0.0239 0 0.0417 7e-3 0.0538 0.0189 0.0228 0 0.0406 5e-3 0.0527 0.0169 0.011 0.0119 0.0228 0.0178 0.0347 0.0178 0.0129 0.013 0.0299 0.0189 0.0538 0.0189 0.0118 0.0101 0.0237 0.0169 0.0358 0.0169l0.0347 0.0169c0.0129 0 0.0248 7e-3 0.0358 0.0169 0.0118 0 0.0208 4e-3 0.0259 0.01 7e-3 7e-3 0.0158 0.011 0.0279 0.011 0.0107 0.0109 0.0228 0.016 0.0358 0.016 0.0107 0.013 0.0287 0.0178 0.0527 0.0178 0 0.0129 0.0118 0.0169 0.0346 0.0169l0.017 0.018c0.0129 0 0.0248 7e-3 0.0369 0.0198 0.0118 0.0109 0.0237 0.016 0.0358 0.016 0.0236 0.013 0.0406 0.0189 0.0527 0.0189l0.0189 0.0169c0 0.0237 0.0169 0.0358 0.0527 0.0358v0.0178h0.0177l0.0181 0.0169c0.0107 0 0.0228 7e-3 0.0346 0.0189 0.1184 0.0586 0.2179 0.1223 0.3013 0.195 0.0248 0.0228 0.0476 0.0417 0.0716 0.0535 0.0228 0.011 0.0476 0.0299 0.0704 0.0527v0.0181h0.0181c0 0.0236 0.0177 0.0366 0.0527 0.0366l0.0189 0.0161 0.0527 0.0515v0.0201h0.0169c0 0.0228 0.0129 0.0357 0.0366 0.0357l0.018 0.0158 0.0527 0.0547h0.0178c0 0.035 0.0169 0.0538 0.0527 0.0538l0.018 0.0158c0 0.0138 0.013 0.0319 0.0358 0.0547l0.0169 0.0169 0.0547 0.0536v0.018h0.0169c0 0.0347 0.0119 0.0535 0.0358 0.0535l0.0178 0.0181c0.0121 0.011 0.0169 0.0239 0.0169 0.0346l0.018 0.0169h0.0189c0.011 0.0122 0.0197 0.0251 0.0259 0.0378 6e-3 0.011 0.0147 0.022 0.0257 0.0338v0.0181c0.0121 0 0.031 0.0169 0.0538 0.0535v0.0169c0.0237 0.035 0.0476 0.0747 0.0716 0.1156 0.0228 0.0425 0.0535 0.0744 0.0893 0.0983 0.2596 0.4276 0.4374 0.8819 0.5321 1.3652v0.0178c0.0108 0.0138 0.0178 0.0369 0.0178 0.0704 0 0.0598 5e-3 0.0947 0.0169 0.1066v0.0893c0.011 0.011 0.018 0.0488 0.018 0.1054v0.0905z"/>
    <path d="m115.57 217.99c0.4149 0 0.6215 0.2119 0.6215 0.6395v15.453c0 0.4255-0.2066 0.6383-0.6215 0.6383h-0.6211c-0.4248 0-0.6384-0.2128-0.6384-0.6383v-14.798h-2.0582c-0.4275 0-0.6383-0.2127-0.6383-0.6383 0-0.4383 0.2108-0.6561 0.6383-0.6561h3.2988z"/>
    <path d="m123.36 223.3h-0.142c-0.8869 0.0597-1.6436 0.4027-2.271 1.0281-0.6144 0.6153-0.9216 1.379-0.9216 2.2888v4.3298h0.0169v0.0169c0 0.7099 0.2416 1.3254 0.7288 1.8462 0.5189 0.52 1.1226 0.7973 1.8086 0.8331h0.3559c0.863-0.0465 1.5957-0.3835 2.1991-1.01 0.6037-0.6046 0.9168-1.3669 0.9408-2.2908v-4.3447c0-0.7229-0.2486-1.3432-0.7457-1.8632-0.52-0.5231-1.1226-0.7995-1.8085-0.8342zm4.5956 2.4308v4.6113c-0.0228 1.2669-0.4614 2.3257-1.3125 3.1777-0.839 0.8739-1.8691 1.3423-3.0872 1.4029h-1.4545c-1.0538 0-1.9635-0.368-2.7332-1.1016-0.7565-0.7218-1.1533-1.6206-1.1891-2.6975-0.0118-0.0228-0.0169-0.0715-0.0169-0.14v-4.3667c0-1.2539 0.4315-2.3116 1.2945-3.1749 0.8522-0.8886 1.899-1.3609 3.1399-1.4196h1.5619c0.0239 0.0119 0.0417 0.0178 0.0547 0.0178h0.1412c0.0349 0 0.0597 4e-3 0.0715 0.0169h0.0885c0.0119 0 0.0229 7e-3 0.035 0.0181h0.1074c0.0107 0.0109 0.0287 0.0169 0.0527 0.0169h0.0346c0.0119 0.0138 0.0307 0.0197 0.0536 0.0197l0.018 0.0169h0.0705c0.0121 0 0.0211 2e-3 0.027 8e-3 5e-3 6e-3 0.015 9e-3 0.0257 9e-3 0.0251 0.013 0.042 0.018 0.0538 0.018h0.0358c0.013 0.0119 0.0299 0.0178 0.0527 0.0178 0.0248 0 0.0358 7e-3 0.0358 0.0189 0.0248 0 0.0417 5e-3 0.0535 0.018h0.0358c0.0121 0.011 0.0291 0.0178 0.0527 0.0178l0.0181 0.016h0.0177c0.024 0 0.0409 7e-3 0.0539 0.0189 0.0228 0 0.0408 5e-3 0.0527 0.0169 0.0118 0.0119 0.0228 0.0178 0.0346 0.0178 0.013 0.013 0.0299 0.0189 0.0547 0.0189 0.0101 0.0101 0.0228 0.0169 0.0349 0.0169l0.0347 0.0169c0.013 0 0.024 7e-3 0.0369 0.0169 0.01 0 0.0198 4e-3 0.0248 0.01 7e-3 7e-3 0.0158 0.011 0.0279 0.011 0.011 0.0109 0.0229 0.016 0.0347 0.016 0.013 0.013 0.0299 0.0178 0.0538 0.0178 0 0.0129 0.0119 0.0169 0.0358 0.0169l0.0178 0.018c0.0121 0 0.0228 7e-3 0.0349 0.0198 0.0119 0.0109 0.0237 0.016 0.0347 0.016 0.0248 0.013 0.0428 0.0189 0.0538 0.0189l0.0189 0.0169c0 0.0237 0.0169 0.0358 0.0527 0.0358v0.0178h0.0178l0.018 0.0169c0.011 0 0.0228 7e-3 0.0347 0.0189 0.1195 0.0586 0.2198 0.1223 0.3012 0.195 0.0248 0.0228 0.0477 0.0417 0.0716 0.0535 0.024 0.011 0.0477 0.0299 0.0708 0.0527v0.0181h0.0188c0 0.0236 0.017 0.0366 0.0516 0.0366l0.0189 0.0161 0.0527 0.0515v0.0201h0.018c0 0.0228 0.0119 0.0357 0.0358 0.0357l0.0178 0.0158 0.0538 0.0547h0.0169c0 0.035 0.0167 0.0538 0.0525 0.0538l0.0191 0.0158c0 0.0138 0.0119 0.0319 0.0347 0.0547l0.0177 0.0169 0.0539 0.0536v0.018h0.0158c0 0.0347 0.0129 0.0535 0.0357 0.0535l0.0189 0.0181c0.013 0.011 0.0181 0.0239 0.0181 0.0346l0.0169 0.0169h0.0177c0.0121 0.0122 0.0212 0.0251 0.0271 0.0378 6e-3 0.011 0.0149 0.022 0.0268 0.0338v0.0181c0.0118 0 0.0298 0.0169 0.0527 0.0535v0.0169c0.0248 0.035 0.0476 0.0747 0.0704 0.1156 0.024 0.0425 0.0527 0.0744 0.0896 0.0983 0.2596 0.4276 0.4386 0.8819 0.5319 1.3652v0.0178c0.0121 0.0138 0.0169 0.0369 0.0169 0.0704 0 0.0598 7e-3 0.0947 0.0189 0.1066v0.0893c0.0121 0.011 0.0169 0.0488 0.0169 0.1054v0.0905z"/>
    <path d="m131.08 230.95v0.0169c0 0.7088 0.2415 1.3252 0.7266 1.8463 0.5211 0.5189 1.1236 0.7973 1.8096 0.8331h0.3548c0.8641-0.0468 1.598-0.3847 2.2003-1.0109 0.6045-0.6037 0.9159-1.3672 0.9408-2.2899v-4.3459c0-0.7217-0.2486-1.342-0.7458-1.8631-0.5211-0.522-1.1236-0.7985-1.8096-0.8331h-0.3021c-0.887 0.0586-1.6437 0.4027-2.271 1.0281-0.6144 0.6152-0.9225 1.3779-0.9225 2.2885v4.33zm0.0169 8.6926c-0.4267 0-0.6383-0.2128-0.6383-0.6373 0-0.4264 0.2116-0.6392 0.6383-0.6392h3.1407c0.0587-0.0129 0.1173-0.0231 0.177-0.0349 0.7328 0 1.361-0.2604 1.881-0.7804 0.52-0.5231 0.7916-1.1533 0.8165-1.899v-1.6157c-0.7686 0.5557-1.6087 0.852-2.5196 0.89h-1.4554c-1.0529 0-1.9627-0.3681-2.7324-1.1017-0.7564-0.7218-1.1532-1.6208-1.1879-2.6974-0.0121-0.0239-0.018-0.0727-0.018-0.1412v-4.3658c0-1.2536 0.4315-2.3125 1.2956-3.1754 0.8511-0.8881 1.897-1.3602 3.1407-1.4199h1.543c0.0121 0 0.0228 2e-3 0.0358 9e-3 0.011 6e-3 0.0228 0.01 0.0338 0.01h0.1432c0.024 0 0.0409 4e-3 0.0527 0.0169h0.1254c0.0107 0.011 0.0338 0.0169 0.0696 0.0169h0.0378c0.0228 0.0118 0.0397 0.018 0.0516 0.018h0.0358c0.0118 0 0.0208 5e-3 0.0259 0.01 6e-3 7e-3 0.0158 9e-3 0.0268 9e-3h0.0538c0.0228 0 0.0417 6e-3 0.0524 0.0178h0.0192c0.0228 0.0118 0.0397 0.02 0.0524 0.0267 0.0121 6e-3 0.029 8e-3 0.0538 8e-3 0.0457 0 0.0756 7e-3 0.0874 0.0178 0.0121 0.0129 0.0251 0.018 0.0358 0.018 0.024 0.0118 0.042 0.0189 0.0527 0.0189h0.0369l0.0178 0.0169h0.0169c0.011 0.0107 0.029 0.0169 0.0527 0.0169l0.018 0.0178h0.0178c0.0129 0.011 0.0299 0.018 0.0547 0.018 0.0109 0 0.0231 7e-3 0.0338 0.0178 0.0251 0 0.042 6e-3 0.0527 0.018 0.0141 0 0.0251 6e-3 0.0369 0.0177 0.0118 0 0.024 5e-3 0.0347 0.0158 0.0239 0 0.0417 7e-3 0.0538 0.0181 0.0118 0.0138 0.0237 0.02 0.0347 0.02 0.0239 0.0107 0.0417 0.0166 0.0546 0.0166 0.011 0 0.0229 7e-3 0.0358 0.018 0 0.0229 0.0169 0.0347 0.0519 0.0347h0.0177c0.024 0.0251 0.0539 0.042 0.0897 0.0538 0.01 0.011 0.0228 0.0178 0.0346 0.0178 0.013 0.011 0.024 0.0169 0.0358 0.0169 0 0.0259 0.0121 0.0369 0.0358 0.0369 0.0228 0 0.0417 7e-3 0.0527 0.0158 0.0121 0.0141 0.024 0.02 0.035 0.02 0 0.0209 0.0129 0.0338 0.0366 0.0338 0.0121 0.0138 0.0228 0.0198 0.0349 0.0198 0 0.0101 0.0119 0.0231 0.0347 0.0338 0.013 0 0.0209 4e-3 0.0279 0.0101 6e-3 5e-3 0.0138 8e-3 0.0268 8e-3 0.011 0.0119 0.0239 0.0169 0.0338 0.0169 0 0.0119 7e-3 0.0248 0.0189 0.0367l0.0358 0.0189c0 0.0101 0.0118 0.0231 0.0349 0.0338l0.0358 0.0369c0.0119 0 0.0229 6e-3 0.0358 0.0169l0.0358 0.0358c0.0107 0 0.0288 0.011 0.0527 0.0347l0.0178 0.0188c0.0228 0.024 0.0417 0.0339 0.0546 0.0339l0.0877 0.0896c0.0118 0.011 0.0228 0.0169 0.0358 0.0169 0 0.0237 0.0107 0.0378 0.0346 0.0378 0 0.0109 5e-3 0.0217 0.0181 0.0338l0.0347 0.0358c0.0118 0.0217 0.0228 0.0346 0.0357 0.0346l0.0358 0.037 0.0181 0.0157c0.0236 0.026 0.0358 0.0429 0.0358 0.0547 0.0107 0.013 0.0228 0.0169 0.0358 0.0169l0.0346 0.0358c0 0.0121 6e-3 0.024 0.0178 0.0369 0 0.0229 0.0121 0.0347 0.0349 0.0347 0.013 0.0121 0.0189 0.022 0.0189 0.0349l0.0347 0.0347c0 0.013 5e-3 0.0259 0.018 0.0358 0.011 0.024 0.0228 0.0358 0.0347 0.0358v0.0189h0.0189c0.0231 0.0479 0.0467 0.0865 0.0696 0.1144 0.0251 0.0299 0.042 0.0555 0.0538 0.0806h0.0169c0.013 0.0118 0.0178 0.0228 0.0178 0.0347l0.0188 0.018v0.0358c0.0122 0.0127 0.0181 0.0237 0.0181 0.0347l0.0169 0.0189 0.0189 0.016c0.011 0.0138 0.0169 0.0307 0.0169 0.0536 0.011 0.0118 0.0177 0.0248 0.0177 0.0358 0 0.0129 0.013 0.0298 0.0358 0.0538v0.0169h0.0181c0 0.0118 6e-3 0.0307 0.0158 0.0547l0.0188 0.0177c0 0.0119 6e-3 0.0268 0.0181 0.0527v0.0181l0.0169 0.0169c0 0.0366 0.013 0.0524 0.0358 0.0524v0.0369c0 0.01 0.0129 0.0299 0.0358 0.0516v0.018c0.011 0.026 0.0248 0.0547 0.0358 0.0885 0.011 0.0378 0.0287 0.0787 0.0527 0.1263v0.0177c0 0.0102 6e-3 0.0291 0.0189 0.0519 0.0118 0.011 0.0177 0.024 0.0177 0.0366v0.0527c0 0.011 5e-3 0.022 0.0169 0.0358 0 0.0339 6e-3 0.0527 0.0169 0.0527v0.0339c0 0.014 4e-3 0.0219 0.0102 0.0279 7e-3 7e-3 9e-3 0.0169 9e-3 0.0267 0 0.011 5e-3 0.024 0.0169 0.035v0.0547c0.013 0.01 0.0189 0.0228 0.0189 0.0346v0.0538c0.0121 0.0119 0.0169 0.0217 0.0169 0.0347v0.0727c0.0121 0 0.0189 6e-3 0.0189 0.015v0.0535c0.033 0.0964 0.0527 0.1801 0.0527 0.2486v10.257c0 0.0826-7e-3 0.1353-0.0197 0.1581-0.1046 0.9602-0.5121 1.7767-1.2229 2.4497-0.7221 0.6871-1.5602 1.0529-2.5196 1.0997-0.0468 0.0118-0.0845 0.0208-0.1152 0.0248-0.0299 6e-3 -0.0567 0.01-0.0795 0.01h-0.6215z"/>
    <path d="m142.95 217.99c0.5797 0 0.87 0.2973 0.87 0.8869 0 0.5797-0.2903 0.87-0.87 0.87h-0.6211c-0.5798 0-0.8701-0.2903-0.8701-0.87 0-0.5896 0.2903-0.8869 0.8701-0.8869zm0.2477 4.2416c0.4146 0 0.6223 0.2108 0.6223 0.638v11.213c0 0.4255-0.2077 0.6383-0.6223 0.6383h-0.6214c-0.4256 0-0.6383-0.2128-0.6383-0.6383v-10.576h-2.0591c-0.4244 0-0.6372-0.2119-0.6372-0.6375 0-0.4272 0.2128-0.638 0.6372-0.638h3.3008z"/>
    <path d="m151.78 232.63c0.6034-0.6037 0.9176-1.3672 0.9424-2.2908v-2.0562h-3.6925c-0.6733 0.0944-1.2359 0.3898-1.6854 0.8869-0.4492 0.52-0.673 1.1155-0.673 1.7905 0 0.7099 0.2407 1.3254 0.7257 1.8474 0.522 0.5191 1.1245 0.7964 1.8105 0.8331h0.372c0.8638-0.0465 1.5977-0.3847 2.2003-1.0109zm-1.8632 2.2907h-1.1524c-1.0648 0-1.9985-0.3858-2.8037-1.1544-0.7677-0.8055-1.1524-1.74-1.1524-2.8059 0-1.0986 0.3788-2.0281 1.1355-2.7837 0.7674-0.7697 1.6969-1.1653 2.7856-1.1893h3.993v-0.9932c-0.0248-0.7465-0.2973-1.3373-0.8181-1.7735-0.52-0.4625-1.1465-0.6931-1.8813-0.6931-0.0228 0-0.0456-3e-3 -0.0704-9e-3 -0.0231-6e-3 -0.0589-0.0149-0.1066-0.0259h-3.1398c-0.4256 0-0.6392-0.2128-0.6392-0.6403 0-0.4126 0.2136-0.6192 0.6392-0.6192h3.9391c0.024 0 0.0508 2e-3 0.0798 8e-3 0.0296 7e-3 0.0676 0.0149 0.1153 0.0267 0.9703 0.0598 1.7916 0.3718 2.4665 0.9397 0.71 0.5797 1.1237 1.3192 1.2409 2.2191 0.0358 0.0944 0.0536 0.1711 0.0536 0.2286v8.4293c0 0.4264-0.2128 0.6383-0.6392 0.6383h-0.6026c-0.4264 0-0.6372-0.2119-0.6372-0.6383v-0.0538c-0.8055 0.5926-1.7101 0.89-2.7163 0.89h-0.0169z"/>
    <path d="m166.58 226.64v4.3112h0.0166v0.0169c0 0.7088 0.2427 1.3252 0.728 1.8463 0.5199 0.5189 1.1233 0.7973 1.8093 0.8331h0.354c0.8661-0.0468 1.5977-0.3847 2.2022-1.0109 0.6026-0.6037 0.9168-1.3601 0.9388-2.2719v-4.5417c0-0.0121-2e-3 -0.0251-8e-3 -0.0338-5e-3 -0.0121-9e-3 -0.0248-9e-3 -0.0389v-0.0676c0-0.0257-5e-3 -0.0437-0.0169-0.0547v-0.0716c0-0.013-4e-3 -0.0217-0.0101-0.0347-6e-3 -0.0129-9e-3 -0.0239-9e-3 -0.0338 0-0.013-2e-3 -0.0259-8e-3 -0.0378-6e-3 -0.0121-9e-3 -0.0228-9e-3 -0.0349v-0.0536l-0.018-0.0188v-0.0519c-0.013-0.011-0.0169-0.0307-0.0169-0.0535h-0.0189c0-0.035-5e-3 -0.0587-0.0169-0.0708v-0.0716l-0.0189-0.0177c0-0.011-5e-3 -0.024-0.0178-0.035-0.011-0.01-0.0169-0.0296-0.0169-0.0546v-0.0158c0-0.024-7e-3 -0.0409-0.018-0.0519-0.024 0-0.0358-0.0189-0.0358-0.0547-0.024-0.0248-0.0347-0.0405-0.0347-0.0527 0-0.0126-4e-3 -0.0256-9e-3 -0.0366-6e-3 -0.0118-0.01-0.0228-0.01-0.0358l-0.0169-0.0161c0-0.0107-6e-3 -0.0236-0.018-0.0377-0.024-0.0217-0.0366-0.0406-0.0366-0.0527-0.022-0.0217-0.035-0.0417-0.035-0.0536l-0.0169-0.016c0-0.0127-0.0118-0.0308-0.0358-0.0547 0-0.0118-0.0118-0.0307-0.0358-0.0516 0-0.013-5e-3 -0.0259-0.0169-0.0358 0-0.011-0.0118-0.0307-0.0358-0.0527l-0.0177-0.0189c0-0.011-6e-3 -0.0228-0.0189-0.0346-0.0228-0.0251-0.035-0.044-0.035-0.0539h-0.0169c-0.0129-0.0239-0.0248-0.0346-0.0358-0.0346v-0.0181l-0.0358-0.0366h-0.0169l-0.0358-0.0349v-0.0189l-0.0358-0.0347c-0.0118 0-0.0177-6e-3 -0.0177-0.018l-0.035-0.0347h-0.0177l-0.0181-0.0189v-0.016h-0.0177v-0.0189l-0.035-0.0347h-0.0188l-0.0358-0.0358-0.0169-0.018c-0.0119-0.0119-0.0248-0.0178-0.0358-0.0178v-0.0169c-0.0248 0-0.0417-6e-3 -0.0527-0.018h-0.0189v-0.0198c-0.01-0.0101-0.0228-0.0149-0.0347-0.0149l-0.018-0.0189c-0.0107-0.0129-0.0237-0.018-0.0347-0.018 0-0.01-6e-3 -0.0169-0.018-0.0169l-0.0178-0.0198-0.018-0.0169c-0.0119 0-0.0237-4e-3 -0.0358-0.0169-0.0107 0-0.0228-6e-3 -0.0347-0.018-0.0129-0.0118-0.0239-0.0169-0.0369-0.0169l-0.0158-0.0189c-0.0129 0-0.0239-6e-3 -0.0369-0.0178-0.0107 0-0.0178-7e-3 -0.0178-0.018h-0.018l-0.0169-0.0169h-0.0347c-0.0118-0.0118-0.0259-0.0189-0.0369-0.0189 0-0.0118-6e-3 -0.0149-0.0169-0.0149-0.0118-0.013-0.0237-0.0198-0.0358-0.0198h-0.0169v-0.0188c-0.0138 0-0.0248-4e-3 -0.0366-0.0161h-0.0181c-0.0107 0-0.0228-6e-3 -0.0346-0.0178h-0.0539c-0.0107 0-0.0177-7e-3 -0.0177-0.0169h-0.0169c-0.0119 0-0.022-4e-3 -0.0268-0.0101-6e-3 -5e-3 -0.0161-9e-3 -0.0271-9e-3h-0.0188c-0.0108 0-0.0229-6e-3 -0.0336-0.0181-0.0121 0-0.0239-6e-3 -0.0369-0.0177h-0.0347c-0.0121 0-0.018-6e-3 -0.018-0.0181h-0.0347c-0.0121 0-0.0239-4e-3 -0.0358-0.0169h-0.0527c-0.0129-0.0118-0.0251-0.0177-0.0358-0.0177h-0.0358c-0.0121 0-0.025-7e-3 -0.0357-0.0181h-0.0708c-0.0118 0-0.0239-6e-3 -0.0358-0.0189h-0.0893c-0.0231 0-0.035-6e-3 -0.035-0.0157h-0.4086c-0.8858 0.0586-1.6425 0.4027-2.2707 1.0281-0.6144 0.6152-0.9216 1.3779-0.9216 2.2876zm6.0489-8.0026c0-0.4275 0.2077-0.638 0.6203-0.638h0.6234c0.4245 0 0.6384 0.2105 0.6384 0.638v15.454c0 0.4264-0.2139 0.6392-0.6384 0.6392h-0.6234c-0.4126 0-0.6203-0.2128-0.6203-0.6392v-0.0538c-0.7677 0.5557-1.6078 0.852-2.5176 0.89h-1.4554c-1.054 0-1.9638-0.3681-2.7332-1.1017-0.7567-0.7218-1.1535-1.6208-1.1873-2.6974-0.0127-0.0239-0.0189-0.0727-0.0189-0.1412v-4.3667c0-1.2527 0.4326-2.3116 1.2967-3.1745 0.85-0.8881 1.8959-1.3602 3.1388-1.4199h1.5261c0.0118 0 0.0268 2e-3 0.0448 9e-3 0.0178 6e-3 0.0318 0.01 0.0426 0.01h0.1254c0.0476 0 0.0775 4e-3 0.0885 0.0169h0.1062c-0.0228-0.013-0.0256-0.015-9e-3 -8e-3 0.0189 6e-3 0.0507 0.0138 0.0972 0.0248 0.0121 0 0.0271 2e-3 0.0448 9e-3 0.0181 6e-3 0.033 9e-3 0.0437 9e-3h0.018c0.0477 0 0.0775 7e-3 0.0894 0.0189 0.0121 0.0107 0.042 0.0178 0.0885 0.0178l0.018 0.016c0.0347 0 0.0586 6e-3 0.0716 0.0189h0.0169c0.0118 0 0.0248 2e-3 0.0366 8e-3 0.011 6e-3 0.0291 0.01 0.0528 0.01h0.0169c0.0248 0.0239 0.0479 0.0369 0.0715 0.0369h0.0181c0.011 0.01 0.0358 0.0169 0.0704 0.0169 0 0.0107 5e-3 0.0169 0.0181 0.0169 0.0118 0 0.0197 4e-3 0.0268 0.01 6e-3 4e-3 0.02 8e-3 0.0436 8e-3 0 0.011 6e-3 0.018 0.0181 0.018 0.0118 0 0.0236 3e-3 0.0346 0.01 0.0141 6e-3 0.0248 8e-3 0.0358 8e-3l0.0189 0.018c0.0121 0 0.022 2e-3 0.035 8e-3 0.0107 6e-3 0.0248 0.01 0.0358 0.01v0.0158h0.0177c0 0.0141 0.0169 0.0181 0.0527 0.0181l0.0358 0.02c0.0118 0 0.02 2e-3 0.0268 8e-3 6e-3 7e-3 0.0129 9e-3 0.0251 9e-3 0.0126 0.013 0.0256 0.018 0.0366 0.018 0.024 0.0229 0.0417 0.0347 0.0538 0.0347l0.0347 0.0189c0.024 0 0.0417 6e-3 0.0538 0.0169l0.0347 0.0358c0.013 0 0.0189 6e-3 0.0189 0.0169h0.0169c0.0129 0 0.0228 6e-3 0.0358 0.018 0.0239 0.026 0.0417 0.0347 0.0538 0.0347 0.0118 0.0141 0.0228 0.02 0.0338 0.02z"/>
    <path d="m180.87 223.3h-0.0527c-0.8759 0.0347-1.6267 0.3717-2.2541 1.0121-0.6022 0.6036-0.9176 1.3601-0.9404 2.2698v2.0929h3.4073c0.7206-0.01 1.3412-0.2773 1.8632-0.7973 0.52-0.5219 0.7804-1.1473 0.7804-1.8801 0-0.7229-0.2486-1.3432-0.7457-1.8632-0.52-0.5231-1.1234-0.7995-1.8094-0.8342h-0.1612zm-1.2248 11.416c-0.0358-4e-3 -0.0826-0.0138-0.1412-0.0268-1.0301-0.0578-1.91-0.4605-2.6447-1.2051-0.7091-0.7099-1.0769-1.5969-1.0997-2.6616v-4.471c0.0716-1.1831 0.538-2.1884 1.4018-3.0167 0.8751-0.8391 1.9041-1.2776 3.0872-1.3123h1.3314l0.0177 0.0178v-0.0178c1.0887 0 2.0165 0.3898 2.7848 1.1713 0.7815 0.7686 1.1713 1.7032 1.1713 2.8037 0 1.0639-0.3847 1.9985-1.1544 2.8028-0.7674 0.7694-1.6901 1.1522-2.7659 1.1522h-4.0107v0.8173c0.0228 0.7437 0.2902 1.3722 0.7984 1.8801 0.5566 0.5199 1.1882 0.7795 1.899 0.7795 0.0228 0 0.0496 4e-3 0.0794 0.011 0.0291 6e-3 0.0688 0.013 0.1164 0.0259h3.1399c0.4135 0 0.6203 0.2086 0.6203 0.6212 0 0.4256-0.2068 0.6383-0.6203 0.6383h-3.9403c-0.011 0-0.0346-4e-3 -0.0704-0.01z"/>
    <path d="m200.86 223.3h-0.1412c-0.8878 0.0456-1.6386 0.3906-2.2541 1.0281-0.6023 0.6034-0.9176 1.3562-0.9405 2.2538v4.3648h0.0181v0.0169c0 0.7099 0.2435 1.3254 0.7285 1.8462 0.518 0.52 1.1225 0.7973 1.8088 0.8331h0.3548c0.863-0.0465 1.5958-0.3835 2.2003-1.01 0.6034-0.6046 0.9176-1.3669 0.9405-2.2908v-4.3447c0-0.7229-0.2486-1.3432-0.7458-1.8632-0.5208-0.5231-1.1233-0.7995-1.8093-0.8342zm4.5953 2.4308v4.6113c-0.0229 1.2669-0.4614 2.3257-1.3122 3.1777-0.8402 0.8739-1.8703 1.3423-3.0872 1.4029h-1.4557c-0.7694 0-1.4604-0.2029-2.076-0.6056v4.863c0 0.4146-0.2068 0.6214-0.6203 0.6214h-0.6214c-0.4146 0-0.6215-0.2068-0.6215-0.6214v-16.306c0-0.4275 0.2069-0.6383 0.6215-0.6383h0.6214c0.4135 0 0.6203 0.2108 0.6203 0.6383v0.0527c0.7567-0.5687 1.6146-0.87 2.572-0.9047h1.5622c0.0248 0.0119 0.0417 0.0178 0.0536 0.0178h0.1412c0.0369 0 0.0597 4e-3 0.0707 0.0169h0.0893c0.013 0 0.024 7e-3 0.0358 0.0181h0.1066c0.0118 0.0109 0.0296 0.0169 0.0524 0.0169h0.0358c0.0121 0.0138 0.029 0.0197 0.0538 0.0197l0.0169 0.0169h0.0716c0.0118 0 0.0209 2e-3 0.0268 8e-3 6e-3 6e-3 0.0149 9e-3 0.0268 9e-3 0.0231 0.013 0.042 0.018 0.0527 0.018h0.0349c0.0118 0.0119 0.0307 0.0178 0.0547 0.0178 0.0228 0 0.0338 7e-3 0.0338 0.0189 0.0248 0 0.0417 5e-3 0.0536 0.018h0.0357c0.011 0.011 0.0291 0.0178 0.0527 0.0178l0.0181 0.016h0.0177c0.0229 0 0.042 7e-3 0.0547 0.0189 0.0231 0 0.042 5e-3 0.0519 0.0169 0.0118 0.0119 0.0236 0.0178 0.0358 0.0178 0.0118 0.013 0.0307 0.0189 0.0535 0.0189 0.011 0.0101 0.024 0.0169 0.035 0.0169l0.0366 0.0169c0.011 0 0.0228 7e-3 0.0358 0.0169 0.0101 0 0.02 4e-3 0.0259 0.01 5e-3 7e-3 0.0138 0.011 0.0259 0.011 0.0119 0.0109 0.0248 0.016 0.0358 0.016 0.0119 0.013 0.0299 0.0178 0.0536 0.0178 0 0.0129 0.011 0.0169 0.0358 0.0169l0.0169 0.018c0.0121 0 0.0239 7e-3 0.0358 0.0198 0.011 0.0109 0.0228 0.016 0.0358 0.016 0.0228 0.013 0.0417 0.0189 0.0518 0.0189l0.0178 0.0169c0 0.0237 0.018 0.0358 0.0538 0.0358v0.0178h0.0189l0.0169 0.0169c0.0107 0 0.0248 7e-3 0.0358 0.0189 0.1181 0.0586 0.2187 0.1223 0.3021 0.195 0.0229 0.0228 0.0457 0.0417 0.0696 0.0535 0.0248 0.011 0.0477 0.0299 0.0708 0.0527v0.0181h0.0189c0 0.0236 0.0177 0.0366 0.0515 0.0366l0.02 0.0161 0.0528 0.0515v0.0201h0.0177c0 0.0228 0.011 0.0357 0.0338 0.0357l0.0189 0.0158 0.0538 0.0547h0.0167c0 0.035 0.018 0.0538 0.0549 0.0538l0.0167 0.0158c0 0.0138 0.0121 0.0319 0.0349 0.0547l0.0178 0.0169 0.0538 0.0536v0.018h0.0169c0 0.0347 0.0118 0.0535 0.0366 0.0535l0.0169 0.0181c0.013 0.011 0.0189 0.0239 0.0189 0.0346l0.0169 0.0169h0.0181c0.0118 0.0122 0.0208 0.0251 0.0259 0.0378 6e-3 0.011 0.0158 0.022 0.0276 0.0338v0.0181c0.011 0 0.029 0.0169 0.0519 0.0535v0.0169c0.0248 0.035 0.0476 0.0747 0.0716 0.1156 0.0228 0.0425 0.0535 0.0744 0.0893 0.0983 0.2596 0.4276 0.4377 0.8819 0.5321 1.3652v0.0178c0.011 0.0138 0.0178 0.0369 0.0178 0.0704 0 0.0598 5e-3 0.0947 0.0169 0.1066v0.0893c0.0129 0.011 0.018 0.0488 0.018 0.1054v0.0905z"/>
    <path d="m211.9 223.3h-0.142c-0.8881 0.0597-1.6437 0.4027-2.2719 1.0281-0.6144 0.6153-0.9227 1.379-0.9227 2.2888v4.3298h0.0189v0.0169c0 0.7099 0.2427 1.3254 0.7257 1.8462 0.522 0.52 1.1245 0.7973 1.8105 0.8331h0.3551c0.8638-0.0465 1.5977-0.3835 2.2003-1.01 0.6034-0.6046 0.9176-1.3669 0.9404-2.2908v-4.3447c0-0.7229-0.2485-1.3432-0.7446-1.8632-0.5199-0.5231-1.1245-0.7995-1.8096-0.8342zm4.5944 2.4308v4.6113c-0.0228 1.2669-0.4602 2.3257-1.3124 3.1777-0.8391 0.8739-1.87 1.3423-3.0869 1.4029h-1.4557c-1.0529 0-1.9635-0.368-2.7321-1.1016-0.7567-0.7218-1.1544-1.6206-1.1871-2.6975-0.0141-0.0228-0.0188-0.0715-0.0188-0.14v-4.3667c0-1.2539 0.4323-2.3116 1.2953-3.1749 0.8511-0.8886 1.897-1.3609 3.1398-1.4196h1.5611c0.0248 0.0119 0.0417 0.0178 0.0547 0.0178h0.142c0.0338 0 0.0586 4e-3 0.0708 0.0169h0.0873c0.013 0 0.024 7e-3 0.0358 0.0181h0.1063c0.011 0.0109 0.0299 0.0169 0.0538 0.0169h0.0347c0.0121 0.0138 0.029 0.0197 0.0538 0.0197l0.0169 0.0169h0.0716c0.0118 0 0.0209 2e-3 0.0268 8e-3 6e-3 6e-3 0.0149 9e-3 0.0267 9e-3 0.0232 0.013 0.042 0.018 0.0547 0.018h0.0338c0.0122 0.0119 0.0299 0.0178 0.0539 0.0178 0.0228 0 0.0346 7e-3 0.0346 0.0189 0.0251 0 0.0417 5e-3 0.0539 0.018h0.0346c0.013 0.011 0.0299 0.0178 0.0539 0.0178l0.0177 0.016h0.0181c0.0236 0 0.0405 7e-3 0.0535 0.0189 0.022 0 0.0409 5e-3 0.0519 0.0169 0.0118 0.0119 0.0248 0.0178 0.0358 0.0178 0.0118 0.013 0.0298 0.0189 0.0535 0.0189 0.0121 0.0101 0.024 0.0169 0.0358 0.0169l0.0358 0.0169c0.0121 0 0.0228 7e-3 0.0358 0.0169 0.0121 0 0.0208 4e-3 0.0259 0.01 6e-3 7e-3 0.0149 0.011 0.0268 0.011 0.011 0.0109 0.0239 0.016 0.0349 0.016 0.013 0.013 0.0299 0.0178 0.0536 0.0178 0 0.0129 0.0121 0.0169 0.0358 0.0169l0.0169 0.018c0.0129 0 0.0239 7e-3 0.0358 0.0198 0.0118 0.0109 0.0228 0.016 0.0358 0.016 0.0239 0.013 0.0417 0.0189 0.0538 0.0189l0.0169 0.0169c0 0.0237 0.0169 0.0358 0.0547 0.0358v0.0178h0.0169l0.0169 0.0169c0.0118 0 0.0228 7e-3 0.0358 0.0189 0.1181 0.0586 0.2187 0.1223 0.3021 0.195 0.024 0.0228 0.0468 0.0417 0.0696 0.0535 0.0248 0.011 0.0488 0.0299 0.0727 0.0527v0.0181h0.0167c0 0.0236 0.0191 0.0366 0.0538 0.0366l0.0178 0.0161 0.0527 0.0515v0.0201h0.018c0 0.0228 0.0118 0.0357 0.0347 0.0357l0.018 0.0158 0.0535 0.0547h0.0181c0 0.035 0.0177 0.0538 0.0535 0.0538l0.0169 0.0158c0 0.0138 0.0122 0.0319 0.0358 0.0547l0.0181 0.0169 0.0527 0.0536v0.018h0.0189c0 0.0347 0.0109 0.0535 0.0346 0.0535l0.0169 0.0181c0.0121 0.011 0.0189 0.0239 0.0189 0.0346l0.0169 0.0169h0.0189c0.011 0.0122 0.02 0.0251 0.0271 0.0378 5e-3 0.011 0.0138 0.022 0.0256 0.0338v0.0181c0.0121 0 0.029 0.0169 0.0527 0.0535v0.0169c0.024 0.035 0.0479 0.0747 0.0716 0.1156 0.024 0.0425 0.0527 0.0744 0.0885 0.0983 0.2596 0.4276 0.4377 0.8819 0.5321 1.3652v0.0178c0.0118 0.0138 0.0177 0.0369 0.0177 0.0704 0 0.0598 5e-3 0.0947 0.0181 0.1066v0.0893c0.0118 0.011 0.0177 0.0488 0.0177 0.1054v0.0905z"/>
    <path d="m227.53 225.73v8.3554c0 0.4267-0.2117 0.6395-0.6383 0.6395h-0.6023c-0.4256 0-0.6395-0.2128-0.6395-0.6395v-8.0891c0-0.7226-0.2486-1.3432-0.7446-1.8632-0.5211-0.5228-1.1245-0.7993-1.8096-0.8342h-0.3022c-0.8869 0.0459-1.6385 0.3897-2.2541 1.0281-0.6022 0.6026-0.9165 1.3562-0.9393 2.253v7.5054c0 0.4267-0.208 0.6395-0.6226 0.6395h-0.6194c-0.4155 0-0.6223-0.2128-0.6223-0.6395v-11.212c0-0.4287 0.2068-0.6395 0.6223-0.6395h0.6194c0.4146 0 0.6226 0.2108 0.6226 0.6395v0.0527c0.7564-0.5699 1.6146-0.87 2.5731-0.905h1.5608c0.024 0.011 0.0409 0.0181 0.0527 0.0181h0.1423c0.0358 0 0.0587 4e-3 0.0716 0.0169h0.0874c0.0118 0 0.0239 7e-3 0.0358 0.0169h0.1062c0.013 0.0118 0.0291 0.0177 0.0539 0.0177h0.0358c0.0109 0.0141 0.0287 0.0189 0.0527 0.0189l0.0169 0.0181h0.0716c0.0118 0 0.0219 2e-3 0.0267 8e-3 6e-3 6e-3 0.0141 9e-3 0.0268 9e-3 0.0231 0.0118 0.042 0.0177 0.0527 0.0177h0.0349c0.013 0.0121 0.0308 0.0181 0.0547 0.0181 0.0229 0 0.0347 7e-3 0.0347 0.0177 0.0239 0 0.042 6e-3 0.0538 0.0189h0.0347c0.0121 0.011 0.031 0.0169 0.0538 0.0169l0.0178 0.0169h0.0169c0.0239 0 0.0428 7e-3 0.0538 0.0189 0.0228 0 0.0417 4e-3 0.0527 0.0169 0.0119 0.0119 0.0248 0.0181 0.0367 0.0181 0.0109 0.0118 0.0298 0.0177 0.0527 0.0177 0.0109 0.011 0.0228 0.018 0.0357 0.018l0.035 0.0158c0.013 0 0.0237 7e-3 0.0358 0.0181 0.011 0 0.0208 4e-3 0.0268 0.01 6e-3 7e-3 0.0149 0.011 0.0259 0.011 0.0118 0.01 0.0248 0.0158 0.0358 0.0158 0.0118 0.013 0.0307 0.018 0.0535 0.018 0 0.0119 0.0121 0.0158 0.0358 0.0158l0.0169 0.0189c0.0122 0 0.0248 7e-3 0.0358 0.0189 0.0121 0.0118 0.024 0.0169 0.0358 0.0169 0.0228 0.013 0.0417 0.0189 0.0538 0.0189l0.017 0.0169c0 0.0239 0.0177 0.0349 0.0546 0.0349v0.0189h0.0158l0.0189 0.0158c0.011 0 0.0228 7e-3 0.0358 0.02 0.1164 0.0586 0.2178 0.1223 0.3013 0.1939 0.0228 0.0237 0.0456 0.0417 0.0707 0.0547 0.0237 0.0107 0.0465 0.0287 0.0716 0.0527v0.0166h0.0169c0 0.0251 0.0189 0.0369 0.0527 0.0369l0.0178 0.017 0.0546 0.0515v0.0189h0.0169c0 0.024 0.011 0.0358 0.0347 0.0358l0.0192 0.0169 0.0524 0.0547h0.0169c0 0.0349 0.018 0.0527 0.0538 0.0527l0.0178 0.0169c0 0.0141 0.0121 0.031 0.0349 0.0547l0.0189 0.016 0.0516 0.0547v0.0178h0.0189c0 0.0349 0.0121 0.0527 0.0358 0.0527l0.018 0.0189c0.011 0.0109 0.0178 0.0231 0.0178 0.0349l0.0169 0.0169h0.0169c0.013 0.011 0.0208 0.0248 0.0279 0.0378 5e-3 0.01 0.0149 0.022 0.0268 0.0338v0.0169c0.0121 0 0.029 0.0178 0.0538 0.0547v0.0169c0.0228 0.0347 0.0468 0.0744 0.0704 0.1153 0.022 0.0428 0.0528 0.0746 0.0885 0.0983 0.2607 0.4267 0.4386 0.881 0.533 1.3652v0.0178c0.011 0.0141 0.0169 0.0358 0.0169 0.0696 0 0.0609 6e-3 0.0955 0.018 0.1074v0.0896c0.0119 0.01 0.0178 0.0487 0.0178 0.1054v0.0905z"/>
    <path d="m235.46 234.73h-0.035c-0.013 0-0.0287-6e-3 -0.0547-0.0189-1.0061-0.011-1.8978-0.3528-2.6785-1.027-0.7336-0.6513-1.1293-1.5033-1.189-2.5562-0.0119-0.0228-0.0178-0.0716-0.0178-0.1412v-7.4877h-2.0751c-0.4276 0-0.6403-0.2068-0.6403-0.6203 0-0.4287 0.2127-0.6395 0.6403-0.6395h2.0751v-2.3234c0-0.4275 0.2136-0.6403 0.6403-0.6403h0.6192c0.4137 0 0.6226 0.2128 0.6226 0.6403v2.3234h3.2999c0.4135 0 0.6204 0.2108 0.6204 0.6395 0 0.4135-0.2069 0.6203-0.6204 0.6203h-3.2999v7.4519h0.0169v0.0169c0 0.71 0.2426 1.2976 0.7277 1.7587 0.52 0.4475 1.1174 0.691 1.7907 0.7268h2.0769c0.4255 0 0.6394 0.2108 0.6394 0.6375 0 0.4264-0.2139 0.6392-0.6394 0.6392z"/>
    <path d="m246.46 232.63c0.6014-0.6037 0.9157-1.3672 0.9385-2.2908v-2.0562h-3.6886c-0.6753 0.0944-1.2378 0.3898-1.6873 0.8869-0.4484 0.52-0.6731 1.1155-0.6731 1.7905 0 0.7099 0.2427 1.3254 0.7277 1.8474 0.5192 0.5191 1.1234 0.7964 1.8097 0.8331h0.3717c0.8641-0.0465 1.5977-0.3847 2.2014-1.0109zm-1.8643 2.2907h-1.1524c-1.0648 0-1.9993-0.3858-2.8037-1.1544-0.7697-0.8055-1.1544-1.74-1.1544-2.8059 0-1.0986 0.3799-2.0281 1.1375-2.7837 0.7686-0.7697 1.6961-1.1653 2.7859-1.1893h3.9899v-0.9932c-0.0228-0.7465-0.2954-1.3373-0.8153-1.7735-0.52-0.4625-1.1474-0.6931-1.8813-0.6931-0.0228 0-0.0456-3e-3 -0.0696-9e-3 -0.0248-6e-3 -0.0594-0.0149-0.1074-0.0259h-3.1396c-0.4267 0-0.6394-0.2128-0.6394-0.6403 0-0.4126 0.2127-0.6192 0.6394-0.6192h3.9381c0.0239 0 0.0507 2e-3 0.0806 8e-3 0.0279 7e-3 0.0676 0.0149 0.1152 0.0267 0.9695 0.0598 1.7908 0.3718 2.4649 0.9397 0.7108 0.5797 1.1254 1.3192 1.2426 2.2191 0.035 0.0944 0.0539 0.1711 0.0539 0.2286v8.4293c0 0.4264-0.2128 0.6383-0.6384 0.6383h-0.6034c-0.4267 0-0.6403-0.2119-0.6403-0.6383v-0.0538c-0.8024 0.5926-1.7071 0.89-2.7135 0.89h-0.0169z"/>
    <path d="m266.37 232.63c0.6026-0.6037 0.9168-1.3672 0.9396-2.2908v-2.0562h-3.6894c-0.6742 0.0944-1.237 0.3898-1.6862 0.8869-0.4495 0.52-0.6742 1.1155-0.6742 1.7905 0 0.7099 0.2435 1.3254 0.7289 1.8474 0.5199 0.5191 1.1233 0.7964 1.8085 0.8331h0.3717c0.8641-0.0465 1.5977-0.3847 2.2011-1.0109zm-1.8621 2.2907h-1.1543c-1.064 0-1.9985-0.3858-2.8037-1.1544-0.7697-0.8055-1.1533-1.74-1.1533-2.8059 0-1.0986 0.3788-2.0281 1.1364-2.7837 0.7674-0.7697 1.6972-1.1653 2.7859-1.1893h3.9907v-0.9932c-0.0228-0.7465-0.2953-1.3373-0.8153-1.7735-0.5208-0.4625-1.1473-0.6931-1.8821-0.6931-0.0228 0-0.0456-3e-3 -0.0696-9e-3 -0.0237-6e-3 -0.0586-0.0149-0.1054-0.0259h-3.1416c-0.4255 0-0.6395-0.2128-0.6395-0.6403 0-0.4126 0.214-0.6192 0.6395-0.6192h3.9392c0.0237 0 0.0507 2e-3 0.0795 8e-3 0.0287 7e-3 0.0676 0.0149 0.1164 0.0267 0.9692 0.0598 1.7904 0.3718 2.4646 0.9397 0.7108 0.5797 1.1234 1.3192 1.2437 2.2191 0.0338 0.0944 0.0519 0.1711 0.0519 0.2286v8.4293c0 0.4264-0.2128 0.6383-0.6384 0.6383h-0.6045c-0.4245 0-0.6384-0.2119-0.6384-0.6383v-0.0538c-0.8032 0.5926-1.7081 0.89-2.7143 0.89h-0.0177z"/>
    <path d="m275.63 223.3h-0.1401c-0.8889 0.0597-1.6456 0.4027-2.2718 1.0281-0.6155 0.6153-0.9227 1.379-0.9227 2.2888v4.3298h0.0169v0.0169c0 0.7099 0.2426 1.3254 0.7288 1.8462 0.52 0.52 1.1234 0.7973 1.8094 0.8331h0.3551c0.8629-0.0465 1.5965-0.3835 2.1991-1.01 0.6034-0.6046 0.9188-1.3669 0.9405-2.2908v-4.3447c0-0.7229-0.2495-1.3432-0.7458-1.8632-0.5199-0.5231-1.1233-0.7995-1.8085-0.8342zm4.5964 2.4308v4.6113c-0.0228 1.2669-0.4605 2.3257-1.3125 3.1777-0.841 0.8739-1.8691 1.3423-3.0892 1.4029h-1.4534c-1.0529 0-1.9646-0.368-2.7332-1.1016-0.7556-0.7218-1.1532-1.6206-1.1882-2.6975-0.0118-0.0228-0.0177-0.0715-0.0177-0.14v-4.3667c0-1.2539 0.4315-2.3116 1.2944-3.1749 0.852-0.8886 1.8979-1.3609 3.1408-1.4196h1.563c0.0217 0.0119 0.0417 0.0178 0.0527 0.0178h0.1412c0.0347 0 0.0595 4e-3 0.0705 0.0169h0.0896c0.0107 0 0.0237 7e-3 0.0358 0.0181h0.1074c0.01 0.0109 0.0287 0.0169 0.0515 0.0169h0.0358c0.0119 0.0138 0.0299 0.0197 0.0539 0.0197l0.0169 0.0169h0.0704c0.013 0 0.022 2e-3 0.0268 8e-3 6e-3 6e-3 0.0149 9e-3 0.0279 9e-3 0.022 0.013 0.0417 0.018 0.0527 0.018h0.0358c0.01 0.0119 0.0287 0.0178 0.0527 0.0178 0.0248 0 0.0358 7e-3 0.0358 0.0189 0.0239 0 0.0417 5e-3 0.0538 0.018h0.0347c0.011 0.011 0.0299 0.0178 0.0527 0.0178l0.0189 0.016h0.0169c0.0239 0 0.0417 7e-3 0.0527 0.0189 0.0239 0 0.0428 5e-3 0.0535 0.0169 0.0121 0.0119 0.0231 0.0178 0.0358 0.0178 0.011 0.013 0.0299 0.0189 0.0539 0.0189 0.0109 0.0101 0.0239 0.0169 0.0346 0.0169l0.0369 0.0169c0.011 0 0.0229 7e-3 0.0339 0.0169 0.0129 0 0.0219 4e-3 0.0267 0.01 6e-3 7e-3 0.015 0.011 0.0279 0.011 0.011 0.0109 0.0229 0.016 0.0347 0.016 0.0121 0.013 0.029 0.0178 0.0527 0.0178 0 0.0129 0.0121 0.0169 0.0369 0.0169l0.0169 0.018c0.011 0 0.024 7e-3 0.0338 0.0198 0.013 0.0109 0.0268 0.016 0.0378 0.016 0.0228 0.013 0.0409 0.0189 0.0516 0.0189l0.018 0.0169c0 0.0237 0.0189 0.0358 0.0547 0.0358v0.0178h0.0169l0.0178 0.0169c0.0101 0 0.0251 7e-3 0.0349 0.0189 0.1192 0.0586 0.2207 0.1223 0.3021 0.195 0.0229 0.0228 0.0468 0.0417 0.0716 0.0535 0.0229 0.011 0.0468 0.0299 0.0696 0.0527v0.0181h0.0189c0 0.0236 0.0169 0.0366 0.0519 0.0366l0.0189 0.0161 0.0535 0.0515v0.0201h0.0161c0 0.0228 0.0127 0.0357 0.0358 0.0357l0.0188 0.0158 0.0527 0.0547h0.0178c0 0.035 0.018 0.0538 0.0527 0.0538l0.0189 0.0158c0 0.0138 0.0118 0.0319 0.0358 0.0547l0.018 0.0169 0.0507 0.0536v0.018h0.0198c0 0.0347 0.011 0.0535 0.0349 0.0535l0.0178 0.0181c0.011 0.011 0.018 0.0239 0.018 0.0346l0.0178 0.0169h0.0169c0.0129 0.0122 0.022 0.0251 0.0268 0.0378 6e-3 0.011 0.0149 0.022 0.0259 0.0338v0.0181c0.0118 0 0.0307 0.0169 0.0547 0.0535v0.0169c0.0228 0.035 0.0456 0.0747 0.0707 0.1156 0.0228 0.0425 0.0516 0.0744 0.0893 0.0983 0.2585 0.4276 0.4366 0.8819 0.5319 1.3652v0.0178c0.0109 0.0138 0.016 0.0369 0.016 0.0704 0 0.0598 7e-3 0.0947 0.0189 0.1066v0.0893c0.0118 0.011 0.0178 0.0488 0.0178 0.1054v0.0905z"/>
    <path d="m296.57 227.63c0.9326 0.0834 1.7381 0.4732 2.4142 1.171 0.6719 0.6733 1.0569 1.4844 1.1533 2.43h-0.037 0.037c-0.0708 1.0182-0.4854 1.8505-1.2429 2.5015-0.7567 0.6513-1.6504 0.9754-2.6774 0.9754h-0.0736c-0.0101 0-0.022 4e-3 -0.0338 9e-3 -0.0141 6e-3 -0.0248 0.01-0.0369 0.01h-5.0913c-0.4267 0-0.6395-0.2128-0.6395-0.6392 0-0.4275 0.2128-0.6375 0.6395-0.6375h4.7542c0.6513-0.0366 1.215-0.2486 1.6952-0.6392 0.4794-0.3898 0.7536-0.9117 0.8244-1.563-0.0944-0.6384-0.3639-1.173-0.8063-1.6048-0.4445-0.4315-0.9853-0.6769-1.6237-0.7356l-2.946-0.3201v-0.0169c-0.7088-0.0248-1.3062-0.2844-1.7916-0.7816-0.4723-0.4971-0.7209-1.0926-0.7457-1.7916v-0.0893c0.0248-1.0521 0.4087-1.9221 1.1533-2.6069 0.7567-0.6871 1.6605-1.0411 2.7143-1.0648h4.0288c0.4126 0 0.6214 0.2105 0.6214 0.6392 0 0.4134-0.2088 0.6203-0.6214 0.6203h-3.4609c-0.7201 0.0349-1.3176 0.2706-1.7908 0.7099-0.5101 0.4496-0.7694 1.0172-0.7815 1.7023h0.018c0 0.3678 0.1204 0.6809 0.3639 0.9413 0.2415 0.2607 0.5408 0.4067 0.8968 0.4425l0.0873 0.0189h0.037z"/>
    <path d="m306.49 223.3h-0.0547c-0.8759 0.0347-1.6256 0.3717-2.2529 1.0121-0.6034 0.6036-0.9166 1.3601-0.9394 2.2698v2.0929h3.4062c0.7218-0.01 1.3433-0.2773 1.8632-0.7973 0.5209-0.5219 0.7796-1.1473 0.7796-1.8801 0-0.7229-0.2478-1.3432-0.7449-1.8632-0.52-0.5231-1.1245-0.7995-1.8094-0.8342h-0.1592zm-1.2248 11.416c-0.0358-4e-3 -0.0826-0.0138-0.1421-0.0268-1.0292-0.0578-1.9111-0.4605-2.6438-1.2051-0.7097-0.7099-1.0758-1.5969-1.1006-2.6616v-4.471c0.0707-1.1831 0.5389-2.1884 1.403-3.0167 0.8739-0.8391 1.9049-1.2776 3.086-1.3123h1.3314l0.0169 0.0178v-0.0178c1.0887 0 2.0182 0.3898 2.7868 1.1713 0.7795 0.7686 1.1701 1.7032 1.1701 2.8037 0 1.0639-0.3836 1.9985-1.1532 2.8028-0.7694 0.7694-1.6913 1.1522-2.7671 1.1522h-4.0096v0.8173c0.0228 0.7437 0.2883 1.3722 0.7973 1.8801 0.5558 0.5199 1.1891 0.7795 1.8979 0.7795 0.0251 0 0.0518 4e-3 0.0797 0.011 0.0319 6e-3 0.0696 0.013 0.1173 0.0259h3.1399c0.4145 0 0.6214 0.2086 0.6214 0.6212 0 0.4256-0.2069 0.6383-0.6214 0.6383h-3.9384c-0.0118 0-0.0357-4e-3 -0.0715-0.01z"/>
    <path d="m317.81 234.92h-1.4537c-1.0529 0-1.9647-0.3681-2.7321-1.1017-0.7587-0.7218-1.1544-1.6208-1.189-2.6974-0.013-0.0239-0.0181-0.0727-0.0181-0.1412v-8.108c0-0.4287 0.208-0.6392 0.6215-0.6392h0.6214c0.4137 0 0.6203 0.2105 0.6203 0.6392v8.0722h0.018v0.0169c0 0.7088 0.2416 1.3252 0.7269 1.8463 0.5208 0.5189 1.1245 0.7973 1.8105 0.8331h0.3548c0.863-0.0468 1.5957-0.3847 2.2003-1.0109 0.6014-0.6037 0.9168-1.3672 0.9396-2.2899v-7.4877c0-0.4126 0.2128-0.6192 0.6392-0.6192h0.6025c0.4265 0 0.6392 0.2066 0.6392 0.6192v11.232c0 0.4264-0.2127 0.6392-0.6392 0.6392h-0.6025c-0.4264 0-0.6392-0.2128-0.6392-0.6392v-0.0538c-0.7677 0.5557-1.6087 0.852-2.5204 0.89z"/>
    <path d="m339.29 232.63c0.6025-0.6037 0.9168-1.3672 0.9396-2.2908v-2.0562h-3.6897c-0.6739 0.0944-1.2367 0.3898-1.6862 0.8869-0.4493 0.52-0.6739 1.1155-0.6739 1.7905 0 0.7099 0.2424 1.3254 0.7285 1.8474 0.52 0.5191 1.1237 0.7964 1.8086 0.8331h0.3739c0.863-0.0465 1.5958-0.3847 2.1992-1.0109zm-1.8621 2.2907h-1.1544c-1.0639 0-1.9984-0.3858-2.8036-1.1544-0.7697-0.8055-1.1524-1.74-1.1524-2.8059 0-1.0986 0.3787-2.0281 1.1355-2.7837 0.7674-0.7697 1.698-1.1653 2.7859-1.1893h3.9907v-0.9932c-0.0228-0.7465-0.2954-1.3373-0.8153-1.7735-0.52-0.4625-1.1474-0.6931-1.8821-0.6931-0.0228 0-0.0457-3e-3 -0.0696-9e-3 -0.0237-6e-3 -0.0586-0.0149-0.1054-0.0259h-3.1416c-0.4256 0-0.6384-0.2128-0.6384-0.6403 0-0.4126 0.2128-0.6192 0.6384-0.6192h3.9392c0.0236 0 0.0507 2e-3 0.0794 8e-3 0.0299 7e-3 0.0677 0.0149 0.1164 0.0267 0.9692 0.0598 1.7905 0.3718 2.4646 0.9397 0.7108 0.5797 1.1234 1.3192 1.2418 2.2191 0.0358 0.0944 0.0547 0.1711 0.0547 0.2286v8.4293c0 0.4264-0.2137 0.6383-0.6384 0.6383h-0.6053c-0.4245 0-0.6384-0.2119-0.6384-0.6383v-0.0538c-0.8043 0.5926-1.7082 0.89-2.7143 0.89h-0.0169z"/>
    <path d="m347.01 217.99c0.4146 0 0.6215 0.2119 0.6215 0.6395v15.453c0 0.4255-0.2069 0.6383-0.6215 0.6383h-0.6203c-0.4264 0-0.6392-0.2128-0.6392-0.6383v-14.798h-2.0582c-0.4256 0-0.6383-0.2127-0.6383-0.6383 0-0.4383 0.2127-0.6561 0.6383-0.6561h3.3z"/>
    <path d="m351.47 230.98c0.0229 0.7091 0.2785 1.3243 0.7635 1.8443 0.4724 0.5082 1.0758 0.7807 1.8085 0.8165h0.8881c0.6978-0.0358 1.3063-0.3143 1.8274-0.8334 0.509-0.5098 0.7626-1.1304 0.7626-1.8632 0.0127-0.4036 0.2255-0.6054 0.6381-0.6054h0.6037c0.4134 0 0.6273 0.2018 0.6392 0.6054v0.0538c-0.0119 1.064-0.4087 1.9875-1.1891 2.7679-0.7446 0.7446-1.6563 1.1285-2.7332 1.1544h-1.9517c-1.0647-0.0259-1.9745-0.3988-2.7321-1.1186-0.7567-0.7237-1.1524-1.6157-1.1893-2.6805v-4.6302c0.013-1.2068 0.4495-2.242 1.3136-3.1058 0.8531-0.8511 1.8939-1.3066 3.1227-1.3663h1.5622c0.0119 0.0121 0.0347 0.0189 0.0705 0.0189h0.1431c0.0229 0 0.0398 4e-3 0.0516 0.016h0.0896c0.011 0 0.0201 4e-3 0.026 9e-3 6e-3 5e-3 0.0169 9e-3 0.0267 9e-3h0.0527c0.0249 0 0.0418 7e-3 0.0547 0.018h0.0358c0.022 0 0.0409 6e-3 0.0527 0.0189h0.0527c0.011 0.011 0.024 0.0178 0.0358 0.0178h0.0527c0 0.011 0.0169 0.016 0.0536 0.016l0.0358 0.0189c0.011 0 0.02 2e-3 0.0259 8e-3 6e-3 6e-3 0.0161 9e-3 0.0268 9e-3h0.0527c0.025 0 0.0417 7e-3 0.0538 0.0189 0.011 0.0118 0.0237 0.0189 0.0347 0.0189 0.0129 0.01 0.031 0.0169 0.0546 0.0169 0.011 0.011 0.022 0.0169 0.0358 0.0169 0.024 0 0.0398 7e-3 0.0527 0.0178h0.0338c0.0249 0.025 0.0418 0.0349 0.0547 0.0349h0.035c0.0248 0.0248 0.0417 0.0366 0.0546 0.0366 0.011 0 0.0217 4e-3 0.0347 0.0161 0.0121 0 0.0189 4e-3 0.0268 9e-3 5e-3 7e-3 0.0141 9e-3 0.0259 9e-3h0.0358c0 0.0239 0.0169 0.0369 0.0538 0.0369l0.0169 0.0169h0.0189c0.0229 0.013 0.0406 0.0169 0.0527 0.0169 0.0119 0 0.0237 7e-3 0.0347 0.0189 0 0.0248 0.018 0.0358 0.0538 0.0358 0.0119 0 0.0237 6e-3 0.0358 0.0177l0.0338 0.0181c0.0127 0.011 0.0257 0.0158 0.0367 0.0158 0 0.027 0.018 0.0377 0.0538 0.0377 0.0107 0 0.0237 6e-3 0.0347 0.0161 0 0.0248 0.018 0.0358 0.0527 0.0358l0.018 0.0177c0.0237 0.024 0.0426 0.037 0.0536 0.037 0.0118 0.0109 0.0228 0.0169 0.0358 0.0169 0-0.011 0.0169 0 0.0538 0.0346l0.0169 0.0181c0.0127 0 0.0197 7e-3 0.0268 0.0188 7e-3 0.0119 0.0138 0.0178 0.0279 0.0178v0.0169h0.0169c0.0118 0.013 0.0287 0.0228 0.0527 0.035l0.0158 0.0197 0.0546 0.0518h0.0189c0.0347 0.0367 0.0578 0.0547 0.0705 0.0547v0.0169c0.011 0.011 0.0231 0.0209 0.0338 0.0268 0.013 5e-3 0.024 0.0138 0.0369 0.0248v0.0189h0.0178l0.0349 0.0358 0.0178 0.0169 0.0538 0.0538 0.0169 0.0178 0.0547 0.0527h0.0177c0.024 0.0239 0.0401 0.0476 0.0528 0.0707 0.0129 0.0248 0.0298 0.0477 0.0538 0.0716h0.0169c0.011 0.0228 0.0287 0.0476 0.0547 0.0724l0.0157 0.0169c0.013 0.0119 0.024 0.0288 0.037 0.0527 0.01 0.0139 0.0197 0.0229 0.0267 0.035 5e-3 0.0127 0.015 0.0248 0.0248 0.0358h0.0189c0.011 0.0107 0.0209 0.0237 0.0271 0.0366 5e-3 0.013 0.0138 0.0229 0.0268 0.0338v0.0189c0 0.013 0.0169 0.0338 0.0527 0.0708 0 0.0107 0.0169 0.0358 0.0527 0.0716v0.0177l0.0527 0.0527v0.0169c0 0.013 0.0177 0.0378 0.0535 0.0725 0 0.0349 0.013 0.0656 0.0358 0.0876 0.0228 0.0936 0.0358 0.1251 0.0358 0.0885h0.018c0 0.024 0.011 0.0457 0.0347 0.0724 0.0121 0.0231 0.0248 0.0519 0.0358 0.0877 0.011 0.0366 0.0299 0.0645 0.0527 0.0885 0 0.0366 0.013 0.0645 0.0358 0.0885-0.0118-0.024-0.0149-0.031-8e-3 -0.0181 4e-3 0.0122 0.0189 0.0479 0.0437 0.1066 0.011 0.0138 0.0189 0.0307 0.0189 0.0546 0 0.0119 4e-3 0.0229 0.0169 0.0339 0.01 0.0715 0.0248 0.1381 0.0437 0.1939 0.0169 0.0606 0.0318 0.1203 0.0448 0.1798 0.0228 0.0814 0.0417 0.153 0.0527 0.2128 0.0129 0.0597 0.0239 0.1172 0.0358 0.1769 0.011 0.024 0.018 0.0775 0.018 0.1601v0.1066c0 0.0476 6e-3 0.0884 0.0178 0.1231v0.1779c-0.0248 0.3909-0.2376 0.5856-0.6392 0.5856h-0.6037c-0.4126 0-0.6254-0.1947-0.6381-0.5856v-0.017c0-0.7217-0.2486-1.342-0.7449-1.8631-0.5208-0.522-1.1245-0.7982-1.8093-0.834h-0.3024c-0.8867 0.0457-1.6395 0.3906-2.2538 1.029-0.6026 0.6025-0.9168 1.3562-0.9397 2.2529v3.9223z"/>
    <path d="m367.61 232.63c0.6026-0.6037 0.9188-1.3672 0.9396-2.2908v-2.0562h-3.6906c-0.673 0.0944-1.2358 0.3898-1.6853 0.8869-0.4492 0.52-0.673 1.1155-0.673 1.7905 0 0.7099 0.2415 1.3254 0.7277 1.8474 0.518 0.5191 1.1236 0.7964 1.8085 0.8331h0.3728c0.8641-0.0465 1.598-0.3847 2.2003-1.0109zm-1.8621 2.2907h-1.1543c-1.064 0-1.9994-0.3858-2.8029-1.1544-0.7685-0.8055-1.1541-1.74-1.1541-2.8059 0-1.0986 0.3788-2.0281 1.1372-2.7837 0.7686-0.7697 1.6972-1.1653 2.7851-1.1893h3.9907v-0.9932c-0.0208-0.7465-0.2953-1.3373-0.8153-1.7735-0.522-0.4625-1.1473-0.6931-1.8809-0.6931-0.024 0-0.0468-3e-3 -0.0708-9e-3 -0.0237-6e-3 -0.0575-0.0149-0.1074-0.0259h-3.1396c-0.4255 0-0.6383-0.2128-0.6383-0.6403 0-0.4126 0.2128-0.6192 0.6383-0.6192h3.9392c0.0237 0 0.0496 2e-3 0.0795 8e-3 0.0307 7e-3 0.0685 0.0149 0.1164 0.0267 0.9692 0.0598 1.7916 0.3718 2.4666 0.9397 0.7088 0.5797 1.1233 1.3192 1.2397 2.2191 0.037 0.0944 0.0527 0.1711 0.0527 0.2286v8.4293c0 0.4264-0.2108 0.6383-0.6363 0.6383h-0.6023c-0.4276 0-0.6415-0.2119-0.6415-0.6383v-0.0538c-0.8023 0.5926-1.7081 0.89-2.7143 0.89h-0.0169z"/>
    <path d="m381.47 225.73v8.3554c0 0.4267-0.2128 0.6395-0.6384 0.6395h-0.6045c-0.4244 0-0.6372-0.2128-0.6372-0.6395v-8.0891c0-0.7226-0.2497-1.3432-0.7469-1.8632-0.518-0.5228-1.1233-0.7993-1.8085-0.8342h-0.3021c-0.8869 0.0459-1.6374 0.3897-2.2541 1.0281-0.6034 0.6026-0.9157 1.3562-0.9393 2.253v7.5054c0 0.4267-0.208 0.6395-0.6215 0.6395h-0.6214c-0.4137 0-0.6203-0.2128-0.6203-0.6395v-11.212c0-0.4287 0.2066-0.6395 0.6203-0.6395h0.6214c0.4135 0 0.6215 0.2108 0.6215 0.6395v0.0527c0.7564-0.5699 1.6146-0.87 2.572-0.905h1.563c0.0217 0.011 0.0406 0.0181 0.0516 0.0181h0.1432c0.0338 0 0.0586 4e-3 0.0696 0.0169h0.0885c0.0129 0 0.0248 7e-3 0.0369 0.0169h0.1062c0.011 0.0118 0.0288 0.0177 0.0539 0.0177h0.0346c0.0119 0.0141 0.0299 0.0189 0.0539 0.0189l0.0169 0.0181h0.0704c0.013 0 0.022 2e-3 0.0279 8e-3 6e-3 6e-3 0.013 9e-3 0.0268 9e-3 0.0228 0.0118 0.0409 0.0177 0.0527 0.0177h0.0358c0.0118 0.0121 0.0287 0.0181 0.0516 0.0181 0.0259 0 0.0369 7e-3 0.0369 0.0177 0.0239 0 0.0417 6e-3 0.0535 0.0189h0.035c0.011 0.011 0.0299 0.0169 0.0527 0.0169l0.0189 0.0169h0.0169c0.0248 0 0.0417 7e-3 0.0527 0.0189 0.0239 0 0.0417 4e-3 0.0547 0.0169 0.0109 0.0119 0.0239 0.0181 0.0346 0.0181 0.0121 0.0118 0.0299 0.0177 0.0539 0.0177 0.0109 0.011 0.0228 0.018 0.0357 0.018l0.0339 0.0158c0.0138 0 0.0236 7e-3 0.0366 0.0181 0.0121 0 0.0209 4e-3 0.0259 0.01 6e-3 7e-3 0.015 0.011 0.026 0.011 0.0118 0.01 0.0248 0.0158 0.0366 0.0158 0.0121 0.013 0.0299 0.018 0.0538 0.018 0 0.0119 0.01 0.0158 0.0347 0.0158l0.0169 0.0189c0.013 0 0.0248 7e-3 0.0358 0.0189 0.013 0.0118 0.0228 0.0169 0.0378 0.0169 0.0219 0.013 0.0397 0.0189 0.0507 0.0189l0.0189 0.0169c0 0.0239 0.016 0.0349 0.0546 0.0349v0.0189h0.015l0.0189 0.0158c0.0121 0 0.0228 7e-3 0.0358 0.02 0.1183 0.0586 0.2198 0.1223 0.3012 0.1939 0.024 0.0237 0.0468 0.0417 0.0716 0.0547 0.022 0.0107 0.0477 0.0287 0.0716 0.0527v0.0166h0.0161c0 0.0251 0.0177 0.0369 0.0535 0.0369l0.0181 0.017 0.0535 0.0515v0.0189h0.0161c0 0.024 0.0127 0.0358 0.0366 0.0358l0.0169 0.0169 0.0538 0.0547h0.0178c0 0.0349 0.0189 0.0527 0.0527 0.0527l0.02 0.0169c0 0.0141 9e-3 0.031 0.0347 0.0547l0.018 0.016 0.0527 0.0547v0.0178h0.0178c0 0.0349 0.011 0.0527 0.0346 0.0527l0.0181 0.0189c0.011 0.0109 0.0189 0.0231 0.0189 0.0349l0.0149 0.0169h0.0189c0.0129 0.011 0.0208 0.0248 0.0279 0.0378 4e-3 0.01 0.0138 0.022 0.0256 0.0338v0.0169c0.0122 0 0.0279 0.0178 0.0527 0.0547v0.0169c0.0251 0.0347 0.0468 0.0744 0.0736 0.1153 0.022 0.0428 0.0518 0.0746 0.0876 0.0983 0.2596 0.4267 0.4374 0.881 0.5319 1.3652v0.0178c0.0109 0.0141 0.016 0.0358 0.016 0.0696 0 0.0609 7e-3 0.0955 0.0209 0.1074v0.0896c0.01 0.01 0.0149 0.0487 0.0149 0.1054v0.0905z"/>
    <path d="m384.57 230.98c0.0231 0.7091 0.2765 1.3243 0.7638 1.8443 0.4721 0.5082 1.0766 0.7807 1.8094 0.8165h0.886c0.699-0.0358 1.3083-0.3143 1.8274-0.8334 0.5099-0.5098 0.7635-1.1304 0.7635-1.8632 0.013-0.4036 0.2258-0.6054 0.6392-0.6054h0.6026c0.4137 0 0.6285 0.2018 0.6383 0.6054v0.0538c-0.01 1.064-0.4075 1.9875-1.1882 2.7679-0.7457 0.7446-1.6563 1.1285-2.7332 1.1544h-1.9497c-1.0667-0.0259-1.9754-0.3988-2.734-1.1186-0.7568-0.7237-1.1525-1.6157-1.1883-2.6805v-4.6302c0.0122-1.2068 0.4496-2.242 1.3114-3.1058 0.8531-0.8511 1.8942-1.3066 3.125-1.3663h1.561c0.011 0.0121 0.0347 0.0189 0.0705 0.0189h0.1432c0.0228 0 0.0428 4e-3 0.0538 0.016h0.0893c0.0102 0 0.0181 4e-3 0.0251 9e-3 5e-3 5e-3 0.0158 9e-3 0.0268 9e-3h0.0535c0.0229 0 0.0398 7e-3 0.0527 0.018h0.035c0.0228 0 0.0406 6e-3 0.0535 0.0189h0.0539c0.0129 0.011 0.0208 0.0178 0.0358 0.0178h0.0527c0 0.011 0.0177 0.016 0.0527 0.016l0.0358 0.0189c0.0129 0 0.0197 2e-3 0.0267 8e-3 5e-3 6e-3 0.015 9e-3 0.026 9e-3h0.0527c0.0248 0 0.0425 7e-3 0.0546 0.0189 0.01 0.0118 0.0248 0.0189 0.0358 0.0189 0.01 0.01 0.0296 0.0169 0.0527 0.0169 0.0127 0.011 0.0217 0.0169 0.0367 0.0169 0.0208 0 0.0397 7e-3 0.0527 0.0178h0.0349c0.0248 0.025 0.0406 0.0349 0.0536 0.0349h0.0349c0.0248 0.0248 0.0406 0.0366 0.0536 0.0366 0.0118 0 0.0239 4e-3 0.0369 0.0161 0.01 0 0.0197 4e-3 0.0248 9e-3 5e-3 7e-3 0.0149 9e-3 0.0268 9e-3h0.0357c0 0.0239 0.0158 0.0369 0.0527 0.0369l0.0158 0.0169h0.02c0.0248 0.013 0.0398 0.0169 0.0516 0.0169 0.013 0 0.0259 7e-3 0.0358 0.0189 0 0.0248 0.0169 0.0358 0.0527 0.0358 0.013 0 0.0259 6e-3 0.0369 0.0177l0.0358 0.0181c0.0119 0.011 0.024 0.0158 0.0358 0.0158 0 0.027 0.0169 0.0377 0.0516 0.0377 0.013 0 0.0259 6e-3 0.0358 0.0161 0 0.0248 0.018 0.0358 0.0527 0.0358l0.018 0.0177c0.024 0.024 0.0429 0.037 0.0547 0.037 0.0118 0.0109 0.0248 0.0169 0.0358 0.0169 0-0.011 0.0169 0 0.0527 0.0346l0.0169 0.0181c0.013 0 0.0217 7e-3 0.0259 0.0188 7e-3 0.0119 0.0147 0.0178 0.0288 0.0178v0.0169h0.0177c0.011 0.013 0.0279 0.0228 0.0527 0.035l0.0181 0.0197 0.0527 0.0518h0.0177c0.035 0.0367 0.0598 0.0547 0.0708 0.0547v0.0169c0.0129 0.011 0.0236 0.0209 0.0366 0.0268 0.011 5e-3 0.024 0.0138 0.035 0.0248v0.0189h0.0177l0.0527 0.0527 0.0527 0.0538 0.0181 0.0178 0.0535 0.0527h0.0161c0.0267 0.0239 0.0425 0.0476 0.0555 0.0707 0.0121 0.0248 0.0279 0.0477 0.0527 0.0716h0.018c0.01 0.0228 0.0288 0.0476 0.0536 0.0724l0.016 0.0169c0.0119 0.0119 0.0257 0.0288 0.0367 0.0527 0.0121 0.0139 0.022 0.0229 0.0259 0.035 8e-3 0.0127 0.0158 0.0248 0.0259 0.0358h0.0198c0.0121 0.0107 0.02 0.0237 0.0248 0.0366 6e-3 0.013 0.016 0.0229 0.029 0.0338v0.0189c0 0.013 0.0158 0.0338 0.0516 0.0708 0 0.0107 0.0189 0.0358 0.0527 0.0716v0.0177l0.0558 0.0527v0.0169c0 0.013 0.0149 0.0378 0.0516 0.0725 0 0.0349 0.0109 0.0656 0.0369 0.0876 0.0236 0.0936 0.0346 0.1251 0.0346 0.0885h0.0169c0 0.024 0.0119 0.0457 0.035 0.0724 0.0127 0.0231 0.0256 0.0519 0.0378 0.0877 0.0107 0.0366 0.0276 0.0645 0.0527 0.0885 0 0.0366 0.0107 0.0645 0.0346 0.0885-0.0118-0.024-0.0138-0.031-9e-3 -0.0181 4e-3 0.0122 0.022 0.0479 0.0459 0.1066 9e-3 0.0138 0.017 0.0307 0.017 0.0546 0 0.0119 4e-3 0.0229 0.0177 0.0339 9e-3 0.0715 0.024 0.1381 0.0448 0.1939 0.015 0.0606 0.0299 0.1203 0.0448 0.1798 0.0209 0.0814 0.0406 0.153 0.0527 0.2128 0.0107 0.0597 0.0229 0.1172 0.0316 0.1769 0.013 0.024 0.0209 0.0775 0.0209 0.1601v0.1066c0 0.0476 6e-3 0.0884 0.016 0.1231v0.1779c-0.0208 0.3909-0.2367 0.5856-0.6383 0.5856h-0.6026c-0.4134 0-0.6262-0.1947-0.6392-0.5856v-0.017c0-0.7217-0.2497-1.342-0.7437-1.8631-0.522-0.522-1.1245-0.7982-1.8114-0.834h-0.3012c-0.8881 0.0457-1.6397 0.3906-2.2541 1.029-0.6026 0.6025-0.9166 1.3562-0.9397 2.2529v3.9223z"/>
    <path d="m398.86 223.3h-0.0558c-0.8729 0.0347-1.6256 0.3717-2.253 1.0121-0.6034 0.6036-0.9157 1.3601-0.9416 2.2698v2.0929h3.4085c0.7226-0.01 1.344-0.2773 1.8621-0.7973 0.523-0.5219 0.7803-1.1473 0.7803-1.8801 0-0.7229-0.2454-1.3432-0.7446-1.8632-0.5199-0.5231-1.1233-0.7995-1.8093-0.8342h-0.1581zm-1.2251 11.416c-0.0358-4e-3 -0.0843-0.0138-0.1412-0.0268-1.031-0.0578-1.9117-0.4605-2.6436-1.2051-0.7108-0.7099-1.0766-1.5969-1.1006-2.6616v-4.471c0.0705-1.1831 0.5369-2.1884 1.4019-3.0167 0.8728-0.8391 1.9049-1.2776 3.086-1.3123h1.3303l0.0188 0.0178v-0.0178c1.0879 0 2.0174 0.3898 2.7851 1.1713 0.7796 0.7686 1.1721 1.7032 1.1721 2.8037 0 1.0639-0.3847 1.9985-1.1552 2.8028-0.7677 0.7694-1.6913 1.1522-2.765 1.1522h-4.0139v0.8173c0.0259 0.7437 0.2934 1.3722 0.8004 1.8801 0.5578 0.5199 1.1891 0.7795 1.9001 0.7795 0.0237 0 0.0496 4e-3 0.0775 0.011 0.0299 6e-3 0.0705 0.013 0.1164 0.0259h3.1396c0.4149 0 0.6226 0.2086 0.6226 0.6212 0 0.4256-0.2077 0.6383-0.6226 0.6383h-3.938c-0.011 0-0.0349-4e-3 -0.0707-0.01z"/>
   </g>
   <g fill="none" stroke="#fff">
    <g stroke-width=".669">
     <path d="m183.04 141.4c0 32.265-26.509 58.412-59.206 58.412-32.7 0-59.212-26.147-59.212-58.412 0-32.259 26.512-58.409 59.212-58.409 32.697 0 59.206 26.15 59.206 58.409z"/>
     <path d="m176.84 141.4c0 32.265-23.736 58.412-53.008 58.412-29.275 0-53.01-26.147-53.01-58.412 0-32.259 23.735-58.409 53.01-58.409 29.272 0 53.008 26.15 53.008 58.409z"/>
     <path d="m167.4 141.4c0 32.265-19.447 58.412-43.437 58.412-23.996 0-43.442-26.147-43.442-58.412 0-32.259 19.446-58.409 43.442-58.409 23.99 0 43.437 26.15 43.437 58.409z"/>
     <path d="m155.27 141.4c0 32.265-13.939 58.412-31.131 58.412-17.193 0-31.134-26.147-31.134-58.412 0-32.259 13.941-58.409 31.134-58.409 17.192 0 31.131 26.15 31.131 58.409z"/>
     <path d="m139.91 141.4c0 32.265-7.3626 58.412-16.441 58.412-9.0796 0-16.439-26.147-16.439-58.412 0-32.259 7.3596-58.409 16.439-58.409 9.0787 0 16.441 26.15 16.441 58.409z"/>
     <path d="m88.697 190.08h68.735"/>
     <path d="m88.697 93.169h68.735"/>
     <path d="m88.697 93.169h68.735"/>
     <path d="m78.458 101.38h90.292"/>
     <path d="m78.458 181.61h90.292"/>
     <path d="m69.56 169.69h108.36"/>
     <path d="m69.56 113.56h108.36"/>
     <path d="m63.09 127.33h120.76"/>
     <path d="m63.09 156.45h120.76"/>
     <path d="m61.387 141.4h123.8"/>
     <path d="m123.47 82.991v116.89"/>
    </g>
    <path d="m185.41 140.61c0 33.524-27.658 60.692-61.777 60.692-34.121 0-61.779-27.167-61.779-60.692 0-33.518 27.658-60.688 61.779-60.688 34.119 0 61.777 27.17 61.777 60.688z" stroke-width="9.15"/>
   </g>
   <g fill-rule="evenodd">
    <path d="m93.809 96.132s0.5421 1.9882 2.9659 1.0647c2.4258-0.9317 5.2552-2.5208 5.2552 0.9235 0 3.4425-4.715 6.8857-2.1577 13.502 2.5663 6.6213 4.3135 11.252 5.3938 11.12 1.0793-0.1267 0.8101 0.1322 0-2.3812-0.8066-2.5189-2.8275-8.4755-0.8066-4.5008 2.0212 3.9702 3.9049 6.7553 4.3124 6.882 0.4018 0.1322 0.5334 2.7814 0.5334 3.5773 0 0.7924-1.2119 0.2644 3.9136 2.1178 5.1206 1.8534 6.4663 0.5296 7.9511 1.8534 1.4792 1.3246 0.5372 1.4576 2.0212 1.4576 1.4819 0 3.234-0.7948 4.714 1.3228 1.4859 2.1189 4.0443 4.9022 6.3325 4.6359 2.2971-0.2673 3.3744-0.4003 3.3744 0.657 0 1.0632-0.2702 4.1035-2.022 6.2192-1.755 2.1215-7.0091 0.662-2.9659 6.6297 4.0452 5.9529 4.5824 4.3639 4.5824 7.0142 0 2.6445 3.0985 2.9155 4.715 3.9702 1.6167 1.0565 1.2149 6.4864-0.2673 10.332-1.4848 3.8343-2.8275 7.4068-4.1748 7.9422-1.3533 0.5306-2.1558 1.0547-2.1558 2.6408 0 1.5964-0.6793 6.2294-1.353 7.5512-0.672 1.3201 1.7548 1.7222 2.4284 1.7222 0.6718 0 1.8867 0.3985 1.6176-1.7222-0.27-2.115-1.3473-1.1877 0.539-2.3794 1.884-1.2006 4.0395-1.332 4.176-3.0455 0.1337-1.7279 3.238-2.911 4.4469-3.0496 1.212-0.1314 6.0675-3.1743 10.111-6.749 4.0422-3.5802 3.0994-5.8273 5.3898-6.492 2.2901-0.657 5.1187-1.5842 6.0634-5.29 0.9446-3.7132 0.4018-3.4432 2.2903-5.0389 1.8875-1.5842 6.0642-5.4241 3.0983-7.8044-2.9618-2.3867-6.8735-3.0438-7.8181-4.7726-0.9353-1.7184-1.7457-3.704-5.1161-5.6904-3.3704-1.9875-5.257-1.3217-6.0652-3.1788-0.8093-1.8524-2.4295-2.6429-6.3345-2.6429-3.9097 0-4.1789-0.5333-5.2589-0.6618-1.0776-0.1341-1.4822-1.4558-3.3688 0.2615-1.8837 1.7241-0.4037 2.1188-3.5001 1.9866-3.1035-0.1314-5.7973-0.3947-5.7973-2.9099 0-2.5181 1.8856-3.9768-1.2111-3.8417-3.1013 0.1341-4.5834 1.1924-2.9659-1.7212 1.6157-2.9108 2.2904-4.2354 0.1346-3.7068-2.1566 0.5298-2.4257 3.1754-6.0672 2.383-3.6376-0.7959-4.0395-5.6922-2.1558-7.9441 1.8905-2.2479 12.806-2.7778 12.941-1.455 0.1345 1.3228 3.2331 6.2194 2.8302 3.4406-0.4072-2.7804-2.2938-4.8963 0-6.0898 2.2915-1.1906 2.4268-1.9854 2.693-3.5744 0.271-1.5882-0.4015-1.3209 2.0223-2.3822 2.4228-1.0613 3.2329-1.8534 3.2329-2.7823 0-0.9272 0.1346-0.795 1.7513-0.662 1.6231 0.1351 2.4265 1.0576 2.8313-0.6607 0.4045-1.7231 0.9457-1.8553 1.8885-1.8553s1.8845-1.0576 0.5372-1.0576c-1.3457 0-2.4257-0.133-2.8305-1.4595-0.4015-1.319-0.4015-2.3803-1.4819-2.3803-1.0773 0-3.9086-1.1924-1.8855-1.1924 2.0201 0 7.1426 1.8552 7.008 0.1322-0.1345-1.7213-3.9095-1.5854-1.6194-1.7213 2.2912-0.1322 5.1225 2.2537 5.1225 1.0584 0-1.1906-6.3344-5.8215-14.957-7.8082-8.6275-1.9856-37.467-2.2508-45.552 7.5438-0.2729 0.7951 0.6706 0.6621 0.6706 0.6621z" fill="#9c9e9f"/>
    <path d="m93.02 95.355s0.5418 1.9885 2.9659 1.065c2.4257-0.9317 5.2552-2.52 5.2552 0.9235 0 3.4422-4.7153 6.8855-2.1577 13.502 2.5651 6.6213 4.3132 11.252 5.3924 11.12 1.0803-0.1267 0.8104 0.1322 0-2.3812-0.8052-2.5189-2.8273-8.4757-0.8052-4.5 2.0212 3.9694 3.9049 6.7545 4.3113 6.8812 0.4018 0.1322 0.5345 2.7815 0.5345 3.5773 0 0.7921-1.2119 0.2652 3.9135 2.1178 5.1196 1.8534 6.4661 0.5296 7.9509 1.8534 1.4781 1.3246 0.5372 1.4587 2.0212 1.4587 1.4819 0 3.2332-0.795 4.7142 1.3217 1.4857 2.1186 4.0433 4.9019 6.3315 4.6357 2.2979-0.2671 3.3752-0.4003 3.3752 0.6573 0 1.0631-0.2699 4.1031-2.0231 6.2191-1.7539 2.1215-7.008 0.6618-2.9648 6.6297 4.0451 5.9529 4.5815 4.3639 4.5815 7.0132 0 2.6466 3.0986 2.9173 4.7151 3.972 1.6164 1.0557 1.2148 6.4846-0.2662 10.331-1.4849 3.8335-2.8287 7.4061-4.176 7.9433-1.3521 0.5306-2.1547 1.0536-2.1547 2.639 0 1.5974-0.6795 6.2312-1.3543 7.5532-0.6717 1.3199 1.7559 1.721 2.4298 1.721 0.6718 0 1.8864 0.3976 1.6175-1.721-0.2702-2.1159-1.3476-1.1887 0.5391-2.3803 1.8829-1.2009 4.0395-1.3331 4.1749-3.0448 0.1345-1.7286 3.2387-2.911 4.448-3.0514 1.2119-0.1304 6.0661-3.1736 10.109-6.749 4.0433-3.5791 3.1005-5.8262 5.3898-6.4899 2.2914-0.6573 5.1198-1.5853 6.0636-5.2911 0.9455-3.7124 0.4016-3.4424 2.2912-5.0388 1.8875-1.5843 6.0645-5.4244 3.0986-7.8045-2.9621-2.3867-6.8738-3.044-7.8184-4.7734-0.9361-1.7175-1.7465-3.7021-5.1169-5.6896-3.3696-1.9874-5.2571-1.322-6.0645-3.1791-0.809-1.8523-2.4295-2.6426-6.3344-2.6426-3.9097 0-4.1797-0.5333-5.26-0.6618-1.0763-0.1333-1.4811-1.456-3.3675 0.2615-1.8839 1.7241-0.4047 2.1186-3.5004 1.9864-3.1031-0.1311-5.798-0.3945-5.798-2.9097 0-2.5181 1.8864-3.9768-1.2111-3.8409-3.1005 0.133-4.5823 1.1914-2.9648-1.722 1.6145-2.911 2.2901-4.2356 0.1345-3.7068-2.1568 0.5296-2.426 3.1751-6.0682 2.383-3.6377-0.7958-4.0395-5.6922-2.1558-7.9441 1.8904-2.2471 12.806-2.7777 12.941-1.455 0.1346 1.3228 3.2332 6.2192 2.8314 3.4406-0.4086-2.7806-2.2942-4.8963 0-6.0898 2.2911-1.1898 2.4257-1.9856 2.693-3.5736 0.271-1.589-0.4019-1.322 2.0212-2.383 2.4228-1.0613 3.2329-1.8534 3.2329-2.7825 0-0.927 0.1356-0.795 1.7521-0.6618 1.6223 0.1349 2.4268 1.0576 2.8313-0.6599 0.4048-1.7241 0.9446-1.8563 1.8885-1.8563 0.9428 0 1.8837-1.0574 0.5372-1.0574-1.3454 0-2.4257-0.1332-2.8302-1.4597-0.4019-1.3191-0.4019-2.3801-1.4822-2.3801-1.0773 0-3.9087-1.1924-1.8864-1.1924 2.021 0 7.1435 1.8552 7.0092 0.1322-0.1346-1.7205-3.9108-1.5846-1.6194-1.7205 2.2912-0.1329 5.1214 2.2538 5.1214 1.0576 0-1.1905-6.3333-5.8217-14.956-7.8081-8.6278-1.9856-37.467-2.25-45.553 7.5437-0.2719 0.7951 0.672 0.6618 0.672 0.6618z" fill="#fff"/>
    <path d="m92.835 93.394s0.5421 1.9874 2.9659 1.0641c2.4258-0.9319 5.2552-2.5199 5.2552 0.9233 0 3.4425-4.715 6.8867-2.1577 13.503 2.5652 6.6213 4.3135 11.252 5.3935 11.12 1.0793-0.1266 0.8104 0.1322 0-2.3811-0.8063-2.5189-2.8283-8.4758-0.8063-4.5008 2.0212 3.9701 3.9049 6.7553 4.3116 6.8819 0.4015 0.1322 0.5342 2.7815 0.5342 3.5773 0 0.7921-1.2119 0.2644 3.9136 2.1178 5.1195 1.8524 6.466 0.5296 7.9508 1.8524 1.4792 1.3257 0.5375 1.4587 2.0212 1.4587 1.4822 0 3.2332-0.7951 4.7143 1.3227 1.4856 2.1187 4.0432 4.9012 6.3325 4.6349 2.2968-0.2662 3.3742-0.3995 3.3742 0.6581 0 1.0631-0.27 4.1032-2.0229 6.2191-1.7539 2.1216-7.0083 0.6618-2.9651 6.6298 4.0452 5.9521 4.5816 4.363 4.5816 7.0131 0 2.6455 3.0994 2.9173 4.715 3.972 1.6167 1.0558 1.2149 6.4846-0.2662 10.331-1.4848 3.8333-2.8284 7.4061-4.1749 7.943-1.3532 0.5296-2.1558 1.0537-2.1558 2.639 0 1.5964-0.6795 6.2313-1.354 7.5533-0.6709 1.3198 1.7559 1.7212 2.4295 1.7212 0.6718 0 1.8867 0.3974 1.6175-1.7212-0.2702-2.1168-1.3475-1.1898 0.5391-2.3812 1.8829-1.2001 4.0395-1.3323 4.176-3.0451 0.1335-1.7275 3.2377-2.9099 4.4469-3.0503 1.212-0.1303 6.0672-3.1733 10.11-6.749 4.0425-3.5791 3.0997-5.8262 5.389-6.4909 2.2911-0.657 5.1195-1.5853 6.0634-5.2901 0.9457-3.7123 0.4018-3.4432 2.2911-5.0388 1.8878-1.5843 6.0645-5.4241 3.0986-7.8053-2.9621-2.3859-6.8735-3.0432-7.8184-4.7726-0.9353-1.7186-1.7462-3.7031-5.1158-5.6895-3.3704-1.9875-5.2581-1.322-6.0653-3.1791-0.8093-1.8524-2.4297-2.6427-6.3347-2.6427-3.9094 0-4.1797-0.5333-5.2597-0.6618-1.0766-0.134-1.4811-1.456-3.3677 0.2607-1.8837 1.7249-0.4037 2.1194-3.5004 1.9872-3.1032-0.1311-5.7972-0.3955-5.7972-2.9107 0-2.5171 1.8858-3.9757-1.2109-3.8409-3.1015 0.1333-4.5834 1.1916-2.9659-1.721 1.6146-2.911 2.2904-4.2356 0.1346-3.7068-2.1566 0.5296-2.4258 3.1751-6.0672 2.383-3.6387-0.7958-4.0406-5.6922-2.1569-7.9448 1.8905-2.2474 12.806-2.777 12.941-1.4542 0.1356 1.3228 3.2339 6.2191 2.8313 3.4406-0.4083-2.7815-2.2941-4.8964 0-6.0899 2.2912-1.1906 2.4257-1.9856 2.693-3.5746 0.271-1.588-0.4018-1.3209 2.022-2.382 2.4231-1.0612 3.2324-1.8534 3.2324-2.7833 0-0.9261 0.1353-0.7939 1.7521-0.661 1.6231 0.1351 2.4265 1.0576 2.8313-0.6609 0.4045-1.7231 0.9455-1.8553 1.8882-1.8553 0.9431 0 1.8848-1.0573 0.5375-1.0573-1.3457 0-2.4257-0.1341-2.8305-1.4598-0.4018-1.3198-0.4018-2.3801-1.4819-2.3801-1.0773 0-3.9087-1.1934-1.8866-1.1934 2.0212 0 7.1437 1.8552 7.0091 0.1332-0.1346-1.7212-3.9105-1.5853-1.6194-1.7212 2.2912-0.1322 5.1225 2.2537 5.1225 1.0584 0-1.1906-6.3344-5.8218-14.957-7.8082-8.6275-1.9856-37.467-2.2508-45.552 7.5438-0.2729 0.794 0.6709 0.6618 0.6709 0.6618z" fill="#fff"/>
    <path d="m140.52 125.07c0.1136-0.3827-1.8829-0.1349-3.5034-0.927-1.6164-0.7932-3.3704-2.3841-5.7931-1.8545-2.4279 0.5288-3.1024 1.9867-1.0774 1.9867 2.021 0 1.7491-1.3265 3.902 0 0 0 5.9326 2.6455 6.4719 0.7948z" fill="#9c9e9f"/>
    <path d="m140.11 124.67c0.1136-0.3836-1.8829-0.1351-3.5023-0.9283-1.6175-0.7929-3.3714-2.3838-5.7942-1.8531-2.4268 0.5277-3.1024 1.9864-1.0777 1.9864 2.0213 0 1.7494-1.3265 3.9023 0 0 0 5.9326 2.6455 6.4719 0.795z" fill="#fff"/>
    <path d="m140.31 124.87c0.1136-0.3837-1.8829-0.1351-3.5034-0.9283-1.6164-0.793-3.3704-2.3838-5.7932-1.8532-2.4268 0.5277-3.1023 1.9864-1.0776 1.9864 2.0212 0 1.7494-1.3265 3.9022 0 0 0 5.9326 2.6456 6.472 0.7951z" fill="#fff"/>
    <path d="m137.56 126s-0.6747 1.4565 0.27 1.4565c0.9439 0 1.884-0.1311 3.2294 0 1.3494 0.1333 7.5522 1.7223 6.7429 0.2637-0.8101-1.455-1.7539-0.2637-3.1015-1.455-1.3492-1.1906-2.292-2.2545-3.0975-1.0566-0.8112 1.1896-2.6968 2.5116-4.0433 0.7914z" fill="#9c9e9f"/>
    <path d="m137.15 125.6s-0.6748 1.4568 0.2699 1.4568c0.9439 0 1.884-0.1312 3.2294 0 1.3494 0.1332 7.552 1.7223 6.743 0.2636-0.8104-1.455-1.754-0.2636-3.1016-1.455-1.3492-1.1898-2.292-2.2545-3.0975-1.0565-0.8112 1.1895-2.6967 2.5115-4.0432 0.7911z" fill="#fff"/>
    <path d="m137.35 125.8s-0.6747 1.4568 0.2699 1.4568c0.9439 0 1.884-0.1311 3.2294 0 1.3495 0.1333 7.552 1.7223 6.743 0.2636-0.8101-1.455-1.754-0.2636-3.1015-1.455-1.3492-1.1897-2.292-2.2545-3.0984-1.0565-0.8103 1.1895-2.6959 2.5115-4.0424 0.7911z" fill="#fff"/>
   </g>
   <g fill="#fff" fill-rule="evenodd">
    <path d="m312.92 186.08c0.9879 0.0879 1.8403 0.5005 2.5563 1.2414 0.7124 0.7127 1.1206 1.5718 1.2209 2.5732h-0.0393 0.0393c-0.0754 1.0778-0.513 1.9596-1.3146 2.6484-0.8016 0.6913-1.7489 1.0339-2.8379 1.0339h-0.0757c-0.0125 0-0.0259 5e-3 -0.0371 9e-3 -0.0134 7e-3 -0.0259 0.0112-0.0396 0.0112h-5.3916c-0.4513 0-0.6767-0.2257-0.6767-0.6776 0-0.451 0.2254-0.6754 0.6767-0.6754h5.0355c0.6901-0.0374 1.2865-0.264 1.796-0.6766 0.5075-0.4126 0.7984-0.9652 0.8728-1.6553-0.1003-0.6753-0.3857-1.2427-0.8559-1.6991-0.4689-0.458-1.0429-0.7172-1.7183-0.7805l-3.1197-0.3381v-0.0179c-0.7511-0.0272-1.3837-0.3011-1.8979-0.8278-0.5018-0.5265-0.7646-1.158-0.7892-1.8976v-0.0946c0.0246-1.1142 0.4318-2.0363 1.221-2.7615 0.8019-0.7271 1.7591-1.1037 2.8743-1.1276h4.2666c0.4375 0 0.6584 0.2243 0.6584 0.6766 0 0.4385-0.2209 0.6575-0.6584 0.6575h-3.6644c-0.7636 0.0361-1.3961 0.2873-1.8979 0.7507-0.5399 0.4772-0.8141 1.0781-0.8266 1.8043h0.0183c0 0.3899 0.1284 0.7204 0.3854 0.9978 0.256 0.2752 0.574 0.4296 0.9506 0.4679l0.0936 0.0192h0.0374z"/>
    <path d="m321.67 176.38c0.6143 0 0.9211 0.3132 0.9211 0.939 0 0.6134-0.3068 0.9202-0.9211 0.9202h-0.6575c-0.6133 0-0.9211-0.3068-0.9211-0.9202 0-0.6258 0.3078-0.939 0.9211-0.939zm0.2614 4.4897c0.4408 0 0.6597 0.2256 0.6597 0.6788v11.874c0 0.4523-0.2189 0.6776-0.6597 0.6776h-0.6574c-0.4497 0-0.6754-0.2253-0.6754-0.6776v-11.2h-2.1807c-0.4497 0-0.6754-0.2256-0.6754-0.6744 0-0.4532 0.2257-0.6788 0.6754-0.6788h3.4966z"/>
    <path d="m331.98 186.81c0.9876 0.0879 1.8413 0.5005 2.556 1.2401 0.7127 0.7128 1.1209 1.5719 1.2222 2.5742h-0.0406 0.0406c-0.0755 1.0781-0.514 1.9596-1.3156 2.6487-0.8019 0.691-1.7489 1.0327-2.8382 1.0327h-0.0754c-0.0125 0-0.0249 4e-3 -0.0374 0.0102-0.0134 7e-3 -0.0246 0.0102-0.0383 0.0102h-5.393c-0.4509 0-0.6766-0.2256-0.6766-0.6776 0-0.4513 0.2257-0.6756 0.6766-0.6756h5.0369c0.6901-0.0371 1.2852-0.2628 1.795-0.6754 0.5072-0.4126 0.7984-0.9649 0.8725-1.6562-0.0991-0.6754-0.3854-1.2414-0.8546-1.6982-0.4702-0.4589-1.0429-0.7182-1.7183-0.7802l-3.1211-0.3394v-0.0169c-0.7507-0.0269-1.3836-0.3021-1.8966-0.8288-0.5018-0.5255-0.7642-1.158-0.7904-1.8963v-0.0949c0.0262-1.1152 0.4331-2.0363 1.2213-2.7625 0.8016-0.7261 1.7601-1.1026 2.8753-1.1263h4.2665c0.4376 0 0.6575 0.2231 0.6575 0.6766 0 0.4385-0.2199 0.6572-0.6575 0.6572h-3.6657c-0.7632 0.0361-1.3957 0.2863-1.8966 0.7511-0.5411 0.4756-0.815 1.0777-0.8275 1.8039h0.0192c0 0.389 0.1275 0.7204 0.3855 0.9978 0.256 0.2743 0.573 0.4296 0.9496 0.4679l0.0936 0.0192h0.0371z"/>
    <path d="m343.62 194.18h-0.0374c-0.0134 0-0.0313-7e-3 -0.0572-0.0202-1.0646-0.0124-2.0104-0.3742-2.8382-1.087-0.7757-0.691-1.195-1.5942-1.2593-2.7084-0.0124-0.0237-0.0169-0.0754-0.0169-0.1486v-7.9313h-2.1999c-0.451 0-0.6767-0.2174-0.6767-0.6572 0-0.4522 0.2257-0.6766 0.6767-0.6766h2.1999v-2.4604c0-0.4532 0.2253-0.6798 0.6763-0.6798h0.6565c0.4385 0 0.6584 0.2266 0.6584 0.6798v2.4604h3.4954c0.4375 0 0.6584 0.2244 0.6584 0.6766 0 0.4398-0.2209 0.6572-0.6584 0.6572h-3.4954v7.8929h0.0192v0.0179c0 0.7521 0.256 1.3747 0.77 1.8627 0.5526 0.4737 1.1829 0.732 1.8975 0.769h2.199c0.451 0 0.6763 0.2244 0.6763 0.6754 0 0.4522-0.2253 0.6776-0.6763 0.6776z"/>
    <path d="m353.15 182.13h-0.0585c-0.9247 0.037-1.7231 0.3947-2.3872 1.071-0.638 0.6405-0.9694 1.4421-0.9966 2.4051v2.2169h3.6091c0.7658-0.0115 1.4229-0.2944 1.9721-0.8457 0.5535-0.5504 0.8278-1.2133 0.8278-1.9912 0-0.7646-0.2618-1.423-0.7882-1.9734-0.5526-0.5523-1.1909-0.8457-1.918-0.8827h-0.1669zm-1.2967 12.092c-0.0393-6e-3 -0.0901-0.016-0.1499-0.0294-1.0925-0.0597-2.0251-0.4871-2.8008-1.2762-0.7534-0.7534-1.1401-1.6927-1.1647-2.819v-4.7345c0.0745-1.2539 0.5692-2.3182 1.4837-3.1956 0.9246-0.8895 2.0174-1.3529 3.2687-1.39h1.4095l0.0214 0.0179v-0.0179c1.1513 0 2.1344 0.4136 2.9485 1.2392 0.8256 0.815 1.2404 1.8052 1.2404 2.9699 0 1.1263-0.4072 2.1161-1.2235 2.9686-0.8128 0.8153-1.7905 1.2212-2.928 1.2212h-4.2509v0.8649c0.0272 0.7882 0.3113 1.4546 0.8467 1.9912 0.5909 0.5514 1.2596 0.8275 2.0126 0.8275 0.0249 0 0.053 4e-3 0.0834 9e-3 0.0294 7e-3 0.0735 0.0147 0.1218 0.0284h3.3253c0.4398 0 0.6597 0.2199 0.6597 0.6571 0 0.451-0.2199 0.6767-0.6597 0.6767h-4.1697c-0.0125 0-0.0371-4e-3 -0.0745-9e-3z"/>
    <path d="m387.31 191.3c0.6383-0.6396 0.9697-1.4479 0.9956-2.4256v-2.1795h-3.908c-0.715 0.1004-1.3101 0.4126-1.786 0.9403-0.4769 0.5491-0.7137 1.1817-0.7137 1.8966 0 0.7521 0.257 1.4038 0.77 1.9564 0.5513 0.5491 1.1896 0.8444 1.9167 0.8815h0.396c0.9132-0.0495 1.6902-0.4068 2.3294-1.0697zm-1.9733 2.4239h-1.2222c-1.1273 0-2.1175-0.4068-2.9699-1.2222-0.8141-0.8511-1.22-1.8413-1.22-2.9699 0-1.1646 0.4014-2.1491 1.203-2.9497 0.8131-0.8141 1.7963-1.2324 2.9498-1.2593h4.2282v-1.0509c-0.0259-0.7917-0.3136-1.4162-0.8649-1.8784-0.5513-0.4893-1.2155-0.7351-1.9922-0.7351-0.0249 0-0.0495-3e-3 -0.0744-9e-3 -0.0259-5e-3 -0.0633-0.0147-0.1116-0.0268h-3.3285c-0.45 0-0.6753-0.2257-0.6753-0.6789 0-0.4363 0.2253-0.6562 0.6753-0.6562h4.1739c0.024 0 0.0521 2e-3 0.0837 9e-3 0.0314 7e-3 0.071 0.0156 0.1218 0.0294 1.0269 0.0607 1.8985 0.3934 2.6113 0.9934 0.753 0.6155 1.1896 1.398 1.3159 2.3507 0.037 0.1004 0.0562 0.1816 0.0562 0.2426v8.9266c0 0.4523-0.2253 0.6776-0.6741 0.6776h-0.6427c-0.4488 0-0.6744-0.2253-0.6744-0.6776v-0.0562c-0.8534 0.628-1.8106 0.9412-2.8753 0.9412h-0.0192z"/>
    <path d="m399.01 186.16c0.9889 0.0879 1.8413 0.5006 2.5563 1.2402 0.7124 0.7127 1.1206 1.5718 1.2222 2.5742h-0.0396 0.0396c-0.0757 1.078-0.5143 1.9599-1.3149 2.6486-0.8016 0.6914-1.7499 1.033-2.8379 1.033h-0.0767c-0.0112 0-0.0249 5e-3 -0.0371 0.01-0.0137 7e-3 -0.0249 0.0103-0.0383 0.0103h-5.3932c-0.451 0-0.6754-0.2254-0.6754-0.6776 0-0.451 0.2244-0.6754 0.6754-0.6754h5.0368c0.6901-0.0374 1.2865-0.264 1.795-0.6753 0.5075-0.413 0.7984-0.9653 0.8738-1.6566-0.1003-0.6754-0.3854-1.2414-0.8559-1.6981-0.4702-0.4587-1.0429-0.7182-1.7183-0.7802l-3.1198-0.3394v-0.017c-0.752-0.0268-1.3845-0.302-1.8975-0.8284-0.5018-0.5255-0.7646-1.158-0.7895-1.8979v-0.0937c0.0249-1.1148 0.4318-2.0363 1.22-2.7624 0.8016-0.7259 1.7601-1.1027 2.8753-1.1264h4.2665c0.4376 0 0.6575 0.2235 0.6575 0.6767 0 0.4385-0.2199 0.6574-0.6575 0.6574h-3.6644c-0.7635 0.0358-1.3961 0.2864-1.8975 0.7508-0.5402 0.4759-0.8154 1.0781-0.8266 1.8039h0.0179c0 0.3893 0.1285 0.7208 0.3858 0.9969 0.2557 0.2752 0.5737 0.4296 0.9493 0.4692l0.0936 0.0192h0.0371z"/>
    <path d="m370.15 184.68v8.8512c0 0.451-0.2244 0.6753-0.6767 0.6753h-0.6379c-0.45 0-0.6767-0.2243-0.6767-0.6753v-8.5693c0-0.7645-0.2636-1.4216-0.7891-1.973-0.5504-0.5526-1.1896-0.8457-1.9171-0.8831h-0.3189c-0.9394 0.0496-1.7352 0.4139-2.3869 1.0893-0.6383 0.6382-0.971 1.4363-0.9947 2.3869v7.9492c0 0.451-0.2208 0.6753-0.6597 0.6753h-0.6561c-0.4398 0-0.6594-0.2243-0.6594-0.6753v-11.876c0-0.4519 0.2196-0.6766 0.6594-0.6766h0.6561c0.4389 0 0.6597 0.2247 0.6597 0.6766v0.0566c0.7994-0.6022 1.7093-0.9215 2.7241-0.9585h1.6544c0.0236 0.0124 0.0428 0.0179 0.0549 0.0179h0.1502c0.0371 0 0.063 6e-3 0.0755 0.0191h0.0936c0.0125 0 0.0246 7e-3 0.0371 0.0183h0.1128c0.0134 0.0124 0.0317 0.0179 0.0576 0.0179h0.037c0.0125 0.0147 0.0317 0.0214 0.0566 0.0214l0.0179 0.0182h0.0745c0.0134 0 0.0249 2e-3 0.0303 9e-3 5e-3 7e-3 0.0138 9e-3 0.0272 9e-3 0.0249 0.0134 0.0438 0.0192 0.0563 0.0192h0.0374c0.0134 0.0112 0.0326 0.0182 0.0575 0.0182 0.0236 0 0.0361 8e-3 0.0361 0.0201 0.0246 0 0.0451 6e-3 0.0572 0.0182h0.0374c0.0112 0.0122 0.0316 0.0189 0.0575 0.0189l0.017 0.0169h0.0192c0.0246 0 0.045 7e-3 0.0575 0.0205 0.0236 0 0.0438 6e-3 0.055 0.0192 0.0124 0.0112 0.0262 0.0192 0.0396 0.0192 0.0112 0.0124 0.0304 0.0191 0.0562 0.0191 0.0103 0.0112 0.0237 0.017 0.0362 0.017l0.0374 0.0191c0.0143 0 0.0246 7e-3 0.0383 0.0192 0.0112 0 0.0224 3e-3 0.0291 9e-3 3e-3 7e-3 0.0147 0.0102 0.0272 0.0102 0.0124 0.0121 0.0249 0.0192 0.037 0.0192 0.0138 0.0134 0.033 0.0169 0.0576 0.0169 0 0.0134 0.0124 0.0192 0.0374 0.0192l0.0179 0.0189c0.0134 0 0.0259 6e-3 0.0374 0.0191 0.0134 0.0138 0.0258 0.0192 0.037 0.0192 0.0259 0.0125 0.0451 0.0182 0.0576 0.0182l0.0191 0.0192c0 0.0237 0.0192 0.0371 0.0563 0.0371v0.0204h0.0182l0.0202 0.017c0.0111 0 0.0236 7e-3 0.0373 0.0201 0.1241 0.0633 0.2311 0.1298 0.319 0.2065 0.0237 0.0246 0.0486 0.0438 0.0745 0.0562 0.0259 0.0125 0.0495 0.0317 0.0754 0.0566v0.0179h0.0182c0 0.0259 0.0202 0.0384 0.0563 0.0384l0.0201 0.0191 0.0566 0.0531v0.0214h0.0169c0 0.0237 0.0125 0.0384 0.0384 0.0384l0.0192 0.0179 0.0562 0.0575h0.0182c0 0.0361 0.0192 0.054 0.0563 0.054l0.0192 0.0192c0 0.0147 0.0134 0.0316 0.037 0.0575l0.0205 0.017 0.054 0.0575v0.0204h0.0205c0 0.0358 0.0121 0.0563 0.0371 0.0563l0.0191 0.0179c0.0135 0.0125 0.0192 0.0262 0.0192 0.0374l0.0179 0.0179h0.0182c0.0125 0.0124 0.0214 0.0259 0.0304 0.0396 5e-3 0.0125 0.016 0.0237 0.0259 0.0361v0.0179c0.0137 0 0.0329 0.0192 0.0575 0.0576v0.0179c0.0259 0.0383 0.0495 0.0802 0.0758 0.123 0.0236 0.0451 0.0549 0.079 0.0933 0.1039 0.2765 0.4519 0.4647 0.9336 0.5651 1.4453v0.0192c0.0102 0.0147 0.0169 0.0396 0.0169 0.0744 0 0.0633 7e-3 0.1026 0.0201 0.1129v0.0946c0.0125 0.0124 0.017 0.0518 0.017 0.1138v0.0936z"/>
    <path d="m378.21 184.68v8.8512c0 0.451-0.2244 0.6753-0.6766 0.6753h-0.6383c-0.4497 0-0.6776-0.2243-0.6776-0.6753v-8.5693c0-0.7645-0.2627-1.4216-0.7882-1.973-0.55-0.5526-1.1896-0.8457-1.9167-0.8831h-0.319c-0.9393 0.0496-1.7355 0.4139-2.3872 1.0893-0.638 0.6382-0.9707 1.4363-0.9956 2.3869v7.9492c0 0.451-0.2209 0.6753-0.6584 0.6753h-0.6562c-0.4398 0-0.6597-0.2243-0.6597-0.6753v-11.876c0-0.4519 0.2199-0.6766 0.6597-0.6766h0.6562c0.4375 0 0.6584 0.2247 0.6584 0.6766v0.0566c0.8019-0.6022 1.7093-0.9215 2.7254-0.9585h1.654c0.0236 0.0124 0.0428 0.0179 0.0553 0.0179h0.1499c0.0374 0 0.0633 6e-3 0.0757 0.0191h0.0934c0.0124 0 0.0249 7e-3 0.0373 0.0183h0.1129c0.0134 0.0124 0.0313 0.0179 0.0575 0.0179h0.0371c0.0124 0.0147 0.0316 0.0214 0.0553 0.0214l0.0191 0.0182h0.0745c0.0134 0 0.0246 2e-3 0.0291 9e-3 6e-3 7e-3 0.0147 9e-3 0.0285 9e-3 0.0246 0.0134 0.0437 0.0192 0.0562 0.0192h0.0371c0.0137 0.0112 0.0329 0.0182 0.0575 0.0182 0.0237 0 0.0361 8e-3 0.0361 0.0201 0.025 0 0.0451 6e-3 0.0576 0.0182h0.0374c0.0111 0.0122 0.0313 0.0189 0.0572 0.0189l0.0169 0.0169h0.0192c0.0249 0 0.045 7e-3 0.0575 0.0205 0.0237 0 0.0441 6e-3 0.0553 0.0192 0.0125 0.0112 0.0259 0.0192 0.0396 0.0192 0.0112 0.0124 0.0304 0.0191 0.0563 0.0191 0.0102 0.0112 0.0236 0.017 0.0361 0.017l0.0371 0.0191c0.0147 0 0.0249 7e-3 0.0383 0.0192 0.0112 0 0.0227 3e-3 0.0294 9e-3 4e-3 7e-3 0.0147 0.0102 0.0259 0.0102 0.0135 0.0121 0.0259 0.0192 0.0384 0.0192 0.0125 0.0134 0.0326 0.0169 0.0562 0.0169 0 0.0134 0.0138 0.0192 0.0384 0.0192l0.0182 0.0189c0.0134 0 0.0259 6e-3 0.0371 0.0191 0.0137 0.0138 0.0259 0.0192 0.0374 0.0192 0.0259 0.0125 0.045 0.0182 0.0575 0.0182l0.0192 0.0192c0 0.0237 0.0188 0.0371 0.0562 0.0371v0.0204h0.0179l0.0205 0.017c0.0102 0 0.0236 7e-3 0.0371 0.0201 0.124 0.0633 0.2311 0.1298 0.3193 0.2065 0.0236 0.0246 0.0495 0.0438 0.0741 0.0562 0.025 0.0125 0.0499 0.0317 0.0758 0.0566v0.0179h0.0179c0 0.0259 0.0204 0.0384 0.0565 0.0384l0.0192 0.0191 0.0575 0.0531v0.0214h0.0167c0 0.0237 0.0124 0.0384 0.0383 0.0384l0.0192 0.0179 0.0566 0.0575h0.0179c0 0.0361 0.0191 0.054 0.0565 0.054l0.0192 0.0192c0 0.0147 0.0134 0.0316 0.0371 0.0575l0.0201 0.017 0.0544 0.0575v0.0204h0.0201c0 0.0358 0.0125 0.0563 0.0374 0.0563l0.0192 0.0179c0.0134 0.0125 0.0192 0.0262 0.0192 0.0374l0.0179 0.0179h0.0182c0.0121 0.0124 0.0214 0.0259 0.0303 0.0396 5e-3 0.0125 0.0157 0.0237 0.0259 0.0361v0.0179c0.0134 0 0.0326 0.0192 0.0576 0.0576v0.0179c0.0246 0.0383 0.0495 0.0802 0.0754 0.123 0.0236 0.0451 0.0553 0.079 0.0936 0.1039 0.2762 0.4519 0.4644 0.9336 0.5648 1.4453v0.0192c0.0102 0.0147 0.0169 0.0396 0.0169 0.0744 0 0.0633 7e-3 0.1026 0.0205 0.1129v0.0946c0.0112 0.0124 0.0169 0.0518 0.0169 0.1138v0.0936z"/>
   </g>
   <path d="m263.33 181.79h30.526c2.5531 0 4.642 2.088 4.642 4.64v8e-4c0 2.5521-2.0889 4.6401-4.642 4.6401h-30.526c-2.5529 0-4.6409-2.088-4.6409-4.6401v-8e-4c0-2.552 2.088-4.64 4.6409-4.64z" fill="#fff" fill-rule="evenodd"/>
  </g>
 </g>
</svg>
""",
                ),
                // child: xmlDocument == null
                //     ? PrimaryButton(
                //         label: "Pegar XML",
                //         onTap: () async {
                //           FilePickerResult? result =
                //               await FilePicker.platform.pickFiles();

                //           if (result != null) {
                //             File file = File(result.files.single.path!);
                //             xmlDocument = await file.readAsString();
                //             setState(() {});
                //           } else {
                //             // User canceled the picker
                //           }
                //         },
                //       )
                //     : ,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Observations extends StatelessWidget {
  const Observations({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 15),
      child: Observation(
        label: "Observação",
        height: maxHeight(context) - 250,
      ),
    );
  }
}

class Conditions extends StatelessWidget {
  const Conditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        vSpace(15),
        Row(
          children: [
            hSpace(10),
            SecondaryButton(
              label: "Inserir Pagamentos",
              icon: "insert_payment",
              width: (maxWidth(context) - 30) / 2,
              onTap: () {},
            ),
            hSpace(10),
            SecondaryButton(
              label: "Exibir Condições",
              icon: "calculator",
              width: (maxWidth(context) - 30) / 2,
              onTap: () {},
            ),
            hSpace(10),
          ],
        ),
        const CustomCheck(
          text: "Preação = Entrada",
          checked: true,
        ),
      ],
    );
  }
}

class Historic extends StatelessWidget {
  const Historic({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        vSpace(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DefaultTextField(
              label: "Data Entrada",
              width: splitWidth(context, 2),
            ),
            SecondaryButton(
              label: "Agendar Ligação",
              icon: "schedule",
              onTap: () {},
              width: splitWidth(context, 2),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SecondaryButton(
              label: "Inserir Histórico",
              icon: "description",
              onTap: () {},
              width: splitWidth(context, 2),
            ),
            SecondaryButton(
              label: "Exibir Condições",
              icon: "list",
              onTap: () {},
              width: splitWidth(context, 2),
            ),
          ],
        ),
        const Historical(),
        vSpace(10),
      ],
    );
  }
}

class Historical extends StatelessWidget {
  const Historical({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: maxWidth(context) - 20,
        height: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: getColors(context).onPrimaryContainer),
          borderRadius: BorderRadius.circular(14),
          color: getColors(context).surface,
        ),
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 36,
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(14)),
                color: getColors(context).primary,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Usuário",
                        style: getStyles(context).labelMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 36,
                    color: getColors(context).onPrimary,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Data/Hora",
                        style: getStyles(context).labelMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 5),
                child: Column(
                  children: const [
                    HistoricTile(),
                    HistoricTile(),
                    HistoricTile(),
                    HistoricTile(),
                    HistoricTile(),
                    HistoricTile(),
                    HistoricTile(),
                    HistoricTile(),
                    HistoricTile(),
                    HistoricTile(),
                    HistoricTile(),
                    HistoricTile(),
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

class HistoricTile extends StatefulWidget {
  const HistoricTile({Key? key}) : super(key: key);

  @override
  State<HistoricTile> createState() => _Historicaltate();
}

class _Historicaltate extends State<HistoricTile> {
  @override
  Widget build(BuildContext context) {
    // debugDumpApp();
    return CustomCard(
      width: maxWidth(context) - 40,
      height: 36,
      radius: 11,
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(11),
        child: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Nome do Usuário",
                  style: getStyles(context).labelMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: getColors(context).onSurface,
                      ),
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
            Container(
              width: 1,
              height: 36,
              color: getColors(context).onPrimaryContainer,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Preto",
                  style: getStyles(context).labelMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: getColors(context).onSurface,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Expenses extends StatelessWidget {
  const Expenses({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const DefaultTitle(title: "Opções do Pedido", top: 15),
          const DefaultTextField(label: "Nota Fiscal"),
          const DefaultTextField(
            label: "Despesa",
            dropDown: true,
            dropDownOptions: [],
            isBlue: true,
          ),
          const DefaultTextField(
            label: "Loja",
            dropDown: true,
            dropDownOptions: [],
            isBlue: true,
          ),
          const DefaultTextField(label: "Histórico"),
          const DefaultTextField(label: "Pago à"),
          const DefaultTextField(label: "Valor"),
          SecondaryButton(
            label: "Inserir despesa",
            icon: "insert_payment",
            onTap: () {},
          ),
          SecondaryButton(
            label: "Consultar Despesa",
            icon: "search_blue",
            onTap: () {},
          ),
          SecondaryButton(
            label: "Excluir Despesa",
            icon: "cancel",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class OtherOptions extends StatelessWidget {
  const OtherOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const DefaultTitle(title: "Opções do Pedido", top: 15),
          SecondaryButton(
            label: "Excluir Orçamento",
            icon: "delete",
            onTap: () {},
          ),
          SecondaryButton(
            label: "Cancelar Venda",
            icon: "cancel",
            onTap: () {},
          ),
          SecondaryButton(
            label: "Estornar Venda",
            icon: "refund",
            onTap: () {},
          ),
          const DefaultTitle(title: "Opções Financeiras"),
          SecondaryButton(
            label: "Exibir Lucros Detalhados",
            icon: "profit",
            onTap: () {},
          ),
          SecondaryButton(
            label: "Exibir Lucro Bruto",
            icon: "profit",
            onTap: () {},
          ),
          SecondaryButton(
            label: "Exibir Cálculos Prod.",
            icon: "calculator",
            onTap: () {},
          ),
          const DefaultTitle(title: "Opções Fiscais"),
          SecondaryButton(
            label: "Cancelar NFC-e",
            icon: "cancel",
            onTap: () {},
          ),
          const DefaultTitle(title: "Outras Opções"),
          SecondaryButton(
            label: "Exibir Recebimento de Caixa",
            icon: "cash_receivement",
            onTap: () {},
          ),
          SecondaryButton(
            label: "Copiar Itens do Pedido",
            icon: "copy",
            onTap: () {},
          ),
          const DefaultTitle(title: "Log de Eventos"),
          const DefaultTitle(title: "Opções Financeiras"),
          SecondaryButton(
            label: "Exibir log",
            icon: "log",
            onTap: () {},
          ),
          const DefaultTitle(title: "Informações de Estoque"),
          SecondaryButton(
            label: "Consultar Estoque",
            icon: "search_blue",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class Prints extends StatelessWidget {
  const Prints({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const DefaultTitle(title: "Tipos de Impressão", top: 15),
          for (int button in [1, 2, 3, 4, 5, 6])
            SecondaryButton(
              label: "Pedido Tipo $button",
              icon: "printer",
              onTap: () {},
            ),
          const DefaultTitle(title: "Enviar E-mail"),
          SecondaryButton(
            label: "Enviar E-mail",
            icon: "letter",
            onTap: () {},
          ),
          const DefaultTitle(title: "Imprimir Boleto Bancário"),
          SecondaryButton(
            label: "Boleto Atual",
            icon: "ticket",
            onTap: () {},
          ),
          SecondaryButton(
            label: "Todos os Boletos",
            icon: "ticket",
            onTap: () {},
          ),
          const DefaultTitle(title: "Imprimir  Boleto da Loja"),
          SecondaryButton(
            label: "Boletos da Loja",
            icon: "ticket",
            onTap: () {},
          ),
          const DefaultTitle(title: "Emissões de NFC-e"),
          SecondaryButton(
            label: "Imprimir NFC-e",
            icon: "nf_e",
            onTap: () {},
          ),
          SecondaryButton(
            label: "Visualizar NFC-e",
            icon: "nf_e",
            onTap: () {},
          ),
          const DefaultTextField(label: "NFC-e nº"),
          const DefaultTextField(label: "NFC-e Chave"),
          const DefaultTitle(title: "Impressões de NFC-e"),
          SecondaryButton(
            label: "Emitir NFC-e",
            icon: "nf_e",
            onTap: () {},
          ),
          const DefaultTitle(title: "Outras Impressões"),
          SecondaryButton(
            label: "Ordem de Entrega",
            icon: "order_of",
            onTap: () {},
          ),
          SecondaryButton(
            label: "Ordem de Montagem",
            icon: "order_of",
            onTap: () {},
          ),
          SecondaryButton(
            label: "Pedido com Custo",
            icon: "order_of",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class Comissions extends StatelessWidget {
  const Comissions({super.key});

  @override
  Widget build(BuildContext context) {
    return MyGrid(
      onSelect: (p0) {
        late OverlayEntry entry;
        entry = OverlayEntry(
          builder: (context) => DefaultOverlaySlider(
            onBack: () => entry.remove(),
            height: 225,
            child: Column(
              children: [
                const DefaultTitle(title: "001", top: 25, bottom: 25),
                SecondaryButton(
                  label: "Editar",
                  icon: "show_customer_register",
                  onTap: () {},
                ),
                SecondaryButton(
                  label: "Excluir",
                  icon: "delete",
                  onTap: () {},
                ),
              ],
            ),
          ),
        );
        Overlay.of(context)?.insert(entry);
      },
    );
  }
}
