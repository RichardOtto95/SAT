import 'package:flutter/material.dart';
import 'package:sat_fornecedores/app/constants/properties.dart';
import 'package:sat_fornecedores/app/shared/utilities.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final void Function() onTap;

  PrimaryButton({
    Key? key,
    required this.title,
    required this.onTap,
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
            duration: Duration(milliseconds: 100),
            height: wXD(65, context),
            width: wXD(175, context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white),
              color: pressed
                  ? getColors(context).secondary
                  : getColors(context).primary,
              boxShadow: [
                BoxShadow(
                  blurRadius: pressed ? wXD(1, context) : wXD(5, context),
                  offset: pressed
                      ? Offset(0, wXD(1, context))
                      : Offset(0, wXD(5, context)),
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
