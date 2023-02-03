import 'package:flutter/material.dart';
import 'package:sat_movimento_de_caixa/app/shared/utilities.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final double? height;
  final double? width;

  PrimaryButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.height,
    this.width,
  }) : super(key: key);

  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, stateSet) {
      return Listener(
        onPointerDown: (_) => stateSet(() => pressed = true),
        onPointerUp: (_) => Future.delayed(const Duration(milliseconds: 100),
            () => stateSet(() => pressed = false)),
        child: GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            height: height ?? 65,
            width: width ?? 175,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white),
              color: pressed
                  ? getColors(context).secondary
                  : getColors(context).primary,
              boxShadow: [
                BoxShadow(
                  blurRadius: pressed ? 1 : 5,
                  offset: pressed ? const Offset(0, 1) : const Offset(0, 5),
                  color: getColors(context).shadow,
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              title,
              style: getStyles(context).titleMedium,
            ),
          ),
        ),
      );
    });
  }
}
