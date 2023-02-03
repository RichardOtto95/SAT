import 'package:flutter_test/flutter_test.dart';
import 'package:sat_fornecedores/app/modules/suppliers/suppliers_store.dart';
 
void main() {
  late SuppliersStore store;

  setUpAll(() {
    store = SuppliersStore();
  });

  test('increment count', () async {
    expect(store.value, equals(0));
    store.increment();
    expect(store.value, equals(1));
  });
}