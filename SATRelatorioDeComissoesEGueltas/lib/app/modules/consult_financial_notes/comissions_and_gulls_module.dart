import 'package:flutter_modular/flutter_modular.dart';
import 'comissions_and_gulls_page.dart';
import 'comissions_and_gulls_store.dart';

class CommissionsAndGullsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CommissionsAndGullsStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const CommissionsAndGullsPage()),
  ];
}
