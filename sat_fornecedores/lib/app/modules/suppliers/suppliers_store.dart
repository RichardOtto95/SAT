import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'suppliers_store.g.dart';

class SuppliersStore = _SuppliersStoreBase with _$SuppliersStore;

abstract class _SuppliersStoreBase with Store {
  @observable
  OverlayEntry? supplierOverlay;

  @action
  void insertSupplierOverlay(context, OverlayEntry overlay) {
    supplierOverlay = overlay;
    Overlay.of(context)!.insert(supplierOverlay!);
  }

  @action
  void removeSupplierOverlay() {
    if (supplierOverlay != null) {
      supplierOverlay!.remove();
      supplierOverlay = null;
    }
  }
}
