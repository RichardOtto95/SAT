import 'package:flutter_modular/flutter_modular.dart';
import 'expense_report_page.dart';
import 'expense_report_store.dart';

class ExpenseReportModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ExpenseReportStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const ExpenseReportPage()),
  ];
}
