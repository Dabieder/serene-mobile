import 'dart:async';

import 'package:flutter/services.dart';

class Speechrecognition {

  static String TEST_STRING = "TEST STRING";

  static const MethodChannel _channel =
      const MethodChannel('speechrecognition');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}