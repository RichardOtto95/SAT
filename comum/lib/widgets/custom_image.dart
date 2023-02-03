import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/properties.dart';
import '../utilities/utilities.dart';
import 'custom_floating_button.dart';

class CustomImage extends StatefulWidget {
  final double width;
  final double height;

  const CustomImage({
    super.key,
    this.height = 398,
    this.width = 398,
  });

  @override
  State<CustomImage> createState() => _CustomImageState();
}

class _CustomImageState extends State<CustomImage> {
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTapCancel: () => setState(() => pressed = false),
          onPanDown: (details) => setState(() => pressed = true),
          onTapUp: (details) =>
              setState(() => pressed ? pressed = false : null),
          onPanCancel: () => setState(() => pressed ? pressed = false : null),
          child: Container(
            height: widget.height,
            width: widget.width,
            decoration: BoxDecoration(
              color: getColors(context).surface,
              border: Border.all(color: getColors(context).onPrimaryContainer),
              borderRadius: BorderRadius.circular(22),
              boxShadow: [defBoxShadowMove(context, pressed)],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Image.asset(
                "./assets/img/no-image.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          right: widget.height * 0.06,
          bottom: widget.height * 0.06,
          child: CustomFloatButton(
            size: widget.height * 0.15,
            onTap: () {},
            child: SvgPicture.asset(
              "./assets/svg/camera.svg",
              width: widget.height * 0.085,
            ),
          ),
        ),
      ],
    );
  }
}
