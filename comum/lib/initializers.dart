import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartpos_flutter/models/dados_automacao.dart';
import 'package:smartpos_flutter/smartpos_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'constantes.dart';
import 'funcoes.dart';
import 'sharedpreferences_utils.dart';
import 'data_structures.dart';

Future<void> initSAT() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceUtils.init();
  await precachePicture(
      ExactAssetPicture(
          SvgPicture.svgStringDecoderBuilder, './assets/logo.svg'),
      null);
  await precachePicture(
      ExactAssetPicture(
          SvgPicture.svgStringDecoderBuilder, './assets/logo_min.svg'),
      null);
  ConnectionData.chave = await Funcoes.getId();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  isElgin = (kIsWeb ? false : await ElginPAY.isElginPOS());

  if (isElgin) {
    await ElginPAY.init(
      DadosAutomacao(
        nomeAutomacao: "SAT Sistemas",
        versaoAutomacao: versaoSAT,
        empresaAutomacao: "SAT Sistemas",
      ),
    );
  }

  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..maskColor = Colors.black87
    ..userInteractions = false
    ..dismissOnTap = false;
}
