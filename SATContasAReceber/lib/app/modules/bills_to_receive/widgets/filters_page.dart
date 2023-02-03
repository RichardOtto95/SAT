import 'package:comum/utilities/custom_scroll_behavior.dart';
import 'package:comum/utilities/utilities.dart';
import 'package:comum/widgets/custom_check.dart';
import 'package:comum/widgets/default_app_bar.dart';
import 'package:comum/widgets/default_text_field.dart';
import 'package:comum/widgets/default_title.dart';
import 'package:comum/widgets/info_widget.dart';
import 'package:comum/widgets/secondary_button.dart';
import 'package:flutter/material.dart';

class FiltersPage extends StatelessWidget {
  const FiltersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: CustomScrollBehavior(),
        child: Column(
          children: [
            const DefaultAppBar(
              title: "Filtros",
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    vSpace(15),
                    Row(
                      children: [
                        const Expanded(
                          child: DefaultTextField(
                            label: "Data Inicial",
                            width: double.infinity,
                            left: 10,
                            right: 5,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            "a",
                            style: getStyles(context).titleSmall,
                          ),
                        ),
                        const Expanded(
                          child: DefaultTextField(
                            label: "Data Inicial",
                            width: double.infinity,
                            left: 5,
                            right: 10,
                          ),
                        ),
                      ],
                    ),
                    const DefaultTextField(label: "Contendo"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DefaultTextField(
                          label: "Preço de Venda",
                          width: splitWidth(context, 2),
                        ),
                        DefaultTextField(
                          label: "Ordem",
                          width: splitWidth(context, 2),
                          dropDown: true,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DefaultTextField(
                          label: "Sugestão",
                          width: splitWidth(context, 2),
                        ),
                        DefaultTextField(
                          label: "Agrupado por",
                          width: splitWidth(context, 2),
                          dropDown: true,
                        ),
                      ],
                    ),
                    const InfoWidget(
                      info: "Obs. : A coluna Sugestão = (\"Qde Vend\" "
                          "/ Período * Sugestão em Dias) - \"Estoque 2\" - \"a Chegar.\"",
                      padding: EdgeInsets.only(bottom: 10),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DefaultTextField(
                          label: "Fornecedor",
                          width: splitWidth(context, 2),
                          dropDown: true,
                        ),
                        DefaultTextField(
                          label: "Cliente",
                          width: splitWidth(context, 2),
                          dropDown: true,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DefaultTextField(
                          label: "Vendedor",
                          width: splitWidth(context, 2),
                          dropDown: true,
                        ),
                        DefaultTextField(
                          label: "Status do pedido",
                          width: splitWidth(context, 2),
                          dropDown: true,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DefaultTextField(
                          label: "Marca",
                          width: splitWidth(context, 2),
                          dropDown: true,
                        ),
                        DefaultTextField(
                          label: "Estrutura",
                          width: splitWidth(context, 2),
                          dropDown: true,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DefaultTextField(
                          label: "Loja Venda \"Qtd. Vendida\"",
                          width: splitWidth(context, 2),
                          dropDown: true,
                        ),
                        DefaultTextField(
                          label: "Loja Entrega \"Qtd. Vendida\"",
                          width: splitWidth(context, 2),
                          dropDown: true,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DefaultTextField(
                          label: "Loja \"Estoque 1\"",
                          width: splitWidth(context, 2),
                          dropDown: true,
                        ),
                        DefaultTextField(
                          label: "Loja \"Estoque 2\"",
                          width: splitWidth(context, 2),
                          dropDown: true,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        hSpace(10),
                        DefaultTextField(
                          label: "Loja \"a Chegar\"",
                          width: splitWidth(context, 2),
                          dropDown: true,
                        ),
                      ],
                    ),
                    const CustomCheck(
                      text: "Exibir quantidade e data do último pedido",
                      checked: true,
                    ),
                    const CustomCheck(
                      text: "Exibir quantidade vendida dos 2 últimos meses",
                      checked: true,
                    ),
                    const CustomCheck(
                      text: "Exibir coluna com o Código de barras.",
                      checked: true,
                    ),
                    const CustomCheck(
                      text: "Exibir coluna com a Referência Alternativa",
                      checked: true,
                    ),
                    const CustomCheck(
                      text:
                          "Somente produtos com a coluna \"estoque em dias\" entre",
                      checked: true,
                    ),
                    const CustomCheck(
                      text: "Somente Produtos em Linha",
                      checked: true,
                    ),
                    const CustomCheck(
                      text: "Somente Produtos com \"Qde vend\" acima de zero",
                      checked: true,
                    ),
                    const CustomCheck(
                      text:
                          "Somente Produtos com \"Loja Estoque\" acima de zero",
                      checked: true,
                    ),
                    const CustomCheck(
                      text: "Somente Produtos com \"a Chegar\" acima de zero",
                      checked: true,
                    ),
                    const CustomCheck(
                      text:
                          "Somente Produtos com a coluna \"Sugestão\" acima de zero",
                      checked: true,
                    ),
                    const CustomCheck(
                      text: "Somente Produtos em Estoque",
                      checked: true,
                    ),
                    const CustomCheck(
                      text: "Somente Produtos Vendidos",
                      checked: true,
                    ),
                    const DefaultTitle(
                      title: "Exibir Rotatividade de Produtos Vendidios",
                      isLeft: true,
                      left: 20,
                    ),
                    SecondaryButton(
                      label: "Sugestão de Compra",
                      icon: "export",
                      onTap: () {},
                    ),
                    SecondaryButton(
                      label: "Sugestão de Compra do Resumo",
                      icon: "export",
                      onTap: () {},
                    ),
                    SecondaryButton(
                      label: "Sugestão por lojas",
                      icon: "export",
                      onTap: () {},
                    ),
                    SecondaryButton(
                      label: "Sugestão por loja do Resumo",
                      icon: "export",
                      onTap: () {},
                    ),
                    SecondaryButton(
                      label: "Por Dia",
                      icon: "export",
                      onTap: () {},
                    ),
                    SecondaryButton(
                      label: "Por mês",
                      icon: "export",
                      onTap: () {},
                    ),
                    SecondaryButton(
                      label: "Estoque por lojas",
                      icon: "store_stock",
                      onTap: () {},
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DefaultTextField(
                          label: "Ordem",
                          width: splitWidth(context, 2),
                          dropDown: true,
                        ),
                        SecondaryButton(
                          label: "Exibir Gráfico",
                          icon: "graph",
                          width: splitWidth(context, 2),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
