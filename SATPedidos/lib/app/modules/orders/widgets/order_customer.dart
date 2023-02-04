import 'package:comum/utilities/utilities.dart';
import 'package:comum/widgets/custom_drop_down.dart';
import 'package:comum/widgets/default_text_field.dart';
import 'package:comum/widgets/secondary_button.dart';
import 'package:flutter/material.dart';

class OrderCustomer extends StatelessWidget {
  const OrderCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          vSpace(10),
          Row(
            children: [
              hSpace(10),
              const Expanded(
                flex: 1,
                child: DefaultTextField(
                  label: "Código",
                  hint: "",
                  width: double.infinity,
                  bottom: 10,
                ),
              ),
              hSpace(10),
              const Expanded(
                flex: 3,
                child: DefaultTextField(
                  label: "Nome / Razão Social",
                  width: double.infinity,
                  bottom: 10,
                ),
              ),
              hSpace(10),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DefaultTextField(
                label: "Loja",
                hint: "",
                width: (maxWidth(context) - 30) / 2,
                bottom: 10,
              ),
              DefaultTextField(
                label: "Tabela de Preço",
                width: (maxWidth(context) - 30) / 2,
                dropDown: true,
                dropDownOptions: const [],
                bottom: 10,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DefaultTextField(
                label: "Nome fantasia",
                hint: "",
                width: (maxWidth(context) - 30) / 2,
                isBlue: true,
                bottom: 10,
              ),
              DefaultTextField(
                label: "CPF/CNPJ",
                width: (maxWidth(context) - 30) / 2,
                isBlue: true,
                bottom: 10,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DefaultTextField(
                label: "RG/IE",
                hint: "",
                width: (maxWidth(context) - 30) / 2,
                isBlue: true,
                bottom: 10,
              ),
              DefaultTextField(
                label: "Indicador Consumidor",
                width: (maxWidth(context) - 30) / 2,
                dropDown: true,
                dropDownOptions: const [],
                bottom: 10,
              ),
            ],
          ),
          CustomDropDown(
            items: const ["Indicador de Inscrição estadual"],
            onChanged: (item) {},
            width: maxWidth(context) - 20,
          ),
          DefaultTextField(
            label: "Endereço",
            isBlue: true,
            width: maxWidth(context) - 20,
            bottom: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DefaultTextField(
                label: "CEP",
                hint: "",
                width: (maxWidth(context) - 30) / 2,
                isBlue: true,
                bottom: 10,
              ),
              DefaultTextField(
                label: "Cidade",
                width: (maxWidth(context) - 30) / 2,
                isBlue: true,
                bottom: 10,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DefaultTextField(
                label: "Bairro",
                hint: "",
                width: (maxWidth(context) - 30) / 2,
                isBlue: true,
                bottom: 10,
              ),
              DefaultTextField(
                label: "Fones",
                width: (maxWidth(context) - 30) / 2,
                isBlue: true,
                bottom: 10,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DefaultTextField(
                label: "E-mail",
                hint: "",
                width: (maxWidth(context) - 30) / 2,
                isBlue: true,
                bottom: 10,
              ),
              DefaultTextField(
                label: "UF",
                width: (maxWidth(context) - 30) / 2,
                dropDown: true,
                dropDownOptions: const [],
                bottom: 10,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DefaultTextField(
                label: "Código Municipal IBGE",
                hint: "",
                width: (maxWidth(context) - 30) / 2,
                isBlue: true,
                bottom: 10,
              ),
              DefaultTextField(
                label: "Data de Nascimento",
                width: (maxWidth(context) - 30) / 2,
                isBlue: true,
                bottom: 10,
              ),
            ],
          ),
          SecondaryButton(
            label: "Consultar CNPJ/CPF",
            width: maxWidth(context) - 20,
            icon: "search_blue",
            onTap: () {},
            bottom: 10,
          ),
          SecondaryButton(
            label: "Procurar Cliente",
            width: maxWidth(context) - 20,
            icon: "search_blue",
            onTap: () {},
            bottom: 10,
          ),
          SecondaryButton(
            label: "Inserir Cliente",
            width: maxWidth(context) - 20,
            icon: "add",
            onTap: () {},
            bottom: 10,
          ),
          SecondaryButton(
            label: "Salvar Dados do Cliente",
            width: maxWidth(context) - 20,
            icon: "save",
            onTap: () {},
            bottom: 10,
          ),
          SecondaryButton(
            label: "Consultar Saldo",
            width: maxWidth(context) - 20,
            icon: "check_balance",
            onTap: () {},
            bottom: 10,
          ),
          SecondaryButton(
            label: "Consultar Pedidos",
            width: maxWidth(context) - 20,
            icon: "check_orders",
            onTap: () {},
            bottom: 10,
          ),
          SecondaryButton(
            label: "Exibir Cadastro do Cliente",
            width: maxWidth(context) - 20,
            icon: "show_customer_register",
            onTap: () {},
            bottom: 10,
          ),
        ],
      ),
    );
  }
}
