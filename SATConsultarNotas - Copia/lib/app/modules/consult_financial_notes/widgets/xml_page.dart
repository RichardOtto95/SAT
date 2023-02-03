import 'package:comum/utilities/utilities.dart';
import 'package:comum/widgets/default_app_bar.dart';
import 'package:comum/widgets/default_text_field.dart';
import 'package:flutter/material.dart';

class XMLPage extends StatelessWidget {
  const XMLPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const DefaultAppBar(
            title: "Visualizar XML",
          ),
          vSpace(15),
        ],
      ),
    );
  }
}
