import 'package:comum/utilities/utilities.dart';
import 'package:comum/widgets/custom_floating_button.dart';
import 'package:comum/widgets/default_text_field.dart';

import 'package:comum/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../orders_store.dart';
import 'dart:math' as math;

import 'grid_base.dart';

class OrdersMain extends StatefulWidget {
  final void Function(bool opening) onSlide;
  const OrdersMain({super.key, required this.onSlide});

  @override
  State<OrdersMain> createState() => OrdersMainState();
}

class OrdersMainState extends State<OrdersMain> with TickerProviderStateMixin {
  final OrdersStore store = Modular.get();

  late final AnimationController animationController;

  late final AnimationController floatController;

  double sliderHeight = 32;

  // @override
  // void dispose() {
  //   animationController.dispose();
  //   super.dispose;
  // }

  @override
  void initState() {
    animationController = AnimationController(vsync: this);
    floatController = AnimationController(vsync: this);
    super.initState();
  }

  Future<void> animateSlider() async {
    widget.onSlide(animationController.value == 0);
    animationController.animateTo(animationController.value == 0 ? 1 : 0,
        duration: const Duration(milliseconds: 450), curve: Curves.decelerate);
    animateFloat(animationController.value == 0 ? 1 : 0);
  }

  Future<void> animateFloat(double value) async {
    floatController.animateTo(value,
        duration: const Duration(milliseconds: 450), curve: Curves.decelerate);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            vSpace(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DefaultTextField(
                  label: "Pedido",
                  width: (maxWidth(context) - 30) / 2,
                  hint: "00001",
                  bottom: 10,
                ),
                hSpace(10),
                DefaultTextField(
                  label: "Data",
                  width: (maxWidth(context) - 30) / 2,
                  hint: "07/04/22",
                  bottom: 10,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DefaultTextField(
                  label: "Fornecedor",
                  width: (maxWidth(context) - 30) / 2,
                  dropDown: true,
                  dropDownOptions:
                      List.generate(10, (index) => "Fornecedor $index"),
                  hint: "001",
                  bottom: 10,
                ),
                hSpace(10),
                DefaultTextField(
                  label: "Tipo",
                  width: (maxWidth(context) - 30) / 2,
                  hint: "Tipo de fornecedor",
                  dropDown: true,
                  dropDownOptions: const [],
                  bottom: 10,
                ),
              ],
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 32),
                    child: MyGrid(),
                  ),
                  Positioned(
                    bottom: 0,
                    child: ColoredBox(
                      color: getColors(context).background,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () => animateSlider(),
                            child: Container(
                              height: 32,
                              width: maxWidth(context),
                              color: Colors.transparent,
                              alignment: Alignment.center,
                              child: AnimatedBuilder(
                                  animation: animationController,
                                  child: SvgPicture.asset(
                                    "./assets/svg/arrow_up.svg",
                                    width: 25,
                                  ),
                                  builder: (context, child) {
                                    return Transform.rotate(
                                      angle:
                                          math.pi * animationController.value,
                                      child: child,
                                    );
                                  }),
                            ),
                          ),
                          SizeTransition(
                            sizeFactor: animationController,
                            axisAlignment: -1,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SecondaryButton(
                                      label: "Descrição Det.",
                                      onTap: () {},
                                      height: 55,
                                      width: (maxWidth(context) - 30) / 2,
                                      icon: "description",
                                      bottom: 10,
                                    ),
                                    SecondaryButton(
                                      label: "Desco. Rateado",
                                      onTap: () {},
                                      height: 55,
                                      width: (maxWidth(context) - 30) / 2,
                                      icon: "discounts",
                                      bottom: 10,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SecondaryButton(
                                      label: "Inserir Produto",
                                      onTap: () {},
                                      height: 55,
                                      width: (maxWidth(context) - 30) / 2,
                                      icon: "insert_product",
                                      bottom: 10,
                                    ),
                                    SecondaryButton(
                                      label: "Desconto",
                                      onTap: () {},
                                      height: 55,
                                      width: (maxWidth(context) - 30) / 2,
                                      icon: "discounts",
                                      bottom: 10,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        AnimatedBuilder(
          animation: floatController,
          child: Column(
            children: [
              CustomFloatButton(
                  icon: Icons.more_vert, onTap: () => animateSlider()
                  //  Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const HoursCounter(),
                  //   ),
                  // ),
                  ),
            ],
          ),
          builder: (context, child) {
            return Positioned(
              right: 20,
              bottom: 33,
              child: Visibility(
                visible: floatController.value < 1,
                child: Opacity(
                  opacity: 1 - floatController.value,
                  child: child!,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
