import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AppPref {
  static Future<bool> clearSharedPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.clear();
  }

  static Future<bool> clearUserPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.remove(USER_DATA);
  }

  static Future<bool> addString(String key, String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(key, val);
  }

  static Future<bool> addInt(String key, int val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setInt(key, val);
  }

  static addBoolean(String key, bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, val);
  }

  static getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString(key) ?? "";
    return stringValue;
  }

  static getInt(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int intValue = prefs.getInt(key) ?? 0;
    return intValue;
  }

  static getBoolean(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool intValue = prefs.getBool(key) ?? false;
    return intValue;
  }

  static const String AUTH_KEY_ONE_SIGNAL = "onesignal";
  static const String AUTH_KEY_RAZORPAY = "razorpay";
  static const String USER_DATA = "userDtls";
  static const String INTRO_VIEWED = "introViewed";
  static const String EMAIL_ID = "emailId";
  static const String PASSWORD = "password";
  static const String USER_TYPE = "userType";
  static const String PURCHASE_RESTORED_WEZZEER = "purchaseRestoredWezzer";
  static const String PURCHASE_RESTORED_WOTTER = "purchaseRestoredWotter";
  static const String USER_TOKENS = "userTokens";
  static const String APP_LOCALE = "appLocale";
  static const String LOGIN_TIMESTAMP = "loginTimeStamp";

  static Future<bool> setUserData(String val) async {
    return await addString(USER_DATA, val);
  }

  static Future<bool> setUserTokenData(String val) async {
    return await addString(USER_TOKENS, val);
  }

  static setIntroViewed(bool val) {
    addBoolean(INTRO_VIEWED, val);
  }

  static setPurchaseRestoredWotter(bool val) {
    addBoolean(PURCHASE_RESTORED_WOTTER, val);
  }

  static setPurchaseRestoredWezzer(bool val) {
    addBoolean(PURCHASE_RESTORED_WEZZEER, val);
  }

  static setOneSignalKey(String val) {
    addString(AUTH_KEY_ONE_SIGNAL, val);
  }

  static setRazorpayKey(String val) {
    addString(AUTH_KEY_RAZORPAY, val);
  }

  static setEmailId(String val) {
    addString(EMAIL_ID, val);
  }

  static setPassword(String val) {
    addString(PASSWORD, val);
  }

  static Future<bool> setUserType(String val) async {
    return await addString(USER_TYPE, val);
  }

  static Future<bool> setLoginTimeStamp() async {
    final now = DateTime.now();
    final expiryTime = DateTime.utc(now.year, now.month, now.day, now.hour + 2,
        now.minute, now.second, now.millisecond);
    //log("${now.toString()} ${expiryTime.toString()}");
    return await addInt(LOGIN_TIMESTAMP, expiryTime.millisecondsSinceEpoch);
  }

  //-----------------------//

  /* static Future<Map<String, dynamic>> getRemberData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var email = pref.getString(EMAIL_ID) ?? "";
    var password = pref.getString(PASSWORD) ?? "";
    var uType = pref.getInt(USER_TYPE) ?? 0;
    return {
      Arguments.EMAIL: email,
      Arguments.PASSWORD: password,
      Arguments.USER_TYPE: uType
    };
  } */

  static Future<int> getTokenExpiryTimeStamp() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt(LOGIN_TIMESTAMP) ?? 1;
  }

  static Future<bool> getPurchaseRestoredWezzer() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(PURCHASE_RESTORED_WEZZEER) ?? false;
  }

  static Future<bool> getPurchaseRestoredWotter() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(PURCHASE_RESTORED_WOTTER) ?? false;
  }

  static Future<String> getPassword() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = pref.getString(PASSWORD);
    if (data == null) {
      return "";
    } else {
      return data;
    }
  }

  static Future<String> getOneSignalKey() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = pref.getString(AUTH_KEY_ONE_SIGNAL);
    if (data == null) {
      return "";
    } else {
      return data;
    }
  }

  static Future<String> getRazorpayKey() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = pref.getString(AUTH_KEY_RAZORPAY);
    if (data == null) {
      return "";
    } else {
      return data;
    }
  }

  static Future<String> getAppLocale() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = pref.getString(APP_LOCALE);
    return data ?? 'en';
  }

  static Future<String?> getLoginData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = pref.getString(USER_DATA);
    return data;
  }

  static Future<bool> isIntroViewed() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = pref.getBool(INTRO_VIEWED);
    if (data == null) {
      return false;
    } else {
      return data;
    }
  }
}
