import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sat_fornecedores/app/constants/properties.dart';
import 'package:sat_fornecedores/app/shared/utilities.dart';

class ConfirmPopup extends StatefulWidget {
  final String text;
  final void Function() onConfirm;
  final void Function() onBack;

  const ConfirmPopup({
    Key? key,
    required this.text,
    required this.onConfirm,
    required this.onBack,
  }) : super(key: key);

  @override
  State<ConfirmPopup> createState() => _ConfirmPopupState();
}

class _ConfirmPopupState extends State<ConfirmPopup>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);
    animateTo(1);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Future animateTo(double value) async => await controller.animateTo(value,
      duration: const Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: maxHeight(context),
      width: maxWidth(context),
      child: Material(
        color: Colors.transparent,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  double value = controller.value;
                  return GestureDetector(
                    onTap: () async {
                      await animateTo(0);
                      widget.onBack();
                    },
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: (2 * value) + .001,
                        sigmaY: (2 * value) + .001,
                      ),
                      child: Container(
                        height: maxHeight(context),
                        width: maxWidth(context),
                        color:
                            getColors(context).shadow.withOpacity(.3 * value),
                      ),
                    ),
                  );
                }),
            ScaleTransition(
              scale: controller,
              child: Container(
                width: wXD(380, context),
                height: wXD(172, context),
                padding: EdgeInsets.all(wXD(25, context)),
                decoration: BoxDecoration(
                  borderRadius: defBorderRadius(context),
                  color: getColors(context).surface,
                  boxShadow: [defBoxShadow(context)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: wXD(330, context),
                      child: Text(
                        widget.text,
                        style: getStyles(context).displayLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    vSpace(wXD(25, context)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PopupButton(
                          onTap: () async {
                            await animateTo(0);
                            widget.onConfirm();
                          },
                        ),
                        hSpace(wXD(60, context)),
                        PopupButton(
                          inverse: true,
                          onTap: () async {
                            await animateTo(0);
                            widget.onBack();
                          },
                        ),
                      ],
                    )
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

class PopupButton extends StatelessWidget {
  final bool inverse;
  final void Function() onTap;

  const PopupButton({Key? key, this.inverse = false, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: wXD(45, context),
        width: wXD(80, context),
        decoration: BoxDecoration(
          color:
              inverse ? getColors(context).primary : getColors(context).surface,
          borderRadius: BorderRadius.circular(wXD(9, context)),
          boxShadow: [defBoxShadow(context)],
        ),
        alignment: Alignment.center,
        child: Text(
          inverse ? "Não" : "Sim",
          style: getStyles(context).displayMedium?.copyWith(
                color: inverse
                    ? getColors(context).onPrimary
                    : getColors(context).primary,
              ),
        ),
      ),
    );
  }
}
