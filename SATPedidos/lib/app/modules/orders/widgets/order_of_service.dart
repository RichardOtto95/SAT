import 'package:comum/utilities/utilities.dart';
import 'package:comum/widgets/custom_navigation_tile.dart';
import 'package:comum/widgets/default_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../orders_store.dart';

class OrderOfService extends StatelessWidget {
  OrderOfService({super.key});

  final OrdersStore store = Modular.get();

  final _tileKey = GlobalKey<CustomNavigationTileState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        vSpace(10),
        Observer(
          builder: (context) {
            return CustomNavigationTile(
              key: _tileKey,
              tiles: const [
                "Principal",
                "Adicionais",
                "Outros",
              ],
              horizontalPadding: 10,
              width: maxWidth(context) - 44,
              onPageChange: (page) => store.setOrderAndServicePage(page),
              page: store.orderAndServicePage,
            );
          },
        ),
        vSpace(10),
        Expanded(
          child: PageView(
            controller: store.orderAndServicePageController,
            onPageChanged: (value) {
              store.setOrderAndServicePage(value);
              _tileKey.currentState!.changePosition(value);
            },
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DefaultTextField(
                          label: "Situação",
                          hint: "",
                          width: (maxWidth(context) - 30) / 2,
                          dropDown: true,
                          dropDownOptions: const [],
                          bottom: 10,
                        ),
                        DefaultTextField(
                          label: "Garantia",
                          width: (maxWidth(context) - 30) / 2,
                          dropDown: true,
                          dropDownOptions: const [],
                          bottom: 10,
                        ),
                      ],
                    ),
                    DefaultTextField(
                      label: "Descrição",
                      width: maxWidth(context) - 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DefaultTextField(
                          label: "Data Entrada",
                          hint: "",
                          width: (maxWidth(context) - 30) / 2,
                          bottom: 10,
                        ),
                        DefaultTextField(
                          label: "Data Pronto",
                          width: (maxWidth(context) - 30) / 2,
                          bottom: 10,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DefaultTextField(
                          label: "Data Entrega",
                          hint: "",
                          width: (maxWidth(context) - 30) / 2,
                          bottom: 10,
                        ),
                        DefaultTextField(
                          label: "Placa",
                          width: (maxWidth(context) - 30) / 2,
                          bottom: 10,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DefaultTextField(
                          label: "Modelo",
                          hint: "",
                          width: (maxWidth(context) - 30) / 2,
                          bottom: 10,
                        ),
                        DefaultTextField(
                          label: "Marca",
                          width: (maxWidth(context) - 30) / 2,
                          bottom: 10,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        hSpace(10),
                        DefaultTextField(
                          label: "Cor",
                          hint: "",
                          width: (maxWidth(context) - 30) / 2,
                          bottom: 10,
                        ),
                      ],
                    ),
                    DefaultTextField(
                      label: "Defeito",
                      width: maxWidth(context) - 20,
                    ),
                    DefaultTextField(
                      label: "Solução",
                      width: maxWidth(context) - 20,
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SizedBox(
                  width: maxWidth(context),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DefaultTextField(
                            label: "Data Aprovação",
                            hint: "",
                            width: (maxWidth(context) - 30) / 2,
                            bottom: 10,
                          ),
                          DefaultTextField(
                            label: "Horário Inicial",
                            width: (maxWidth(context) - 30) / 2,
                            bottom: 10,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DefaultTextField(
                            label: "Previsão Conclusão",
                            hint: "",
                            width: (maxWidth(context) - 30) / 2,
                            bottom: 10,
                          ),
                          DefaultTextField(
                            label: "Horário Finalizado",
                            width: (maxWidth(context) - 30) / 2,
                            bottom: 10,
                          ),
                        ],
                      ),
                      DefaultTextField(
                        label: "Diagnóstico",
                        width: maxWidth(context) - 20,
                      ),
                      DefaultTextField(
                        label: "Solicitante",
                        width: maxWidth(context) - 20,
                      ),
                      DefaultTextField(
                        label: "Responsável Aprovado",
                        width: maxWidth(context) - 20,
                      ),
                      DefaultTextField(
                        label: "Contole Externo",
                        width: maxWidth(context) - 20,
                      ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SizedBox(
                  width: maxWidth(context),
                  child: Column(
                    children: [
                      DefaultTextField(
                        label: "Logica",
                        width: maxWidth(context) - 20,
                      ),
                      DefaultTextField(
                        label: "Loja",
                        width: maxWidth(context) - 20,
                      ),
                      DefaultTextField(
                        label: "Logistica",
                        width: maxWidth(context) - 20,
                      ),
                      DefaultTextField(
                        label: "Lojista",
                        width: maxWidth(context) - 20,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
