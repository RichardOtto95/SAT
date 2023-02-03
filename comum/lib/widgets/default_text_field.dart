// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../constants/properties.dart';
import '../utilities/utilities.dart';

import 'info_widget.dart';

class DefaultTextField extends StatefulWidget {
  const DefaultTextField({
    super.key,
    required this.label,
    this.hint = "",
    this.data,
    this.width,
    this.height,
    this.focusNode,
    this.info,
    this.infoLines = 8,
    this.controller,
    this.bottom,
    this.isBlue = false,
    this.textColor,
    this.dropDown = false,
    this.dropDownOptions = const [],
    this.left,
    this.right,
    this.enabled = true,
    this.onTap,
  });

  final TextEditingController? controller;
  final String label;
  final String hint;
  final String? data;
  final String? info;
  final int infoLines;
  final double? width;
  final double? height;
  final double? bottom;
  final double? left;
  final double? right;
  final bool isBlue;
  final bool enabled;
  final FocusNode? focusNode;
  final Color? textColor;
  final void Function()? onTap;

  /// Set the type for drop down menu
  final bool dropDown;

  /// Options displayed on dropdown
  final List<String> dropDownOptions;

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final FocusNode focusNode;

  int itemSelected = 0;

  late OverlayEntry dropDownOverlay;

  final _layerLink = LayerLink();

  final containerKey = GlobalKey();

  TextEditingController? textEditingController;

  double width = 100;

  bool hasTap = false;

  @override
  void initState() {
    if (widget.onTap != null || widget.dropDown == true) hasTap = true;
    focusNode = widget.focusNode ?? FocusNode();

    if (hasTap) {
      itemSelected = widget.data != null
          ? widget.dropDownOptions.indexOf(widget.data!)
          : 0;
    }

    _controller = AnimationController(vsync: this, value: 0);

    textEditingController = widget.controller ??
        TextEditingController(
          text: widget.data,
        );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      width = containerKey.currentContext?.size?.width ?? widget.width ?? 100;
    });

    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  Future<void> animateTo(double value) async =>
      await _controller.animateTo(value,
          duration: const Duration(milliseconds: 350),
          curve: Curves.decelerate);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: widget.left ?? (widget.info != null ? 10 : 0),
            right: widget.right ?? (widget.info != null ? 10 : 0),
            bottom: widget.bottom ?? 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: widget.isBlue
                        ? getColors(context).primaryVariant
                        : getColors(context).onPrimaryContainer,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  color: widget.isBlue
                      ? getColors(context).secondaryVariant
                      : Colors.transparent,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: widget.dropDown
                        ? () {
                            dropDownOverlay = getOverlay();
                            Overlay.of(context)!.insert(dropDownOverlay);
                            animateTo(1.0);
                          }
                        : widget.onTap,
                    borderRadius: BorderRadius.circular(14),
                    child: CompositedTransformTarget(
                      link: _layerLink,
                      child: Container(
                        key: containerKey,
                        width: widget.width ?? maxWidth(context) - 20,
                        height: widget.height ?? 55,
                        padding: const EdgeInsets.fromLTRB(12, 4, 12, 3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  widget.label,
                                  style:
                                      getStyles(context).labelMedium?.copyWith(
                                            color: widget.enabled
                                                ? getColors(context).primary
                                                : getColors(context).onSurface,
                                          ),
                                  maxLines: 1,
                                  // overflow: TextOverflow.ellipsis,
                                  // softWrap: false,
                                ),
                              ),
                            ),
                            vSpace(4),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8, bottom: 3),
                              child: TextFormField(
                                enabled: !hasTap,
                                controller: textEditingController,
                                style: getStyles(context).labelMedium?.copyWith(
                                      color: widget.textColor ??
                                          getColors(context).onBackground,
                                    ),
                                decoration: InputDecoration.collapsed(
                                    hintText: widget.hint),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (widget.info != null) vSpace(7),
              if (widget.info != null)
                InfoWidget(
                  info: widget.info!,
                  infoLines: 2,
                ),
            ],
          ),
        ),
        if (widget.onTap != null)
          Positioned(
            right: widget.info != null ? 23 : -3,
            top: 5,
            child: IconButton(
              onPressed: widget.onTap,
              icon: Icon(
                Icons.more_vert_rounded,
                size: 23,
                color: widget.enabled
                    ? getColors(context).primary
                    : getColors(context).onSurface,
              ),
            ),
          ),
        if (widget.dropDown)
          Positioned(
            right: widget.info != null ? 23 : 3,
            top: 5,
            child: IconButton(
              onPressed: () {
                dropDownOverlay = getOverlay();
                Overlay.of(context)!.insert(dropDownOverlay);
                animateTo(1.0);
              },
              icon: Icon(
                Icons.arrow_drop_down_rounded,
                size: 30,
                color: widget.enabled
                    ? getColors(context).primary
                    : getColors(context).onSurface,
              ),
            ),
          ),
      ],
    );
  }

  OverlayEntry getOverlay() {
    List<String> overlayData = [];

    for (int i = 0; i < widget.dropDownOptions.length; i++) {
      if (i != itemSelected) {
        overlayData.add(widget.dropDownOptions[i]);
      }
    }

    return OverlayEntry(builder: (context) {
      return Positioned(
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
                offset: Offset(-5, widget.height ?? 55),
                child: SizeTransition(
                  sizeFactor: _controller,
                  axisAlignment: 1,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      width: width,
                      // padding: EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5),
                      constraints: const BoxConstraints(
                        minHeight: 60,
                        maxHeight: 150,
                      ),
                      decoration: BoxDecoration(
                        color: getColors(context).surface,
                        boxShadow: [defBoxShadow(context)],
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: overlayData
                              .map(
                                (e) => InkWell(
                                  onTap: () async {
                                    setState(() => itemSelected =
                                        widget.dropDownOptions.indexOf(e));
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
                                              color:
                                                  getColors(context).primary),
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
              ),
            ],
          ),
        ),
      );
    });
  }
}
