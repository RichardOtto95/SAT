import 'dart:ui';

import 'package:flutter/material.dart';

import '../constants/properties.dart';
import '../utilities/utilities.dart';

class ConfirmPopup extends StatefulWidget {
  final String text;
  final void Function() onConfirm;
  final void Function() onBack;
  final double? height;
  final double? width;

  const ConfirmPopup({
    Key? key,
    required this.text,
    required this.onConfirm,
    required this.onBack,
    this.height,
    this.width,
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
                      color: getColors(context).shadow.withOpacity(.3 * value),
                    ),
                  ),
                );
              },
            ),
            ScaleTransition(
              scale: controller,
              child: Container(
                width: widget.width ?? 380,
                height: widget.height ?? 172,
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  borderRadius: defBorderRadius(context),
                  color: getColors(context).surface,
                  boxShadow: [defBoxShadow(context)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 330,
                      child: Text(
                        widget.text,
                        style: getStyles(context).displayLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    vSpace(25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PopupButton(
                          onTap: () async {
                            await animateTo(0);
                            widget.onConfirm();
                          },
                        ),
                        hSpace(60),
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

class PopupButton extends StatefulWidget {
  final bool inverse;
  final void Function() onTap;

  const PopupButton({super.key, this.inverse = false, required this.onTap});

  @override
  State createState() => PopupButtonState();
}

class PopupButtonState extends State<PopupButton> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: widget.inverse
              ? getColors(context).primary
              : getColors(context).surface,
          borderRadius: BorderRadius.circular(9),
          boxShadow: [
            BoxShadow(
              blurRadius: pressed ? 1 : 3,
              offset: Offset(0, pressed ? 1 : 3),
              color: getColors(context).shadow,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: GestureDetector(
          onPanCancel: () => setState(() => pressed = false),
          onTapCancel: () => setState(() => pressed = false),
          onLongPressCancel: () => setState(() => pressed = false),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onTap,
              borderRadius: BorderRadius.circular(9),
              onTapDown: (details) => setState(() => pressed = true),
              onTapUp: (details) => setState(() => pressed = false),
              onTapCancel: () => setState(() => pressed = false),
              child: Container(
                height: 45,
                width: 80,
                alignment: Alignment.center,
                child: Text(
                  widget.inverse ? "Não" : "Sim",
                  style: getStyles(context).displayMedium?.copyWith(
                        color: widget.inverse
                            ? getColors(context).onPrimary
                            : getColors(context).primary,
                      ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
