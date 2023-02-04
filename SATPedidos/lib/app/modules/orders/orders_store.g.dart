// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OrdersStore on _OrdersStoreBase, Store {
  late final _$pageAtom = Atom(name: '_OrdersStoreBase.page', context: context);

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  late final _$totalsPageAtom =
      Atom(name: '_OrdersStoreBase.totalsPage', context: context);

  @override
  int get totalsPage {
    _$totalsPageAtom.reportRead();
    return super.totalsPage;
  }

  @override
  set totalsPage(int value) {
    _$totalsPageAtom.reportWrite(value, super.totalsPage, () {
      super.totalsPage = value;
    });
  }

  late final _$orderAndServicePageAtom =
      Atom(name: '_OrdersStoreBase.orderAndServicePage', context: context);

  @override
  int get orderAndServicePage {
    _$orderAndServicePageAtom.reportRead();
    return super.orderAndServicePage;
  }

  @override
  set orderAndServicePage(int value) {
    _$orderAndServicePageAtom.reportWrite(value, super.orderAndServicePage, () {
      super.orderAndServicePage = value;
    });
  }

  late final _$infoPageAtom =
      Atom(name: '_OrdersStoreBase.infoPage', context: context);

  @override
  int get infoPage {
    _$infoPageAtom.reportRead();
    return super.infoPage;
  }

  @override
  set infoPage(int value) {
    _$infoPageAtom.reportWrite(value, super.infoPage, () {
      super.infoPage = value;
    });
  }

  late final _$totalsHeightAtom =
      Atom(name: '_OrdersStoreBase.totalsHeight', context: context);

  @override
  double get totalsHeight {
    _$totalsHeightAtom.reportRead();
    return super.totalsHeight;
  }

  @override
  set totalsHeight(double value) {
    _$totalsHeightAtom.reportWrite(value, super.totalsHeight, () {
      super.totalsHeight = value;
    });
  }

  late final _$paginatingAtom =
      Atom(name: '_OrdersStoreBase.paginating', context: context);

  @override
  bool get paginating {
    _$paginatingAtom.reportRead();
    return super.paginating;
  }

  @override
  set paginating(bool value) {
    _$paginatingAtom.reportWrite(value, super.paginating, () {
      super.paginating = value;
    });
  }

  late final _$showCheckFloatAtom =
      Atom(name: '_OrdersStoreBase.showCheckFloat', context: context);

  @override
  bool get showCheckFloat {
    _$showCheckFloatAtom.reportRead();
    return super.showCheckFloat;
  }

  @override
  set showCheckFloat(bool value) {
    _$showCheckFloatAtom.reportWrite(value, super.showCheckFloat, () {
      super.showCheckFloat = value;
    });
  }

  late final _$scrollControllerAtom =
      Atom(name: '_OrdersStoreBase.scrollController', context: context);

  @override
  ScrollController get scrollController {
    _$scrollControllerAtom.reportRead();
    return super.scrollController;
  }

  @override
  set scrollController(ScrollController value) {
    _$scrollControllerAtom.reportWrite(value, super.scrollController, () {
      super.scrollController = value;
    });
  }

  late final _$pageControllerAtom =
      Atom(name: '_OrdersStoreBase.pageController', context: context);

  @override
  PageController get pageController {
    _$pageControllerAtom.reportRead();
    return super.pageController;
  }

  @override
  set pageController(PageController value) {
    _$pageControllerAtom.reportWrite(value, super.pageController, () {
      super.pageController = value;
    });
  }

  late final _$totalsPageControllerAtom =
      Atom(name: '_OrdersStoreBase.totalsPageController', context: context);

  @override
  PageController get totalsPageController {
    _$totalsPageControllerAtom.reportRead();
    return super.totalsPageController;
  }

  @override
  set totalsPageController(PageController value) {
    _$totalsPageControllerAtom.reportWrite(value, super.totalsPageController,
        () {
      super.totalsPageController = value;
    });
  }

  late final _$orderAndServicePageControllerAtom = Atom(
      name: '_OrdersStoreBase.orderAndServicePageController', context: context);

  @override
  PageController get orderAndServicePageController {
    _$orderAndServicePageControllerAtom.reportRead();
    return super.orderAndServicePageController;
  }

  @override
  set orderAndServicePageController(PageController value) {
    _$orderAndServicePageControllerAtom
        .reportWrite(value, super.orderAndServicePageController, () {
      super.orderAndServicePageController = value;
    });
  }

  late final _$infoPageControllerAtom =
      Atom(name: '_OrdersStoreBase.infoPageController', context: context);

  @override
  PageController get infoPageController {
    _$infoPageControllerAtom.reportRead();
    return super.infoPageController;
  }

  @override
  set infoPageController(PageController value) {
    _$infoPageControllerAtom.reportWrite(value, super.infoPageController, () {
      super.infoPageController = value;
    });
  }

  late final _$suppliersDataGridSourceAtom =
      Atom(name: '_OrdersStoreBase.suppliersDataGridSource', context: context);

  @override
  DataGridSource? get suppliersDataGridSource {
    _$suppliersDataGridSourceAtom.reportRead();
    return super.suppliersDataGridSource;
  }

  @override
  set suppliersDataGridSource(DataGridSource? value) {
    _$suppliersDataGridSourceAtom
        .reportWrite(value, super.suppliersDataGridSource, () {
      super.suppliersDataGridSource = value;
    });
  }

  late final _$setPageAsyncAction =
      AsyncAction('_OrdersStoreBase.setPage', context: context);

  @override
  Future<void> setPage(int newPage) {
    return _$setPageAsyncAction.run(() => super.setPage(newPage));
  }

  late final _$setTotalsPageAsyncAction =
      AsyncAction('_OrdersStoreBase.setTotalsPage', context: context);

  @override
  Future<void> setTotalsPage(int newPage) {
    return _$setTotalsPageAsyncAction.run(() => super.setTotalsPage(newPage));
  }

  late final _$setOrderAndServicePageAsyncAction =
      AsyncAction('_OrdersStoreBase.setOrderAndServicePage', context: context);

  @override
  Future<void> setOrderAndServicePage(int newPage) {
    return _$setOrderAndServicePageAsyncAction
        .run(() => super.setOrderAndServicePage(newPage));
  }

  late final _$setInfoPageAsyncAction =
      AsyncAction('_OrdersStoreBase.setInfoPage', context: context);

  @override
  Future<void> setInfoPage(int newPage) {
    return _$setInfoPageAsyncAction.run(() => super.setInfoPage(newPage));
  }

  late final _$getSuppliersDataGridSourceAsyncAction = AsyncAction(
      '_OrdersStoreBase.getSuppliersDataGridSource',
      context: context);

  @override
  Future getSuppliersDataGridSource() {
    return _$getSuppliersDataGridSourceAsyncAction
        .run(() => super.getSuppliersDataGridSource());
  }

  late final _$_OrdersStoreBaseActionController =
      ActionController(name: '_OrdersStoreBase', context: context);

  @override
  void setShowCheckFloat(bool val) {
    final _$actionInfo = _$_OrdersStoreBaseActionController.startAction(
        name: '_OrdersStoreBase.setShowCheckFloat');
    try {
      return super.setShowCheckFloat(val);
    } finally {
      _$_OrdersStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
page: ${page},
totalsPage: ${totalsPage},
orderAndServicePage: ${orderAndServicePage},
infoPage: ${infoPage},
totalsHeight: ${totalsHeight},
paginating: ${paginating},
showCheckFloat: ${showCheckFloat},
scrollController: ${scrollController},
pageController: ${pageController},
totalsPageController: ${totalsPageController},
orderAndServicePageController: ${orderAndServicePageController},
infoPageController: ${infoPageController},
suppliersDataGridSource: ${suppliersDataGridSource}
    ''';
  }
}
