import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'utils/app_theme.dart';

abstract class BaseClassStateLess extends StatelessWidget {
  BaseClassStateLess({super.key});

  var appTheme = AppTheme.theme;

  static const BOLD = 'BOLD';
  static const MEDIUM = 'MEDIUM';
  static const REGULAR = 'REGULAR';
  static const SEMI_BOLD = 'SEMI_BOLD';

  TextStyle styleRegular({double fontSize = 13}) {
    return TextStyle(fontFamily: REGULAR, fontSize: fontSize);
  }

  TextStyle styleBold({double fontSize = 13}) {
    return TextStyle(fontFamily: BOLD, fontSize: fontSize);
  }

  TextStyle styleSemiBold(
      {double fontSize = 13, TextDecoration decoration = TextDecoration.none}) {
    return TextStyle(
        fontFamily: SEMI_BOLD, fontSize: fontSize, decoration: decoration);
  }

  TextStyle styleMedium(
      {double fontSize = 13, TextDecoration? textDecoration}) {
    return TextStyle(
        fontFamily: MEDIUM, fontSize: fontSize, decoration: textDecoration);
  }

  TextStyle styleNormal({double fontSize = 13}) {
    return TextStyle(fontSize: fontSize);
  }

  TextStyle styleBoldColor(Color color,
      {double fontSize = 13,
      TextDecoration decoration = TextDecoration.none,
      double? height}) {
    return TextStyle(
      fontFamily: BOLD,
      fontSize: fontSize,
      color: color,
      decoration: decoration,
      height: height ?? 0,
    );
  }

  TextStyle styleSemiBoldColor(Color color,
      {double fontSize = 13, TextDecoration decoration = TextDecoration.none}) {
    return TextStyle(
        fontFamily: SEMI_BOLD,
        fontSize: fontSize,
        color: color,
        decoration: decoration);
  }

  TextStyle styleMediumColor(Color color,
      {double fontSize = 13,
      TextDecoration decoration = TextDecoration.none,
      double? height}) {
    return TextStyle(
        fontFamily: MEDIUM,
        fontSize: fontSize,
        color: color,
        height: height ?? 0,
        decoration: decoration);
  }

  TextStyle styleRegularColor(Color color,
      {double fontSize = 13, double? height}) {
    return TextStyle(
      fontFamily: REGULAR,
      fontSize: fontSize,
      color: color,
      height: height ?? 0,
    );
  }

  containerDecoration() {
    return BoxDecoration(
        border: Border.all(color: AppTheme.borderColor),
        color: AppTheme.boxColor,
        borderRadius: const BorderRadius.all(Radius.circular(6.0)));
  }

  inputDecoration(
      {String? label,
      String? hint,
      TextStyle? hintStyle,
      Widget? suffixIcon,
      Widget? prefixIcon,
      String? counterText,
      String? prefixText,
      TextStyle? prefixStyle,
      double hPadding = 12,
      double vPadding = 12}) {
    return InputDecoration(
        isDense: true,
        label: label != null ? Text(label) : null,
        hintText: hint,
        hintStyle: hintStyle,
        border: InputBorder.none,
        suffixIconConstraints: const BoxConstraints(),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        prefixText: prefixText,
        prefixStyle: prefixStyle,
        counterText: counterText,
        contentPadding:
            EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding));
  }

  getDecoration(
      {bool valid = true,
      Color borderColor = AppTheme.white,
      double borderRadius = 6.0}) {
    return BoxDecoration(
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 3),
              color: valid ? AppTheme.colorGrey : AppTheme.colorGrey,
              blurRadius: 5)
        ],
        border: Border.all(color: valid ? borderColor : AppTheme.colorRed),
        color: AppTheme.white,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)));
  }

  void hideKeyBoard({BuildContext? mContext}) {
    FocusScopeNode currentFocus = FocusScope.of(mContext!);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void changeSystemUiColor(
      {Color statusBarColor = AppTheme.white,
      Color navBarColor = Colors.white,
      brightness = Brightness.dark,
      navBrightness = Brightness.dark}) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: navBarColor, // navigation bar color
      statusBarColor: statusBarColor, // status bar color
      statusBarIconBrightness: brightness, // status bar icon color
      systemNavigationBarIconBrightness:
          navBrightness, // color of navigation controls
    ));
  }

  bool isProgress = false;
  void showProgress(BuildContext context, {String? progressText}) {
    isProgress = true;
    changeSystemUiColor(
        statusBarColor: Colors.transparent,
        navBarColor: AppTheme.white.withOpacity(0.9));
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
          child: progressText != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      padding: EdgeInsets.zero,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: AppTheme.colorPrimary),
                      child: const SpinKitFadingCircle(
                        color: AppTheme.white,
                        size: 34,
                      ),
                    ),
                    Text(
                      progressText,
                      style: styleRegular(fontSize: 8),
                    )
                  ],
                )
              : Container(
                  height: 40,
                  width: 40,
                  padding: EdgeInsets.zero,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      color: AppTheme.colorPrimary),
                  child: const SpinKitFadingCircle(
                    color: AppTheme.white,
                    size: 34,
                  ),
                )),
    );
    showDialog(
      //prevent outside touch
      barrierDismissible: true,
      barrierColor: AppTheme.white.withOpacity(0.9),
      context: context,
      builder: (BuildContext context) {
        //prevent Back button press
        return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: alert);
      },
    );
  }

  void hideProgress(BuildContext context,
      {bool changestatusBarColor = true,
      Color statusBarColor = AppTheme.colorPrimary}) {
    if (isProgress) {
      isProgress = false;
      // if (changestatusBarColor) {
      //   changeSystemUiColor(
      //       statusBarColor: statusBarColor, brightness: Brightness.light);
      // }
      Navigator.pop(context);
    }
  }

  bool equalsIgnoreCase(String? a, String? b) =>
      (a == null && b == null) ||
      (a != null && b != null && a.toLowerCase() == b.toLowerCase());

  getBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        width: 1,
        color: color,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.circular(100.0),
    );
  }

  Widget getVerticalGap({double height = 20}) {
    return SizedBox(height: height);
  }

  Widget getHorizontalGap({double width = 20}) {
    return SizedBox(width: width);
  }

  Widget getHorizontalLine({double height = 1, Color color = Colors.grey}) {
    return Container(
      height: height,
      color: color,
    );
  }

  getTitleBar(
      {String? title,
      bool centerTitle = false,
      Color bgColor = AppTheme.white,
      Color themeColor = AppTheme.colorText,
      bool showBack = true}) {
    return AppBar(
      automaticallyImplyLeading: showBack,
      title: Text(
        title ?? "",
        textAlign: TextAlign.center,
        style: styleSemiBoldColor(AppTheme.colorText, fontSize: 16),
      ),
      centerTitle: centerTitle,
      titleTextStyle: TextStyle(color: themeColor),
      actionsIconTheme: IconThemeData(color: themeColor),
      backgroundColor: bgColor,
      iconTheme: IconThemeData(color: themeColor),
      elevation: 0,
    );
  }

  buttonStyle(
      {Color? backgroundColor,
      Color? foregroundColor,
      Color borderColor = AppTheme.colorGrey,
      Color shadowColor = Colors.transparent,
      double paddingHorizontal = 8,
      double paddingVertical = 8,
      double borderRadius = 8,
      BorderRadiusGeometry? borderRadiusGeometry,
      double elevation = 0,
      double borderWidth = 1.2}) {
    return TextButton.styleFrom(
        foregroundColor: foregroundColor,
        elevation: elevation,
        shadowColor: shadowColor,
        padding: EdgeInsets.symmetric(
            horizontal: paddingHorizontal, vertical: paddingVertical),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: Size.zero,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadiusGeometry ??
              BorderRadius.circular(borderRadius), // <-- Radius
        ),
        side: BorderSide(width: borderWidth, color: borderColor),
        backgroundColor: backgroundColor);
  }
}
