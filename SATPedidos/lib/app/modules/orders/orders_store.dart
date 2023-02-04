import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../constants/default_data_grid_source.dart';

part 'orders_store.g.dart';

// ignore: library_private_types_in_public_api
class OrdersStore = _OrdersStoreBase with _$OrdersStore;

abstract class _OrdersStoreBase with Store {
  void dispose() {
    scrollController.removeListener(() {});
    scrollController.dispose();
    pageController.dispose();
    totalsPageController.dispose();
  }

  @observable
  int page = 0;
  @observable
  int totalsPage = 0;
  @observable
  int orderAndServicePage = 0;
  @observable
  int infoPage = 0;
  @observable
  double totalsHeight = 130;
  @observable
  bool paginating = false;
  @observable
  bool showCheckFloat = true;
  @observable
  ScrollController scrollController = ScrollController();
  @observable
  PageController pageController = PageController();
  @observable
  PageController totalsPageController = PageController();
  @observable
  PageController orderAndServicePageController = PageController();
  @observable
  PageController infoPageController = PageController();
  @observable
  DataGridSource? suppliersDataGridSource;

  @action
  void setShowCheckFloat(bool val) => showCheckFloat = val;

  bool get getShowCheckFloat => showCheckFloat;

  @action
  Future<void> setPage(int newPage) async {
    if (page != newPage && !paginating) {
      paginating = true;
      page = newPage;
      await pageController.animateToPage(page,
          duration: const Duration(milliseconds: 450),
          curve: Curves.decelerate);
      paginating = false;
    }
  }

  @action
  Future<void> setTotalsPage(int newPage) async {
    if (totalsPage != newPage && !paginating) {
      paginating = true;
      if (newPage == 2) {
        totalsHeight = 195;
      } else {
        totalsHeight = 130;
      }
      totalsPage = newPage;
      await totalsPageController.animateToPage(totalsPage,
          duration: const Duration(milliseconds: 450),
          curve: Curves.decelerate);
      paginating = false;
    }
  }

  @action
  Future<void> setOrderAndServicePage(int newPage) async {
    if (orderAndServicePage != newPage && !paginating) {
      paginating = true;
      orderAndServicePage = newPage;
      await orderAndServicePageController.animateToPage(orderAndServicePage,
          duration: const Duration(milliseconds: 450),
          curve: Curves.decelerate);
      paginating = false;
    }
  }

  @action
  Future<void> setInfoPage(int newPage) async {
    if (infoPage != newPage && !paginating) {
      paginating = true;
      infoPage = newPage;
      await infoPageController.animateToPage(infoPage,
          duration: const Duration(milliseconds: 450),
          curve: Curves.decelerate);
      paginating = false;
    }
  }

  @action
  getSuppliersDataGridSource() async {
    await Future.delayed(const Duration(seconds: 1));
    suppliersDataGridSource = SuppliersDataGridSource(
      List.generate(
          50,
          (index) => {
                "date": DateTime.now().add(Duration(days: index)),
                "store": "Nome da Loja",
                "name": "Nome",
                "value": "R\$ 300,00",
                "payed_to": "Pago à",
                "user": "usuário",
              }),
      rowsPerPage: 10,
    );
  }
}
