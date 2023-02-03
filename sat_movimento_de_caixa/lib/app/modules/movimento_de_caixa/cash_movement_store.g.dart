// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_movement_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CashMovementStore on _CashMovementStoreBase, Store {
  late final _$filterControllerAtom =
      Atom(name: '_CashMovementStoreBase.filterController', context: context);

  @override
  AnimationController? get filterController {
    _$filterControllerAtom.reportRead();
    return super.filterController;
  }

  @override
  set filterController(AnimationController? value) {
    _$filterControllerAtom.reportWrite(value, super.filterController, () {
      super.filterController = value;
    });
  }

  late final _$pageControllerAtom =
      Atom(name: '_CashMovementStoreBase.pageController', context: context);

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

  late final _$movementsDataGridSourceAtom = Atom(
      name: '_CashMovementStoreBase.movementsDataGridSource', context: context);

  @override
  DataGridSource? get movementsDataGridSource {
    _$movementsDataGridSourceAtom.reportRead();
    return super.movementsDataGridSource;
  }

  @override
  set movementsDataGridSource(DataGridSource? value) {
    _$movementsDataGridSourceAtom
        .reportWrite(value, super.movementsDataGridSource, () {
      super.movementsDataGridSource = value;
    });
  }

  late final _$pageAtom =
      Atom(name: '_CashMovementStoreBase.page', context: context);

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

  late final _$showNfNumberAtom =
      Atom(name: '_CashMovementStoreBase.showNfNumber', context: context);

  @override
  bool get showNfNumber {
    _$showNfNumberAtom.reportRead();
    return super.showNfNumber;
  }

  @override
  set showNfNumber(bool value) {
    _$showNfNumberAtom.reportWrite(value, super.showNfNumber, () {
      super.showNfNumber = value;
    });
  }

  late final _$getMovementsDataGridSourceAsyncAction = AsyncAction(
      '_CashMovementStoreBase.getMovementsDataGridSource',
      context: context);

  @override
  Future getMovementsDataGridSource() {
    return _$getMovementsDataGridSourceAsyncAction
        .run(() => super.getMovementsDataGridSource());
  }

  late final _$_CashMovementStoreBaseActionController =
      ActionController(name: '_CashMovementStoreBase', context: context);

  @override
  void setPage(int pageToSet) {
    final _$actionInfo = _$_CashMovementStoreBaseActionController.startAction(
        name: '_CashMovementStoreBase.setPage');
    try {
      return super.setPage(pageToSet);
    } finally {
      _$_CashMovementStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeShowNfNumber() {
    final _$actionInfo = _$_CashMovementStoreBaseActionController.startAction(
        name: '_CashMovementStoreBase.changeShowNfNumber');
    try {
      return super.changeShowNfNumber();
    } finally {
      _$_CashMovementStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
filterController: ${filterController},
pageController: ${pageController},
movementsDataGridSource: ${movementsDataGridSource},
page: ${page},
showNfNumber: ${showNfNumber}
    ''';
  }
}
