import 'package:comum/constants/properties.dart';
import 'package:comum/utilities/utilities.dart';
import 'package:flutter/material.dart';

class FloatButtonTextField extends StatefulWidget {
  const FloatButtonTextField({
    super.key,
    required this.label,
    this.hint = "",
    this.data = '',
    this.width,
    this.focusNode,
    this.infoLines = 8,
    this.controller,
    this.onTap,
    this.icon,
  });

  final TextEditingController? controller;
  final String label;
  final String hint;
  final String data;
  final int infoLines;
  final double? width;
  final FocusNode? focusNode;
  final Widget? icon;
  final void Function()? onTap;

  @override
  State<FloatButtonTextField> createState() => _FloatButtonTextFieldState();
}

class _FloatButtonTextFieldState extends State<FloatButtonTextField> {
  late final FocusNode focusNode;

  @override
  void initState() {
    focusNode = widget.focusNode ?? FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: widget.width ?? maxWidth(context) - 30,
            height: 55,
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 3),
            decoration: BoxDecoration(
              border: Border.all(color: getColors(context).onPrimaryContainer),
              borderRadius: BorderRadius.circular(14),
              color: getColors(context).surface,
              boxShadow: [defBoxShadow(context)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.label,
                  style: getStyles(context).labelMedium?.copyWith(
                        color: getColors(context).primary,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                ),
                vSpace(4),
                Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 3),
                    child: Text(
                      widget.data,
                      style: getStyles(context).displayMedium?.copyWith(
                            color: const Color(0xff129444),
                          ),
                    )
                    // TextFormField(

                    //   enabled: false,
                    //   initialValue:
                    //       (widget.controller == null ? widget.data : null),
                    //   controller: widget.controller,
                    //   style: getStyles(context).labelMedium?.copyWith(
                    //         color: getColors(context).onBackground,
                    //       ),
                    //   decoration:
                    //       InputDecoration.collapsed(hintText: widget.hint),
                    // ),
                    ),
              ],
            ),
          ),
          if (widget.onTap != null)
            Positioned(
              right: 3,
              top: 15,
              child: widget.icon ??
                  Icon(
                    Icons.arrow_drop_down_rounded,
                    size: 30,
                    color: getColors(context).primary,
                  ),
            ),
        ],
      ),
    );
  }
}
