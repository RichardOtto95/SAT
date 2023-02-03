// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consult_financial_notes_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ConsultFinancialNotesStore on _ConsultFinancialNotesStoreBase, Store {
  late final _$paginatingAtom = Atom(
      name: '_ConsultFinancialNotesStoreBase.paginating', context: context);

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

  late final _$pageAtom =
      Atom(name: '_ConsultFinancialNotesStoreBase.page', context: context);

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

  late final _$pageControllerAtom = Atom(
      name: '_ConsultFinancialNotesStoreBase.pageController', context: context);

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

  late final _$setPageAsyncAction =
      AsyncAction('_ConsultFinancialNotesStoreBase.setPage', context: context);

  @override
  Future<void> setPage(int value) {
    return _$setPageAsyncAction.run(() => super.setPage(value));
  }

  @override
  String toString() {
    return '''
paginating: ${paginating},
page: ${page},
pageController: ${pageController}
    ''';
  }
}
