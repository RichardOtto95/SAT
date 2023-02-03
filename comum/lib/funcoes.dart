// ignore_for_file: unnecessary_null_comparison

import 'package:device_info_plus/device_info_plus.dart';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'constantes.dart';
import 'data_structures.dart';

class Funcoes {
  static bool verifyToken() {
    TokenData.load();

    if (TokenData.data[Keys.Token] == null ||
        TokenData.data[Keys.Token]!.isEmpty) return false;

    var date = DateTime.tryParse(TokenData.data[Keys.Validade]!)!.toLocal();
    if (date != null && DateTime.now().toUtc().isBefore(date)) {
      return true;
    } else {
      return false;
    }
  }

  static Future<String> getId() async {
    String? deviceIdentifier;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (kIsWeb) {
      deviceIdentifier = 'WEB';
    } else {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceIdentifier = androidInfo.id;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceIdentifier = iosInfo.identifierForVendor;
      } else if (Platform.isWindows) {
        WindowsDeviceInfo windowsInfo = await deviceInfo.windowsInfo;
        deviceIdentifier =
            base64.encode(utf8.encode(windowsInfo.computerName)).toLowerCase();
      }
    }
    return deviceIdentifier ?? '';

    // return 'WEB';
  }
}
