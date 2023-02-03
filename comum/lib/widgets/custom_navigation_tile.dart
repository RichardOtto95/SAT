import 'package:flutter/material.dart';

import '../../constants/properties.dart';
import '../utilities/utilities.dart';

class CustomNavigationTile extends StatefulWidget {
  final List<String> tiles;
  final double horizontalPadding;
  final double width;
  final double? height;
  final int page;
  final void Function(int page) onPageChange;

  const CustomNavigationTile({
    super.key,
    required this.tiles,
    required this.horizontalPadding,
    required this.width,
    required this.onPageChange,
    required this.page,
    this.height,
  });

  @override
  State<CustomNavigationTile> createState() => CustomNavigationTileState();
}

class CustomNavigationTileState extends State<CustomNavigationTile> {
  double _page = 0;

  double? leftPosition;

  List<GlobalKey> keys = [];

  @override
  void initState() {
    for (int i = 0; i < widget.tiles.length; i++) {
      keys.add(GlobalKey());
    }
    _page = widget.page.toDouble();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   changePosition(widget.page.toInt());
    // });
    super.initState();
  }

  void changePosition(int index) {
    if (mounted) {
      setState(() {
        widget.onPageChange(index);
        _page = index.toDouble();
        RenderBox render =
            keys[index].currentContext!.findRenderObject()! as RenderBox;
        Offset offset = render.localToGlobal(Offset.zero);
        leftPosition = offset.dx + 3;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: maxWidth(context),
          child: Container(
            width: maxWidth(context),
            alignment: Alignment.center,
            child: Container(
              height: widget.height ?? 43,
              width: widget.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [defBoxShadow(context)],
                color: getColors(context).primary,
              ),
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 500),
          curve: Curves.decelerate,
          left: leftPosition ?? ((maxWidth(context) - widget.width) / 2) + 3,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.decelerate,
            height: widget.height != null ? widget.height! - 6 : 37,
            width: (widget.width / widget.tiles.length) - 6,
            decoration: BoxDecoration(
              color: getColors(context).onPrimary,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [defBoxShadow(context)],
            ),
          ),
        ),
        Container(
          width: maxWidth(context),
          height: widget.height ?? 43,
          alignment: Alignment.center,
          child: SizedBox(
            width: widget.width,
            child: Row(
              children: List.generate(
                widget.tiles.length,
                (index) {
                  return Expanded(
                    key: keys[index],
                    child: GestureDetector(
                      onTap: () => changePosition(index),
                      child: Container(
                        width: double.infinity,
                        height: widget.height ?? 43,
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 300),
                          style: getStyles(context).titleSmall!.copyWith(
                                color: _page == index
                                    ? getColors(context).primary
                                    : getColors(context).onPrimary,
                              ),
                          child: Text(
                            widget.tiles[index],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
