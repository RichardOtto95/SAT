import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

class CustomScrollBehavior extends ScrollBehavior {
  @override
  get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };

  @override
  getScrollPhysics(BuildContext context) =>
      const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics());
}
