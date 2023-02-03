import 'package:flutter/material.dart';
import 'package:comum/constantes.dart';

class BaseLayout extends StatelessWidget {
  final List<Widget>? appBarActions;
  final Widget body;
  final Widget? floatingActionButton;
  final String title;
  final String subtitle;
  final Widget? customtitle;
  final Widget? drawer;
  final bool centerTitle;
  final double titleSize;
  final Color titleColor;
  final Color gradientColor;
  final double sizeRatio;
  final Widget? rodape;
  final Widget? leading;
  final PreferredSizeWidget? tabs;
  final double subtitleSize;
  final bool resizeToAvoidBottom;
  final bool automaticallyImplyLeading;
  final GlobalKey<ScaffoldState>? scaffoldkey;

  const BaseLayout(
      {Key? key,
      required this.body,
      this.floatingActionButton,
      this.title = "",
      this.customtitle,
      this.drawer,
      this.tabs,
      this.appBarActions,
      this.centerTitle = false,
      this.titleSize = 22,
      this.subtitle = "",
      this.automaticallyImplyLeading = true,
      this.gradientColor = Cores.azul,
      this.titleColor = Cores.branco,
      this.rodape,
      this.sizeRatio = 0.155,
      this.leading,
      this.scaffoldkey,
      this.resizeToAvoidBottom = false,
      this.subtitleSize = 14})
      : super(key: key);

  @override
  Widget build(context) {
    return Scaffold(
      key: scaffoldkey,
      floatingActionButton: floatingActionButton,
      resizeToAvoidBottomInset: resizeToAvoidBottom,
      appBar: AppBar(
        actions: appBarActions,
        leading: leading,
        centerTitle: centerTitle,
        backgroundColor: gradientColor,
        titleSpacing: 0,
        iconTheme: IconThemeData(color: titleColor),
        bottom: tabs,
        automaticallyImplyLeading: automaticallyImplyLeading,
        // ignore: prefer_if_null_operators
        title: (customtitle != null
            ? customtitle
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: titleSize,
                      color: titleColor,
                      fontFamily: 'Oxygen',
                    ),
                  ),
                  if (subtitle.isNotEmpty)
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: subtitleSize,
                        color: titleColor,
                        fontFamily: 'Oxygen',
                        fontWeight: FontWeight.w300,
                      ),
                    )
                ],
              )),
      ),
      drawer: drawer,
      body: body,
      bottomNavigationBar: rodape ?? const SizedBox.shrink(),
    );
  }
}
