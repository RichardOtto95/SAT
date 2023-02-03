import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);
  @override
  RootPageState createState() => RootPageState();
}

class RootPageState extends State<RootPage> {
  @override
  void initState() {
    // Modular.to.pushNamed("/answer-representative/");
    Modular.to.pushReplacementNamed("/answer-representative/");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
