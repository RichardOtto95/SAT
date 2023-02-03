import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/properties.dart';

import 'dart:math' as math;

import '../utilities.dart';
import 'custom_check.dart';
import 'info.dart';

class SecondaryButton extends StatefulWidget {
  /// Somente o nome do arquivo sem sua extensão
  final String? icon;
  final String label;
  final String? info;
  final void Function() onTap;
  final double? width;
  final double? height;
  final List<Map<String, bool>>? items;
  final void Function(int index)? onSelect;

  const SecondaryButton({
    super.key,
    this.icon,
    required this.label,
    required this.onTap,
    this.info,
    this.width,
    this.height,
    this.items,
    this.onSelect,
  });

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late OverlayEntry menuOverlay;

  final _layerLink = LayerLink();
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool pressed = false;

  Future<void> animateTo(double value) async =>
      await _controller.animateTo(value,
          duration: const Duration(milliseconds: 350),
          curve: Curves.decelerate);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CompositedTransformTarget(
                link: _layerLink,
                child: GestureDetector(
                  onPanDown: (details) => setState(() => pressed = true),
                  onTapUp: (details) =>
                      setState(() => pressed ? pressed = false : null),
                  onPanCancel: () =>
                      setState(() => pressed ? pressed = false : null),
                  onTap: widget.items != null
                      ? () {
                          menuOverlay = getOverlay();
                          Overlay.of(context)!.insert(menuOverlay);
                          animateTo(1);
                        }
                      : widget.onTap,
                  child: Container(
                    width: widget.width ?? 388,
                    height: widget.height,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: getColors(context).onBackground.withOpacity(.3),
                      ),
                      borderRadius: BorderRadius.circular(13),
                      color: getColors(context).onSurfaceVariant,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: pressed ? 0 : 6,
                          offset: pressed ? Offset(0, 0) : Offset(0, 3),
                          color: getColors(context).shadow,
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: SizedBox(
                      // width: 330,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "./assets/svg/${widget.icon ?? "edit"}.svg",
                            width: 24,
                          ),
                          hSpace(10),
                          Text(
                            widget.label,
                            style: getStyles(context).labelMedium?.copyWith(
                                  color: getColors(context).onBackground,
                                  fontWeight: FontWeight.w500,
                                ),
                            maxLines: 2,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (widget.items != null && widget.items!.isNotEmpty)
                Positioned(
                  right: 10,
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: math.pi * _controller.value,
                        child: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 30,
                          color: getColors(context).secondaryContainer,
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
          if (widget.info != null) vSpace(7),
          if (widget.info != null)
            InfoWidget(
              info: widget.info!,
            )
        ],
      ),
    );
  }

  OverlayEntry getOverlay() {
    return OverlayEntry(
      maintainState: true,
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
                  menuOverlay.remove();
                },
                child: Container(
                  color: Colors.transparent,
                  height: maxHeight(context),
                  width: maxWidth(context),
                ),
              ),
              CompositedTransformFollower(
                link: _layerLink,
                offset: const Offset(-5, 55),
                child: SizeTransition(
                  sizeFactor: _controller,
                  axisAlignment: 1,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      width: widget.width ?? 388,
                      // padding: EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5),
                      height: (widget.items!.length * 60),
                      decoration: BoxDecoration(
                        color: getColors(context).surface,
                        boxShadow: [defBoxShadow(context)],
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: StatefulBuilder(builder: (context, stateSet) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: widget.items!
                              .map(
                                (e) => Container(
                                  height: 60,
                                  alignment: Alignment.centerLeft,
                                  child: CustomCheck(
                                    text: e.keys.first,
                                    checked: e.values.first,
                                    onTap: () => stateSet(() {
                                      widget
                                          .onSelect!(widget.items!.indexOf(e));
                                    }),
                                    fontSize: 14.5,
                                    left: 10,
                                    textWidth: 340,
                                  ),
                                ),
                                // InkWell(
                                //   onTap: () =>
                                //       widget.onSelect!(widget.items!.indexOf(e)),
                                //   borderRadius: BorderRadius.vertical(
                                //       top: Radius.circular(
                                //           widget.items!.indexOf(e) == 0
                                //               ? 9
                                //               : 0),
                                //       bottom: Radius.circular(
                                //           widget.items!.indexOf(e) ==
                                //                   (widget.items!.length - 1)
                                //               ? 9
                                //               : 0)),
                                //   child: Container(
                                //     padding: EdgeInsets.only(
                                //       left: 5,
                                //     ),
                                //     height: 31,
                                //     alignment: Alignment.centerLeft,
                                //     child: Text(
                                //       e.keys.first,
                                //       style: getStyles(context)
                                //           .labelMedium
                                //           ?.copyWith(
                                //               color: getColors(context).primary),
                                //     ),
                                //   ),
                                // ),
                              )
                              .toList(),
                        );
                      }),
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
