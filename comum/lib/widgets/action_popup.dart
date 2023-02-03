import 'package:flutter/material.dart';

import '../utilities/utilities.dart';

class ActionPopup extends StatefulWidget {
  const ActionPopup({
    super.key,
    required this.onCancel,
    required this.onConfirm,
    required this.children,
    this.height = 198,
    this.width = 328,
    this.confirmLabel = "Confirmar",
  });

  final void Function() onCancel;
  final void Function() onConfirm;
  final List<Widget> children;
  final double height;
  final double width;
  final String confirmLabel;

  @override
  State<ActionPopup> createState() => _ActionPopupState();
}

class _ActionPopupState extends State<ActionPopup> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: maxWidth(context),
          height: maxHeight(context),
        ),
        Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
              color: getColors(context).surface,
              borderRadius: BorderRadius.circular(21),
              border: Border.all(
                color: getColors(context).primaryContainer,
              )),
          child: Material(
            color: Colors.transparent,
            child: Column(
              children: [
                ...widget.children,
                Container(
                  height: 1,
                  width: widget.width,
                  color: getColors(context).primaryContainer,
                ),
                Row(
                  children: [
                    getButton(
                      "Cancelar",
                      widget.onCancel,
                      red: true,
                    ),
                    Container(
                      height: 50,
                      width: 1,
                      color: getColors(context).primaryContainer,
                    ),
                    getButton(
                      widget.confirmLabel,
                      widget.onConfirm,
                      left: false,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget getButton(String label, void Function() onTap,
      {bool red = false, bool left = true}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(left ? 21 : 0),
          bottomRight: Radius.circular(left ? 0 : 21),
        ),
        child: Container(
          color: Colors.transparent,
          height: 50,
          width: double.infinity,
          child: Center(
            child: Text(
              label,
              style: getStyles(context).titleSmall?.copyWith(
                    color: red
                        ? Colors.redAccent[700]
                        : getColors(context).primary,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
