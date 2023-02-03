import 'package:flutter/material.dart';
import '../utilities/utilities.dart';

class DefaultTitle extends StatelessWidget {
  const DefaultTitle({
    super.key,
    required this.title,
    this.top = 5,
    this.bottom = 15,
    this.isLeft = false,
    this.fontSize = 23,
    this.left = 20,
    this.width,
  });

  final String title;

  /// Tamanho da caixa do texto
  final double? width;

  /// Altera o tamanho da fonte do título
  final double fontSize;

  /// Já é responsivo, não precisa passar a função wXD
  final double top;

  /// Já é responsivo, não precisa passar a função wXD
  final double bottom;

  /// Já é responsivo, não precisa passar a função wXD
  final double left;

  /// Alinha o texto para a esquerda
  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? maxWidth(context),
      padding: EdgeInsets.only(
        top: top,
        bottom: bottom,
        right: left,
        left: left,
      ),
      alignment: isLeft ? Alignment.centerLeft : Alignment.center,
      child: Text(
        title,
        style: getStyles(context).titleLarge?.copyWith(
              fontSize: fontSize,
            ),
        textAlign: TextAlign.center,
        maxLines: 2,
      ),
    );
  }
}
