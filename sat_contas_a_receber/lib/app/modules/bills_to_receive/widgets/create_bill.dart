import 'package:comum/utilities/utilities.dart';
import 'package:comum/widgets/custom_check.dart';
import 'package:comum/widgets/default_app_bar.dart';
import 'package:comum/widgets/default_text_field.dart';
import 'package:comum/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CreateBill extends StatelessWidget {
  const CreateBill({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DefaultAppBar(
            title: "Cadastrar Contas a\nReceber Avulso",
          ),
          DefaultTextField(label: "Vencimento"),
          DefaultTextField(label: "Loja", dropDown: true),
          DefaultTextField(label: "Cliente", dropDown: true),
          DefaultTextField(label: "Nome"),
          DefaultTextField(label: "Forma de Pagamento", dropDown: true),
          DefaultTextField(label: "Valor"),
          DefaultTextField(label: "Número do Documento"),
          CustomCheck(text: "Lançar Débito em Conta Corrente", checked: true),
          Spacer(flex: 5),
          PrimaryButton(
            label: "Cadastrar Conta a Receber",
            onTap: () {},
            width: wXD(360, context),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
