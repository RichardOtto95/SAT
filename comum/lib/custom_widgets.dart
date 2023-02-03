// ignore_for_file: deprecated_member_use

import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'constantes.dart';

// Widgets personalizados

class Gradiente extends StatelessWidget {
  final double sizeRatio;
  final Widget? child;
  final Color color;

  const Gradiente(
      {Key? key, this.sizeRatio = 0.15, this.child, this.color = Cores.azul})
      : super(key: key);

  @override
  Widget build(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height *
          (MediaQuery.of(context).orientation == Orientation.landscape
              ? sizeRatio * 1.5
              : sizeRatio),
      color: color,
      child: child,
    );
  }
}

class RoundButton extends StatelessWidget {
  final String text;
  final double? width;
  final double? height;
  final double? fontsize;
  final Icon? icon;
  final Color color;
  final VoidCallback? onPressed;

  const RoundButton(
      {Key? key,
      required this.text,
      this.width = 150,
      this.height = 32,
      this.fontsize = 14,
      this.color = Cores.azul,
      this.icon,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Theme.of(context).colorScheme.primary.withOpacity(0.5);
              } else if (states.contains(MaterialState.disabled)) {
                return Cores.azul_claro;
              }
              return color; // Use the component's default.
            },
          ),
          shape: ButtonStyleButton.allOrNull<OutlinedBorder>(
            const StadiumBorder(),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: icon,
              ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontsize,
                fontFamily: 'Oxygen',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NumberPicker extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final double value;
  final double minValue;
  final double maxValue;
  final ValueChanged<double> onChanged;

  NumberPicker({
    Key? key,
    required this.onChanged,
    this.value = 1,
    this.minValue = 1,
    this.maxValue = 999,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _controller.text = value.toString();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      width: 120,
      height: 35,
      decoration: const BoxDecoration(
        color: Cores.azul_claro,
        borderRadius: BorderRadius.all(Radius.circular(180)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 30,
            height: 30,
            child: ElevatedButton(
              onPressed: () {
                var value =
                    double.parse(_controller.text.replaceAll(',', '.')) - 1;
                if (value < minValue) return;
                _controller.text = value.toString();
                onChanged(value);
              },
              style: ElevatedButton.styleFrom(
                elevation: 4,
                primary: Colors.white,
                shape: const StadiumBorder(),
              ),
              child: const Text(
                '−',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: (kIsWeb
                      ? 10
                      : Platform.isWindows
                          ? 10
                          : 5)),
              child: TextField(
                controller: _controller,
                onChanged: (value) {
                  onChanged(double.parse(value.replaceAll(',', '.')));
                },
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 4,
                maxLines: 1,
                decoration: const InputDecoration(
                  counterText: '',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 30,
            height: 30,
            child: ElevatedButton(
              onPressed: () {
                var value =
                    double.parse(_controller.text.replaceAll(',', '.')) + 1;
                if (value > maxValue) return;
                _controller.text = value.toString();
                onChanged(value);
              },
              style: ElevatedButton.styleFrom(
                elevation: 4,
                primary: Colors.white,
                shape: const StadiumBorder(),
              ),
              child: const Text(
                '+',
                textAlign: TextAlign.center,
                style: TextStyle(
                  // fontFamily: 'Oxygen',
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
