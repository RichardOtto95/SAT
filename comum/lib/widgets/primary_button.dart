import 'package:flutter/material.dart';
import '../utilities/utilities.dart';

class PrimaryButton extends StatefulWidget {
  final String label;
  final void Function() onTap;
  final double width;

  PrimaryButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.width = 175,
  }) : super(key: key);

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, stateSet) {
        return Listener(
          onPointerDown: (_) => stateSet(() => pressed = true),
          onPointerUp: (_) => Future.delayed(const Duration(milliseconds: 100),
              () => stateSet(() => pressed = false)),
          child: GestureDetector(
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              height: 65,
              width: widget.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: getColors(context).onPrimary,
                  width: 2,
                ),
                color: pressed
                    ? getColors(context).secondary
                    : getColors(context).primary,
                boxShadow: [
                  BoxShadow(
                    blurRadius: pressed ? 1 : 5,
                    offset: pressed ? Offset(0, 1) : Offset(0, 5),
                    color: getColors(context).shadow,
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                widget.label,
                style: getStyles(context).titleMedium?.copyWith(
                      color: getColors(context).onPrimary,
                    ),
              ),
            ),
          ),
        );
      },
    );
  }
}
