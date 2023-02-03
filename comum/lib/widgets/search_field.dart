import 'package:flutter/material.dart';

import '../../constants/properties.dart';
import '../utilities/utilities.dart';

class SearchField extends StatefulWidget {
  final FocusNode focus;

  final bool filter;

  final String? hint;

  final void Function() onFilter;

  final double? width;

  final double? height;

  final EdgeInsets? margin;

  const SearchField({
    super.key,
    required this.focus,
    this.hint,
    this.filter = true,
    required this.onFilter,
    this.width,
    this.height,
    this.margin,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField>
    with SingleTickerProviderStateMixin {
  late final AnimationController animation;

  @override
  void initState() {
    animation = AnimationController(
      vsync: this,
      value: 0,
      duration: const Duration(milliseconds: 300),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 50,
      width: widget.width ?? maxWidth(context) - 20,
      margin: widget.margin ??
          const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: getColors(context).surface,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: getColors(context).primaryContainer),
        boxShadow: [defBoxShadow(context)],
      ),
      child: Material(
        color: Colors.transparent,
        child: Row(
          children: [
            IconButton(
              icon: AnimatedIcon(
                icon: AnimatedIcons.search_ellipsis,
                color: getColors(context).onSurface,
                size: 30,
                progress: animation,
              ),
              onPressed: () => animation.value == 1
                  ? animation.reverse()
                  : animation.forward(),
            ),
            Flexible(
              child: TextField(
                focusNode: widget.focus,
                style: getStyles(context)
                    .displayMedium
                    ?.copyWith(color: getColors(context).onSurface),
                decoration: InputDecoration.collapsed(
                  hintText:
                      widget.hint ?? "Buscarpor código, nome, preço, etc.",
                  hintStyle: getStyles(context).displayMedium?.copyWith(
                      color: getColors(context).onSurface.withOpacity(.4)),
                ),
              ),
            ),
            if (widget.filter)
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    // late OverlayEntry filterOverlay;
                    // filterOverlay = OverlayEntry(
                    //   builder: (context) {
                    //     return FilterOverlay(
                    //       onBack: () => filterOverlay.remove(),
                    //     );
                    //   },
                    // );
                    // Overlay.of(context)?.insert(filterOverlay);
                    widget.onFilter();
                  },
                  borderRadius:
                      const BorderRadius.horizontal(right: Radius.circular(13)),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(
                                color: getColors(context).primaryContainer))),
                    child: Icon(
                      Icons.filter_alt_outlined,
                      size: 30,
                      color: getColors(context).primary,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
