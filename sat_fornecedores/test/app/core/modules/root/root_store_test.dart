import 'package:flutter_test/flutter_test.dart';
import 'package:sat_fornecedores/app/core/modules/root/root_store.dart';
 
void main() {
  late RootStore store;

  setUpAll(() {
    store = RootStore();
  });

  test('increment count', () async {
    expect(store.value, equals(0));
    store.increment();
    expect(store.value, equals(1));
  });
}