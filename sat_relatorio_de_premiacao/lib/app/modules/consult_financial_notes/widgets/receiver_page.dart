import 'package:comum/utilities/utilities.dart';
import 'package:comum/widgets/default_app_bar.dart';
import 'package:comum/widgets/default_text_field.dart';
import 'package:flutter/material.dart';

class ReceiverPage extends StatelessWidget {
  const ReceiverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const DefaultAppBar(
            title: "Destinatário",
          ),
          vSpace(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DefaultTextField(
                label: "Código",
                width: splitWidth(context, 2),
                isBlue: true,
              ),
              DefaultTextField(
                label: "CPF/CNPJ",
                width: splitWidth(context, 2),
                isBlue: true,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DefaultTextField(
                label: "RG/IE",
                width: splitWidth(context, 2),
                isBlue: true,
              ),
              DefaultTextField(
                label: "UF",
                width: splitWidth(context, 2),
                isBlue: true,
              ),
            ],
          ),
          const DefaultTextField(label: "Nome"),
          const DefaultTextField(label: "Endereço"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DefaultTextField(
                label: "Bairro",
                width: splitWidth(context, 2),
                isBlue: true,
              ),
              DefaultTextField(
                label: "Cidade",
                width: splitWidth(context, 2),
                isBlue: true,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DefaultTextField(
                label: "Fones",
                width: splitWidth(context, 2),
                isBlue: true,
              ),
              DefaultTextField(
                label: "CEP",
                width: splitWidth(context, 2),
                isBlue: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
