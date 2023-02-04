import 'package:comum/utilities/utilities.dart';
import 'package:comum/widgets/custom_separator.dart';
import 'package:comum/widgets/default_text_field.dart';
import 'package:comum/widgets/default_title.dart';
import 'package:comum/widgets/info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../orders_store.dart';

class OrderAdditionals extends StatefulWidget {
  const OrderAdditionals({super.key});

  @override
  State<OrderAdditionals> createState() => _OrderAdditionalsState();
}

class _OrderAdditionalsState extends State<OrderAdditionals> {
  final OrdersStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: store.scrollController,
      child: Column(
        children: [
          vSpace(wXD(15, context)),
          const DefaultTitle(title: "Endereço"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              DefaultTextField(
                label: "Contato Suporte",
                width: 390,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              DefaultTextField(
                label: "Contato Financeiro",
                width: 390,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              DefaultTextField(
                label: "E-mail Financeiro",
                width: 390,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              DefaultTextField(
                label: "Contato para Pesquisa de Satisfação",
                width: 390,
              ),
            ],
          ),
          const DefaultTitle(title: "Filiação"),
          const DefaultTextField(
            label: "Pai",
            width: 390,
            hint: "Fulano Ciclano da Silva",
          ),
          const DefaultTextField(
            label: "Mãe",
            width: 390,
            hint: "Fulana Ciclana da Silva",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const DefaultTextField(
                label: "Estado Civil",
                width: 186,
                dropDown: true,
                dropDownOptions: [],
                hint: "Solteiro",
              ),
              hSpace(16),
              const DefaultTextField(
                label: "Naturalidade",
                width: 186,
                hint: "Brasileira",
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ignore: prefer_const_constructors
              DefaultTextField(
                label: "Sexo",
                width: 186,
                dropDown: true,
                dropDownOptions: const [],
                hint: "Masculino",
              ),
              hSpace(16),
              const DefaultTextField(
                label: "Manequim",
                width: 186,
              )
            ],
          ),
          const DefaultTitle(title: "Trabalho"),
          const DefaultTextField(
            label: "Empresa/Contato",
            width: 390,
            hint: "SAT Sistemas",
          ),
          const DefaultTextField(
            label: "Endereço",
            width: 390,
            hint: "QE 14 Samdu Norte",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const DefaultTextField(
                label: "Cidade",
                width: 186,
                hint: "Brasília",
              ),
              hSpace(16),
              const DefaultTextField(
                label: "Estado",
                width: 186,
                dropDown: true,
                dropDownOptions: [],
                hint: "DF",
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const DefaultTextField(
                label: "Salário",
                width: 186,
                hint: "RS 350.000",
              ),
              hSpace(16),
              const DefaultTextField(
                label: "Cargo",
                width: 186,
                dropDown: true,
                dropDownOptions: [],
                hint: "QA",
              ),
            ],
          ),
          //INPUT CHECKBOX IN HERE

          const DefaultTextField(
            label: "Chefe",
            width: 390,
            hint: "Ricardo de La Viela",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const DefaultTextField(
                label: "Telefone(s)",
                width: 186,
                hint: "61 9 9528 4652",
              ),
              hSpace(16),
              const DefaultTextField(
                label: "Outras Rendas",
                width: 186,
                hint: "Conserto de Eletrônicos",
              )
            ],
          ),

          const DefaultTitle(title: "Tempo de Serviço"),

          const InfoWidget(
              info: "Marque essa opção para retirar o produto de linha"),
          const DefaultTitle(title: "Opções Financeiras"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultTextField(
                label: "Preço de venda mínimo",
                width: wXD(217, context),
              ),
              hSpace(wXD(15, context)),
              DefaultTextField(
                label: "MarkUp Mínimo",
                width: wXD(156, context),
              ),
            ],
          ),
          const CustomSeparator(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultTextField(
                label: "Guelta",
                width: wXD(156, context),
                bottom: wXD(7, context),
              ),
              hSpace(wXD(15, context)),
              DefaultTextField(
                label: "Percentual Montagem",
                width: wXD(217, context),
                bottom: wXD(7, context),
              ),
            ],
          ),
          const InfoWidget(
            info: "Para configurar Valou ou Percentual, altere a"
                " configuração em Parâmetros do sistema",
          ),
          DefaultTitle(
            title: "Validade na etiqueta",
            top: wXD(25, context),
          ),
          Container(
            padding: EdgeInsets.only(left: wXD(20, context)),
            alignment: Alignment.centerLeft,
            child: DefaultTextField(
              label: "Dias para Vencer",
              width: wXD(168, context),
            ),
          ),
          const DefaultTitle(title: "Localização do Produto"),
          const DefaultTextField(label: "Local"),
          const DefaultTitle(title: "Controle de Estoque"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultTextField(
                label: "Quantidade mínima",
                width: wXD(186, context),
                bottom: wXD(7, context),
              ),
              hSpace(wXD(15, context)),
              DefaultTextField(
                label: "Quantidade da caixa",
                width: wXD(186, context),
                bottom: wXD(7, context),
              ),
            ],
          ),
          const InfoWidget(
            info: "Utilize esse campo para colocar a quantidade mínima"
                " a ser vendida. Ex.:Pisos.",
          ),
          DefaultTitle(
            title: "Impressão para lanchonete",
            top: wXD(25, context),
          ),
          const DefaultTextField(
            label: "Selecione a impressora",
            data: "EPSON 3003",
            dropDown: true,
            dropDownOptions: [],
          ),
          const CustomSeparator(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultTextField(
                label: "Produto cadastrado em",
                data: "15/09/2021",
                width: wXD(217, context),
                bottom: wXD(7, context),
              ),
              hSpace(wXD(15, context)),
              DefaultTextField(
                label: "Fabricação",
                data: "Própria",
                width: wXD(156, context),
                bottom: wXD(7, context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
