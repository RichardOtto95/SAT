import 'package:flutter/material.dart';
import 'package:sat_movimento_de_caixa/app/shared/widgets/info.dart';

import '../utilities.dart';

class DefaultTextField extends StatefulWidget {
  const DefaultTextField({
    super.key,
    required this.label,
    this.hint = "",
    this.data,
    this.width,
    this.onFocus,
    this.focusNode,
    this.info,
    this.infoLines = 8,
    this.bottom,
    this.isBlue = false,
    this.color,
  });

  final String label;
  final String hint;
  final String? data;
  final Color? color;
  final String? info;
  final int infoLines;
  final double? width;
  final double? bottom;
  final bool isBlue;
  final FocusNode? focusNode;
  final void Function()? onFocus;

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  late final FocusNode focusNode;

  @override
  void initState() {
    focusNode = widget.focusNode ?? FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(
            right: widget.info != null ? 20 : 0,
            left: widget.info != null ? 20 : 0,
            bottom: widget.bottom ?? 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: widget.width ?? maxWidth(context) - 30,
                // height: 63,
                padding: const EdgeInsets.fromLTRB(12, 4, 12, 3),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: widget.isBlue
                          ? getColors(context).primaryVariant
                          : getColors(context).onPrimaryContainer),
                  borderRadius: BorderRadius.circular(14),
                  color: widget.isBlue
                      ? getColors(context).secondaryVariant
                      : Colors.transparent,
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
                    // Spacer(),
                    vSpace(4),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, bottom: 3),
                      child: TextFormField(
                        initialValue: widget.data,
                        style: getStyles(context).labelMedium?.copyWith(
                              color: widget.color ??
                                  getColors(context).onBackground,
                            ),
                        decoration:
                            InputDecoration.collapsed(hintText: widget.hint),
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.info != null) vSpace(7),
              if (widget.info != null)
                InfoWidget(
                  info: widget.info!,
                  infoLines: 1,
                ),
            ],
          ),
        ),
        if (widget.onFocus != null)
          Positioned(
            right: widget.info != null ? 23 : 3,
            top: 12,
            child: Icon(
              Icons.arrow_drop_down_rounded,
              size: 30,
              color: getColors(context).primary,
            ),
          ),
      ],
    );
  }
}
