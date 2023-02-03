import 'package:flutter/material.dart';

import '../utilities/custom_scroll_behavior.dart';
import '../utilities/utilities.dart';
import 'container_text_field.dart';

class FilterDrawer extends StatefulWidget {
  const FilterDrawer({
    super.key,
    required this.children,
    this.width,
  });

  final List<Widget> children;

  final double? width;

  @override
  State<FilterDrawer> createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: widget.width ?? 350,
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        height: maxHeight(context) - viewPaddingTop(context),
        width: widget.width ?? 350,
        decoration: BoxDecoration(
          color: getColors(context).surface,
          borderRadius:
              const BorderRadius.horizontal(left: Radius.circular(19)),
        ),
        child: Column(
          children: [
            vSpace(40),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: getColors(context).primaryContainer,
                  ),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                "Filtros",
                style: getStyles(context).titleMedium?.copyWith(
                      color: brightness == Brightness.light
                          ? getColors(context).primary
                          : getColors(context).onBackground,
                    ),
              ),
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: CustomScrollBehavior(),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(
                    top: 15,
                    bottom: 40,
                    left: 10,
                    right: 10,
                  ),
                  child: Column(children: widget.children),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FilterField extends StatelessWidget {
  FilterField(this.title);

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: 10,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                maxLines: 2,
                style: getStyles(context).labelMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: getColors(context).primary,
                    ),
              ),
            ),
            const ContainerTextField(
              height: 44,
            ),
          ],
        ),
      );
}
