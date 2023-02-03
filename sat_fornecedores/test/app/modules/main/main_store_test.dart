import 'package:flutter_test/flutter_test.dart';
import 'package:sat_fornecedores/app/modules/main/main_store.dart';
 
void main() {
  late MainStore store;

  setUpAll(() {
    store = MainStore();
  });

  test('increment count', () async {
    expect(store.value, equals(0));
    store.increment();
    expect(store.value, equals(1));
  });
}