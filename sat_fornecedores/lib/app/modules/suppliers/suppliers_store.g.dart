// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suppliers_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SuppliersStore on _SuppliersStoreBase, Store {
  late final _$supplierOverlayAtom =
      Atom(name: '_SuppliersStoreBase.supplierOverlay', context: context);

  @override
  OverlayEntry? get supplierOverlay {
    _$supplierOverlayAtom.reportRead();
    return super.supplierOverlay;
  }

  @override
  set supplierOverlay(OverlayEntry? value) {
    _$supplierOverlayAtom.reportWrite(value, super.supplierOverlay, () {
      super.supplierOverlay = value;
    });
  }

  late final _$_SuppliersStoreBaseActionController =
      ActionController(name: '_SuppliersStoreBase', context: context);

  @override
  void insertSupplierOverlay(dynamic context, OverlayEntry overlay) {
    final _$actionInfo = _$_SuppliersStoreBaseActionController.startAction(
        name: '_SuppliersStoreBase.insertSupplierOverlay');
    try {
      return super.insertSupplierOverlay(context, overlay);
    } finally {
      _$_SuppliersStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeSupplierOverlay() {
    final _$actionInfo = _$_SuppliersStoreBaseActionController.startAction(
        name: '_SuppliersStoreBase.removeSupplierOverlay');
    try {
      return super.removeSupplierOverlay();
    } finally {
      _$_SuppliersStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
supplierOverlay: ${supplierOverlay}
    ''';
  }
}
