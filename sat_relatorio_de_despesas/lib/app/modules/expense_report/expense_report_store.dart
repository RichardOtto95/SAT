import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'expense_report_store.g.dart';

// ignore: library_private_types_in_public_api
class ExpenseReportStore = _ExpenseReportStoreBase with _$ExpenseReportStore;

abstract class _ExpenseReportStoreBase with Store implements Disposable {
  @override
  void dispose() {
    pageController.dispose();
  }

  @observable
  bool paginating = false;
  @observable
  int page = 0;
  @observable
  PageController pageController = PageController();

  @action
  Future<void> setPage(int value) async {
    page = value;
    if (!paginating) {
      paginating = true;
      await pageController.animateToPage(
        value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.decelerate,
      );
      paginating = false;
    }
  }
}
