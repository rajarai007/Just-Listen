import 'package:flutter/services.dart';

class APIGuard{
  static const platform = MethodChannel("com.f5.apiguard/bot-defense");

  static Future<bool> isReady() async {
    bool isAPIGuardReady = false;
    try{
      isAPIGuardReady = await platform.invokeMethod("isAPIGuardReady");
    } on PlatformException catch (e){
      print(e.message);
    }
    return isAPIGuardReady;
  }

  static Future<Map<String, String>> getRequestHeaders(String url, String body) async{
    Map<String, String> _apiguard_headers = {};
    try{
      await platform.invokeMethod("getRequestHeaders",{"endpointURL": url, "body": body}).then((result) {
        result?.forEach((key, value) {
          print('$key: $value');
          _apiguard_headers[key] = value;
        });
      });

    } on PlatformException catch (e){
      print(e.message);
    }
    return _apiguard_headers;
  }

  static Future<void> parseResponseHeaders(Map<String, String> responseHeaders) async{
    try{
      await platform.invokeMethod("parseResponseHeaders", {"responseHeaders": responseHeaders}).then((result){
        print(result);
      });
    } on PlatformException catch (e){
      print(e.message);
    }
  }
}