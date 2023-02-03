// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:sat_movimento_de_caixa/app/constants/test_data.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../constants/default_data_grid_source.dart';

part 'cash_movement_store.g.dart';

class CashMovementStore = _CashMovementStoreBase with _$CashMovementStore;

abstract class _CashMovementStoreBase with Store implements Disposable {
  // _CashMovementStoreBase() {
  //   pageController.addListener(() {
  //     print("page ${pageController.page}");
  //   });
  // }
  @override
  void dispose() {
    pageController.dispose();
  }

  @observable
  AnimationController? filterController;
  @observable
  PageController pageController = PageController();
  @observable
  DataGridSource? movementsDataGridSource;
  @observable
  int page = 0;
  @observable
  bool showNfNumber = true;

  @action
  void setPage(int pageToSet) {
    page = pageToSet;

    pageController.animateToPage(
      pageToSet,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @action
  changeShowNfNumber() => showNfNumber = !showNfNumber;

  @action
  getMovementsDataGridSource() async {
    await Future.delayed(Duration(seconds: 1));
    movementsDataGridSource = MovementsDataGridSource(
      movements,
      rowsPerPage: 10,
    );
  }
}
