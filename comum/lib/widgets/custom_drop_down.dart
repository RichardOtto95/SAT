import 'package:flutter/material.dart';

import '../../constants/properties.dart';
import 'dart:math' as math;

import '../utilities/utilities.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({
    super.key,
    required this.items,
    required this.onChanged,
    required this.width,
    this.value,
    this.left,
    this.right,
  });
  // : assert(
  //         (value != null && items.contains(value)),
  //         "Valor inicial não encontrado nos itens",
  //       );

  final double width;

  final double? left;

  final double? right;

  final List<String> items;

  final String? value;

  final void Function(String item) onChanged;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  int itemSelected = 0;

  final dropDownKey = GlobalKey();

  final _layerLink = LayerLink();

  late OverlayEntry dropDownOverlay;

  @override
  void initState() {
    itemSelected =
        widget.value != null ? widget.items.indexOf(widget.value!) : 0;
    _controller = AnimationController(vsync: this, value: 0);
    super.initState();
  }

  Future<void> animateTo(double value) async =>
      await _controller.animateTo(value,
          duration: const Duration(milliseconds: 350),
          curve: Curves.decelerate);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            dropDownOverlay = getOverlay();
            Overlay.of(context)!.insert(dropDownOverlay);
            animateTo(1.0);
          },
          borderRadius: BorderRadius.circular(14),
          child: Container(
            height: 49,
            width: widget.width,
            padding: EdgeInsets.fromLTRB(
              widget.left ?? 16,
              0,
              widget.right ?? 16,
              0,
            ),
            alignment: Alignment.center,
            child: CompositedTransformTarget(
              link: _layerLink,
              child: Container(
                key: dropDownKey,
                width: double.infinity,
                padding: const EdgeInsets.only(bottom: 7.5, left: 9, right: 9),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: getColors(context).primary,
                      width: 2,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      widget.items[itemSelected],
                      style: getStyles(context).labelMedium?.copyWith(
                            color: getColors(context).secondaryContainer,
                          ),
                    ),
                    Spacer(),
                    AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: math.pi * _controller.value,
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: getColors(context).onBackground,
                              size: 18,
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  OverlayEntry getOverlay() {
    List<String> overlayData = [];

    for (int i = 0; i < widget.items.length; i++) {
      if (i != itemSelected) {
        overlayData.add(widget.items[i]);
      }
    }

    return OverlayEntry(
      builder: (context) => Positioned(
        width: maxWidth(context),
        height: maxHeight(context),
        child: Material(
          color: Colors.transparent,
          child: Stack(
            children: [
              GestureDetector(
                onTap: () async {
                  await animateTo(0);
                  dropDownOverlay.remove();
                },
                child: Container(
                  color: Colors.transparent,
                  height: maxHeight(context),
                  width: maxWidth(context),
                ),
              ),
              CompositedTransformFollower(
                link: _layerLink,
                offset: const Offset(-5, 27),
                child: SizeTransition(
                  sizeFactor: _controller,
                  axisAlignment: 1,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      width: (widget.width -
                          ((widget.left ?? 16) + (widget.right ?? 16))),
                      // padding: EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5),
                      height: 10 + (overlayData.length * 31),
                      decoration: BoxDecoration(
                        color: getColors(context).surface,
                        boxShadow: [defBoxShadow(context)],
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: overlayData
                            .map(
                              (e) => InkWell(
                                onTap: () async {
                                  setState(() =>
                                      itemSelected = widget.items.indexOf(e));
                                  await animateTo(0);
                                  dropDownOverlay.remove();
                                },
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(
                                        overlayData.indexOf(e) == 0 ? 9 : 0),
                                    bottom: Radius.circular(
                                        overlayData.indexOf(e) ==
                                                (overlayData.length - 1)
                                            ? 9
                                            : 0)),
                                child: Container(
                                  padding: const EdgeInsets.only(left: 5),
                                  height: 31,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    e,
                                    style: getStyles(context)
                                        .labelMedium
                                        ?.copyWith(
                                            color: getColors(context).primary),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
