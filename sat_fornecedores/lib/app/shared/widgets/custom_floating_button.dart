import 'package:flutter/material.dart';
import 'package:sat_fornecedores/app/constants/properties.dart';
import 'package:sat_fornecedores/app/shared/utilities.dart';

class CustomFloatButton extends StatelessWidget {
  final IconData icon;
  final void Function() onTap;
  const CustomFloatButton({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Material(
        color: Colors.transparent,
        child: Container(
          height: wXD(60, context),
          width: wXD(60, context),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: getColors(context).surface,
              boxShadow: [defBoxShadow(context)]),
          alignment: Alignment.center,
          child: Icon(
            icon,
            color: getColors(context).primary,
            size: wXD(35, context),
          ),
        ),
      ),
    );
  }
}
