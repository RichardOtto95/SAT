import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sat_fornecedores/app/modules/main/main_module.dart';
 
void main() {

  setUpAll(() {
    initModule(MainModule());
  });
}