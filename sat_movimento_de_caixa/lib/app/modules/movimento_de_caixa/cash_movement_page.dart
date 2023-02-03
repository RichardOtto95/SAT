import 'package:flutter/gestures.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:flutter/material.dart';
import 'package:sat_movimento_de_caixa/app/modules/movimento_de_caixa/widgets/cash_movement_app_bar.dart';
import 'package:sat_movimento_de_caixa/app/modules/movimento_de_caixa/widgets/cash_options.dart';
import 'package:sat_movimento_de_caixa/app/modules/movimento_de_caixa/widgets/expenses.dart';
import 'package:sat_movimento_de_caixa/app/modules/movimento_de_caixa/widgets/inputs_outputs.dart';
import 'package:sat_movimento_de_caixa/app/modules/movimento_de_caixa/widgets/movements.dart';
import 'package:sat_movimento_de_caixa/app/modules/movimento_de_caixa/widgets/previous_receipts.dart';
import 'package:sat_movimento_de_caixa/app/shared/utilities.dart';

import 'cash_movement_store.dart';

class CashMovementPage extends StatefulWidget {
  final String title;
  const CashMovementPage({Key? key, this.title = 'CashMovementPage'})
      : super(key: key);
  @override
  CashMovementPageState createState() => CashMovementPageState();
}

class CashMovementPageState extends State<CashMovementPage> {
  final CashMovementStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: MyCustomScrollBehavior(),
        child: Stack(
          children: <Widget>[
            Container(
              height: maxHeight(context),
              width: maxWidth(context),
              padding: EdgeInsets.only(top: viewPaddingTop(context) + 97),
              child: PageView(
                // physics: NeverScrollableScrollPhysics(),
                controller: store.pageController,
                onPageChanged: (value) => store.page = value,
                children: const [
                  CashOptions(),
                  Movements(),
                  Expenses(),
                  InputsOutputs(),
                  PreviousReceipts(),
                ],
              ),
            ),
            const CashMovementAppBar(),
          ],
        ),
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
