import 'dart:io';
import 'dart:math';
import 'package:app/provider/file_upload_provider.dart';
import 'package:app/utils/my_extentions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'utils/app_constants.dart';
import 'utils/app_prefs.dart';
import 'utils/app_theme.dart';
import 'utils/one_button_dialog.dart';
import 'utils/rich_text_one_button_dialog.dart';
import 'utils/rich_text_two_button_dialog.dart';
import 'utils/shimeer_view.dart';
import 'utils/two_button_dialog.dart';

abstract class BaseClass<T extends StatefulWidget> extends State<T> {
  BaseClass() {}

  static const apiGuardChannel = MethodChannel("com.f5.apiguard/bot-defense");
  static var appTheme = AppTheme.theme;

  initProviders(BuildContext context) {}
}

bool clickEnable = true;
void futureEnableClick({int sec = 1}) {
  clickEnable = false;
  Future.delayed(Duration(seconds: sec), () {
    clickEnable = true;
  });
}

String generateRandomString(int len) {
  var r = Random();
  const chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
}

Widget getAssetImage(String imageName, {double? width, double? height}) =>
    Image.asset("assets/images/$imageName", width: width, height: height);
Widget getAssetIcon(String iconName,
        {double? width, double? height, Color? color}) =>
    Image.asset(
      "assets/icons/$iconName",
      width: width,
      height: height,
      color: color,
    );

const BOLD = 'BOLD';
const SEMI_BOLD = 'SEMI_BOLD';
const MEDIUM = 'MEDIUM';
const LIGHT = 'LIGHT';
const THIN = 'THIN';
const REGULAR = 'REGULAR';
const MENU_FONT = 'NAV_MENU';
const MINION_REGULAR = 'MINION_REGULAR';
const MINION_SEMI_BOLD = 'MINION_SEMI_BOLD';

TextStyle styleRegular({double fontSize = 13}) {
  return TextStyle(fontFamily: REGULAR, fontSize: fontSize);
}

TextStyle styleMenu({double fontSize = 13}) {
  return TextStyle(fontFamily: MENU_FONT, fontSize: fontSize);
}

TextStyle styleLight({double fontSize = 13, Color? color}) {
  return TextStyle(fontFamily: LIGHT, fontSize: fontSize, color: color);
}

TextStyle styleThin({double fontSize = 13}) {
  return TextStyle(fontFamily: THIN, fontSize: fontSize);
}

TextStyle styleBold({double fontSize = 13}) {
  return TextStyle(fontFamily: BOLD, fontSize: fontSize);
}

TextStyle styleSemiBold(
    {double fontSize = 13, TextDecoration decoration = TextDecoration.none}) {
  return TextStyle(
      fontFamily: SEMI_BOLD, fontSize: fontSize, decoration: decoration);
}

TextStyle styleMedium({double fontSize = 13, TextDecoration? textDecoration}) {
  return TextStyle(
      fontFamily: MEDIUM, fontSize: fontSize, decoration: textDecoration);
}

TextStyle styleBoldColor(
    {double fontSize = 13,
    Color color = AppTheme.black,
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

TextStyle styleMinion(
    {double fontSize = 22,
    Color color = AppTheme.black,
    TextDecoration decoration = TextDecoration.none,
    double? height,
    bool bold = false}) {
  return TextStyle(
    fontFamily: bold ? MINION_SEMI_BOLD : MINION_REGULAR,
    fontSize: fontSize,
    color: color,
    decoration: decoration,
    height: height ?? 0,
  );
}

TextStyle styleSemiBoldColor(
    {double fontSize = 13,
    Color color = AppTheme.black,
    TextDecoration decoration = TextDecoration.none,
    double? height}) {
  return TextStyle(
      fontFamily: SEMI_BOLD,
      fontSize: fontSize,
      color: color,
      height: height ?? 0,
      decoration: decoration);
}

TextStyle styleMediumColor(
    {double fontSize = 13,
    Color color = AppTheme.black,
    TextDecoration decoration = TextDecoration.none,
    double? height}) {
  return TextStyle(
      fontFamily: MEDIUM,
      fontSize: fontSize,
      color: color,
      height: height ?? 0,
      decoration: decoration);
}

Widget getShimmerView(Widget w,
    {Color shimerColor = AppTheme.colorGrey, bool decoration = false}) {
  return Shimmer.fromColors(
      baseColor: AppTheme.shimmerBaseColor,
      highlightColor: shimerColor,
      child: Container(
          decoration: decoration
              ? BoxDecoration(
                  color: AppTheme.shimmerChildColor,
                  borderRadius: BorderRadius.circular(100))
              : null,
          color: !decoration ? AppTheme.shimmerChildColor : null,
          child: w));
}

TextStyle styleLightColor(
    {Color color = AppTheme.black,
    double fontSize = 13,
    TextDecoration decoration = TextDecoration.none,
    double? height}) {
  return TextStyle(
      fontFamily: LIGHT,
      fontSize: fontSize,
      color: color,
      height: height ?? 0,
      decoration: decoration);
}

TextStyle styleThinColor(
    {Color color = AppTheme.black,
    double fontSize = 13,
    TextDecoration decoration = TextDecoration.none,
    double? height}) {
  return TextStyle(
      fontFamily: THIN,
      fontSize: fontSize,
      color: color,
      height: height ?? 0,
      decoration: decoration);
}

TextStyle styleRegularColor(
    {Color color = AppTheme.black,
    double fontSize = 13,
    TextDecoration decoration = TextDecoration.none,
    double? height}) {
  return TextStyle(
    fontFamily: REGULAR,
    fontSize: fontSize,
    color: color,
    decoration: decoration,
    height: height ?? 0,
  );
}

DateTime parsedateFromString(String dateString) {
  return DateTime.parse(dateString);
}

getButtonStyle(
    {double hPadding = 10,
    double vPadding = 10,
    Color? bgColor,
    Color? foregroundColor}) {
  return TextButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // <-- Radius
      ),
      side: const BorderSide(width: 1, color: AppTheme.colorHorizontalLine),
      minimumSize: Size.zero,
      backgroundColor: bgColor,
      foregroundColor: foregroundColor,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding));
}

getMnuView(dynamic mnuTitle,
    {String? mnuIcon,
    bool showArrow = true,
    TextStyle? textStyle,
    Color menuTitleColor = Colors.black}) {
  return Row(
    children: [
      isNullOrEmpty(mnuIcon)
          ? Container()
          : Image.asset(
              'assets/icons/$mnuIcon',
              height: 24,
            ),
      isNullOrEmpty(mnuIcon) ? Container() : getHorizontalGap(width: 10),
      Text(
        mnuTitle,
        style: textStyle ?? styleRegularColor(fontSize: 16),
      ),
      showArrow ? const Spacer() : Container(),
      showArrow
          ? const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppTheme.black,
              size: 14,
            )
          : Container()
    ],
  );
}

getChildView(dynamic mnuTitle, {Icon? suffixIcon, TextStyle? textStyle}) {
  return Row(
    children: [
      Expanded(
          child: Text(
        mnuTitle,
        textAlign: suffixIcon != null ? TextAlign.start : TextAlign.center,
        style: textStyle ?? styleRegularColor(fontSize: 16),
      )),
      suffixIcon ?? Container()
    ],
  );
}

Widget getBackButton() => Container(
    margin: const EdgeInsets.only(left: 10),
    alignment: Alignment.center,
    child: TextButton(
      onPressed: () => (),
      style: buttonStyle(
          backgroundColor: Colors.transparent,
          foregroundColor: AppTheme.colorPrimary,
          borderColor: AppTheme.colorPrimary,
          paddingHorizontal: 8,
          paddingVertical: 8,
          borderRadius: 100,
          borderWidth: 1.5),
      child: const Icon(
        Icons.arrow_back,
        color: AppTheme.colorPrimary,
        size: 18,
      ),
    ));

Widget getBackCloseButton() => Container(
    margin: const EdgeInsets.only(left: 10),
    alignment: Alignment.center,
    child: TextButton(
      onPressed: () => onWillPop,
      style: buttonStyle(
          backgroundColor: Colors.transparent,
          foregroundColor: AppTheme.colorPrimary,
          borderColor: AppTheme.colorPrimary,
          paddingHorizontal: 8,
          paddingVertical: 8,
          borderRadius: 100,
          borderWidth: 1.5),
      child: const Icon(
        Icons.arrow_back,
        color: AppTheme.colorPrimary,
        size: 18,
      ),
    ));

containerDecoration(
    {Color borderColor = AppTheme.borderColor,
    Color color = AppTheme.boxColor,
    double borderRadius = 6.0}) {
  return BoxDecoration(
      border: Border.all(color: borderColor),
      color: color,
      borderRadius: BorderRadius.all(Radius.circular(borderRadius)));
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
      hintStyle: hintStyle ?? styleMedium(fontSize: 14),
      border: InputBorder.none,
      suffixIconConstraints: const BoxConstraints(),
      prefixIconConstraints: const BoxConstraints(),
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
    Color bgColor = AppTheme.white,
    double borderRadius = 6.0,
    double blurRadius = 5,
    double borderWidth = 1}) {
  return BoxDecoration(
      boxShadow: [
        BoxShadow(
            offset: Offset(0, blurRadius),
            color: valid ? AppTheme.colorGrey : AppTheme.colorRed,
            blurRadius: blurRadius)
      ],
      border: Border.all(
          width: borderWidth, color: valid ? borderColor : AppTheme.colorRed),
      color: bgColor,
      borderRadius: BorderRadius.all(Radius.circular(borderRadius)));
}

void hideKeyBoard({BuildContext? mContext}) {
  var context;
  FocusScopeNode currentFocus = FocusScope.of(mContext ?? context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

void changeSystemUiColor(
    {Color statusBarColor = AppTheme.pageBg,
    Color navBarColor = AppTheme.pageBg,
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

void changeStatusIconsColor(
    {brightness = Brightness.dark, navBrightness = Brightness.dark}) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarIconBrightness: brightness, // status bar icon color
    systemNavigationBarIconBrightness:
        navBrightness, // color of navigation controls
  ));
}

void showToast(String msg,
    {ToastGravity? gravity = ToastGravity.BOTTOM,
    Color bgColor = AppTheme.black}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity,
      backgroundColor: bgColor.withAlpha(160),
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      fontSize: 17.0);
}

bool isProgress = false;

void showProgress(
    {FileUploadProgressProvider? progressProvider,
    String? msg,
    required dynamic context}) {
  isProgress = true;
  changeSystemUiColor(
      statusBarColor: Colors.transparent,
      navBarColor: AppTheme.white.withOpacity(0.9));
  AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
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
          progressProvider != null
              ? Consumer<FileUploadProgressProvider>(
                  builder: (context, p, _) => Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          isNullOrEmpty(msg) ? Container() : Text(msg!),
                          Text('${p.progressPercent.toStringAsFixed(0)}%')
                        ],
                      ))
              : Container()
        ],
      )));
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

void hideProgress(BuildContext context) {
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

Widget getHorizontalLine(
    {double height = 1, double? width, Color color = Colors.grey}) {
  return Container(
    height: height,
    width: width,
    color: color,
  );
}

Widget getVerticallLine(
    {double height = 1, double width = 1, Color color = AppTheme.colorGrey}) {
  return Container(
    height: height,
    width: width,
    color: color,
  );
}

getTitleBar(
    {String? title,
    Widget? titleIcon,
    Widget? leading,
    List<Widget>? actions,
    bool centerTitle = false,
    Color bgColor = AppTheme.white,
    double toolbarHeight = kToolbarHeight,
    Color themeColor = AppTheme.black,
    double elevation = 0,
    Brightness navBrightness = Brightness.dark,
    Brightness statusBrightness = Brightness.dark,
    Color systemNavColor = AppTheme.pageBg,
    Key? key,
    bool showBack = true,
    double titleFontSize = 16}) {
  return AppBar(
      key: key,
      automaticallyImplyLeading: showBack,
      leading: leading,
      toolbarHeight: toolbarHeight,
      title: (title == null && titleIcon == null)
          ? null
          : title != null
              ? Text(
                  title,
                  textAlign: TextAlign.center,
                  style: styleSemiBoldColor(
                      fontSize: titleFontSize, color: themeColor),
                )
              : titleIcon,
      centerTitle: centerTitle,
      titleTextStyle: TextStyle(color: themeColor),
      actionsIconTheme: IconThemeData(color: themeColor),
      backgroundColor: bgColor,
      iconTheme: IconThemeData(color: themeColor),
      shadowColor: AppTheme.pageBg,
      elevation: elevation,
      actions: actions,
      systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: systemNavColor, // navigation bar color
          statusBarColor: Colors.transparent, // status bar color
          statusBarIconBrightness: statusBrightness, // status bar icon color
          systemNavigationBarIconBrightness:
              navBrightness // color of navigation controls
          ));
}

getAnimationListView(Widget listItemView, int itemCount,
    {EdgeInsetsGeometry padding =
        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
    bool shrinkWrap = true,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.onDrag}) {
  return AnimationLimiter(
      child: ListView.builder(
    keyboardDismissBehavior: keyboardDismissBehavior,
    padding: padding,
    shrinkWrap: shrinkWrap,
    itemBuilder: (context, pos) {
      return AnimationConfiguration.staggeredList(
        position: pos,
        duration: const Duration(milliseconds: 500),
        child: SlideAnimation(
          verticalOffset: 50.0,
          child: FadeInAnimation(child: listItemView),
        ),
      );
    },
    itemCount: itemCount,
  ));
}

void setOneSignalExternalId(dynamic id) {
/*     OneSignal.shared.setExternalUserId(id.toString()).then((results) {
      debugPrint(results.toString());
    }).catchError((error) {
      debugPrint(error.toString());
    }); */
  //OneSignal.shared.setEmail(email: _userDetails!.emailId!);
  //OneSignal.shared.setSMSNumber(smsNumber: "+91${_userDetails?.mobileNo}");
}

void setUpOneSignal(dynamic userId, dynamic userType,
    {String? email, String? mobile}) {
  setOneSignalExternalId(userId);
/*     OneSignal.shared.sendTags({
      'userId': userId,
      'userType': userType,
      'isLoggedIn': 1,
      'deviceType': Platform.isIOS ? 'iOS' : 'Android',
      'planId': 0,
      'subscriptionEndDate': '',
      'planName': 'Unknown'
    }); */
/*     if (!isNullOrEmpty(email)) {
     OneSignal.shared.setEmail(email: email!);
    }
    if (!isNullOrEmpty(mobile)) {
    OneSignal.shared.setSMSNumber(smsNumber: "+44$mobile");
    } */
}

printLog({String tag = "", String data = ""}) {
  debugPrint("$tag> $data");
}

bool isNullOrEmpty(String? data) {
  return data == null || data == '';
}

getFileSize(File file, int decimals) {
  int bytes = file.lengthSync();
  if (bytes <= 0) return "0 B";
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  var i = (log(bytes) / log(1024)).floor();
  return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
}

getProgress() {
  return const SpinKitFadingCircle(
    color: AppTheme.colorPrimary,
    size: 34,
  );
}

String countryCodeToEmoji(String countryCode) {
  // 0x41 is Letter A
  // 0x1F1E6 is Regional Indicator Symbol Letter A
  // Example :
  // firstLetter U => 20 + 0x1F1E6
  // secondLetter S => 18 + 0x1F1E6
  // See: https://en.wikipedia.org/wiki/Regional_Indicator_Symbol
  final int firstLetter = countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
  final int secondLetter = countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6;
  return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
}

getTitleStyle(
    {Color titleTextColor = AppTheme.colorPrimary, double fontSize = 14}) {
  return styleMediumColor(color: titleTextColor, fontSize: fontSize);
}

String getWhatsAppUrl(String phone) {
  if (Platform.isIOS) {
    return "whatsapp://wa.me/$phone/?text=${Uri.encodeFull(' ')}";
  } else {
    return "whatsapp://send?phone=$phone&text=${Uri.encodeFull(' ')}";
  }
}

void launchURL(String url) async {
  if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
}

void email(String emailId) async {
  if (!await launchUrl(Uri.parse('mailto:$emailId?subject=&body='))) {
    throw 'Could not launch $emailId';
  }
}

void call(String number) async {
  if (!await launchUrl(Uri.parse('tel:$number'))) {
    throw 'Could not launch $number';
  }
}

void sms(String number) async {
  if (!await launchUrl(Uri.parse('sms:$number'))) {
    throw 'Could not launch $number';
  }
}

openWhatsApp(String phone) {
  if (Platform.isIOS) {
    launchURL("whatsapp://wa.me/$phone/?text=${Uri.encodeFull(' ')}");
    //return "whatsapp://wa.me/$phone/?text=${Uri.encodeFull(' ')}";
  } else {
    launchURL("whatsapp://send?phone=$phone&text=${Uri.encodeFull(' ')}");
    //return "whatsapp://send?phone=$phone&text=${Uri.encodeFull(' ')}";
  }
}

makeStatusTransparent() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white));
}

getDateTime(String? dateTime, String inputFormat,
    {String outPutFormat = 'MMMM yy'}) {
  if (dateTime != null && dateTime.isNotEmpty) {
    return DateFormat(outPutFormat)
        .format(DateFormat(inputFormat).parse(dateTime));
  } else {
    return "";
  }
}

getFormatedDateTime(DateTime dateTime, {String outPutFormat = 'MMMM yyyy'}) {
  return DateFormat(outPutFormat).format(dateTime);
}

String getDateFromMilisecond(int miliseconds,
    {String outPutFormat = 'MMM dd, yyyy; hh:mm a', bool isUtc = false}) {
  return DateFormat(outPutFormat)
      .format(DateTime.fromMillisecondsSinceEpoch(miliseconds, isUtc: isUtc));
}

DateTime getDateTimeFromString(String dateTimeString, String inputFormat,
    {bool removeTime = false}) {
  var dt = DateTime.now();
  dt = DateFormat(inputFormat).parse(dateTimeString);
  return removeTime
      ? DateTime(dt.year, dt.month, dt.day)
      : DateTime(dt.year, dt.month, dt.day, dt.hour, dt.minute, dt.second);
}

String getAfricaTime(String? dateTimeString, String inputFormat,
    {String outPutFormat = 'MMMM yy'}) {
  var dt = DateTime.now();
  try {
    final date = DateFormat(inputFormat).parse(dateTimeString!);
    dt = DateTime.utc(date.year, date.month, date.day, date.hour, date.minute,
            date.second)
        .add(const Duration(hours: 2));
    //dt = dt.add(const Duration(hours: 2));
  } catch (e) {}
  return DateFormat(outPutFormat).format(dt);
}

todayOrDate(String fromDateString) {
  if (equalsIgnoreCase(fromDateString, 'TODAY')) {
    return 'Today';
  } else {
    DateTime from = getDateTimeFromString(fromDateString, 'yyyy-MM-dd');
    from = DateTime(from.year, from.month, from.day);
    return getFormatedDateTime(from, outPutFormat: 'dd MMM');
  }
  /*  //DateTime from =getDateTimeFromString(dateTime, DateFormats.yyyyMMddHHmmssZ);
    //DateTime.parse(dateTime).toLocal();
    DateTime to = DateTime.utc(
        DateTime.now().year, DateTime.now().month, DateTime.now().day);

    //to = DateTime(to.year, to.month, to.day, to.hour, to.minute, to.second);
    Duration diff = to.difference(from);
    if (diff.inDays == 0) {
      return 'Today';
    } else if (diff.inDays == 1) {
      return 'Tommorrow';
    } else {
      return getFormatedDateTime(from, outPutFormat: 'dd MMMl');
    } */
}

remainDays(DateTime from) {
  //DateTime from =getDateTimeFromString(dateTime, DateFormats.yyyyMMddHHmmssZ);
  //DateTime.parse(dateTime).toLocal();
  DateTime to = DateTime.now();
  from = DateTime(from.year, from.month, from.day, 23, 59, 59);
  to = DateTime(to.year, to.month, to.day, 0, 0, 0);
  Duration diff = from.difference(to);
  return diff.inDays.abs();
}

remainDaysString(DateTime from) {
  DateTime to = DateTime.now();
  from = DateTime(from.year, from.month, from.day, 23, 59, 59);
  to = DateTime(to.year, to.month, to.day, 0, 0, 0);
  Duration diff = from.difference(to);
  final days = diff.inDays.abs();
  if (days > 0) {
    return days > 1 ? '$days Days Remaining' : '$days Day Remaining';
  } else {
    return 'Ends Today';
  }
}

daysString(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day, 0, 0, 0);
  to = DateTime(to.year, to.month, to.day, 23, 59, 59);
  Duration diff = from.difference(to);
  final days = diff.inDays.abs();
  return days > 1 ? '$days Days' : '$days Day';
}

daysRemain(DateTime from) {
  //DateTime from =getDateTimeFromString(dateTime, DateFormats.yyyyMMddHHmmssZ);
  //DateTime.parse(dateTime).toLocal();
  DateTime to = DateTime.now();
  from = DateTime(
      from.year, from.month, from.day, from.hour, from.minute, from.second);
  to = DateTime(to.year, to.month, to.day, to.hour, to.minute, to.second);
  Duration diff = from.difference(to);
  return diff.inDays.abs();
}

daysCount(int from, int end) {
  var startDate = DateTime.fromMillisecondsSinceEpoch(from, isUtc: true);
  startDate = DateTime(
    startDate.year,
    startDate.month,
    startDate.day,
  );
  var endDate = DateTime.fromMillisecondsSinceEpoch(end, isUtc: true);
  endDate = DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59);
  Duration diff = startDate.difference(endDate);
  return diff.inDays.abs();
}

int minutesRemain(DateTime from) {
  //DateTime from =getDateTimeFromString(dateTime, DateFormats.yyyyMMddHHmmssZ);
  //DateTime.parse(dateTime).toLocal();
  DateTime to = DateTime.now();
  from = DateTime(
      from.year, from.month, from.day, from.hour, from.minute, from.second);
  to = DateTime(to.year, to.month, to.day, to.hour, to.minute, to.second);
  Duration diff = from.difference(to);
  return diff.inMinutes;
}

int remainMiliseconds(DateTime from) {
  //DateTime from =getDateTimeFromString(dateTime, DateFormats.yyyyMMddHHmmssZ);
  //DateTime.parse(dateTime).toLocal();
  DateTime to = DateTime.now();
  from = DateTime(
      from.year, from.month, from.day, from.hour, from.minute, from.second);
  to = DateTime(to.year, to.month, to.day, to.hour, to.minute, to.second);
  Duration diff = from.difference(to);
  return diff.inMilliseconds;
}

timeAgo(DateTime from) {
  //DateTime from =getDateTimeFromString(dateTime, DateFormats.yyyyMMddHHmmssZ);
  //DateTime.parse(dateTime).toLocal();
  DateTime to = DateTime.now();
  from = DateTime(
      from.year, from.month, from.day, from.hour, from.minute, from.second);
  to = DateTime(to.year, to.month, to.day, to.hour, to.minute, to.second);
  Duration diff = to.difference(from);
/*     if (diff.inDays == 0) {
      return 'Ordered Today';
    } else if (diff.inDays == 1) {
      return 'Ordered Yesterday';
    } else {
      return "";
      //"Ordered on ${getFormatedDateTime(from, outPutFormat: DateFormats.dd_MMM_yyyy)}";
    } */
  if (diff.inDays >= 1) {
    //return getDateTime(dateTime, DateFormats.yyyyMMddHHmmssZ, outPutFormat: DateFormats.yyyyMMdd);
    return '${diff.inDays} day${diff.inDays == 1 ? '' : 's'} ago';
  } else if (diff.inHours >= 1) {
    return '${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago';
  } else if (diff.inMinutes >= 1) {
    return '${diff.inMinutes} minute${diff.inMinutes == 1 ? '' : 's'} ago';
  } else if (diff.inSeconds >= 1) {
    return '${diff.inSeconds} second${diff.inSeconds == 1 ? '' : 's'} ago';
  } else {
    return 'Just now';
  }
}

bool isIOS() {
  return Platform.isIOS;
}

getString(String? val,
    {String? defVal, bool titleCase = false, dynamic splitPattern = ' '}) {
  var data = "";
  if (val != null) {
    data = val;
  } else {
    if (defVal != null) {
      data = defVal;
    }
  }
  return titleCase ? data.toTitleCase(splitPattern: splitPattern) : data;
}

Widget loadImage(String? url) {
  if (url != null) {
    return FadeInImage.assetNetwork(
        fit: BoxFit.cover,
        placeholder: "assets/icons/avatar.png",
        fadeInDuration: const Duration(milliseconds: 500),
        fadeInCurve: Curves.easeInExpo,
        fadeOutCurve: Curves.easeOutExpo,
        image: url,
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset("assets/icons/avatar.png");
        });
  } else {
    return Image.asset("assets/icons/avatar.png");
  }
}

Widget getPlaceHolder() => Container(color: AppTheme.colorGrey);

Widget loadFileImage(File file) {
  return Image.file(file, fit: BoxFit.cover);
}

getCircleDot({double size = 24, Color dotColor = AppTheme.black}) {
  return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle));
}

getCircleDotBadge(
    {double size = 24, Color dotColor = AppTheme.badgeColor, String? value}) {
  return Container(
      alignment: Alignment.center,
      width: size,
      height: size,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
      child: Text(
        getString(value),
        style: styleMediumColor(color: AppTheme.white, fontSize: 10),
      ));
}

Widget getRoundImage(String? url,
    {double imageSize = 24,
    Color borderColor = AppTheme.colorGrey,
    double borderWidth = 1,
    File? imageFile}) {
  return Container(
      decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: borderWidth),
          shape: BoxShape.circle),
      child: ClipOval(
          child: SizedBox.fromSize(
              size: Size.fromRadius(imageSize),
              child: imageFile != null
                  ? loadFileImage(imageFile)
                  : loadImage(url))));
}

int getQty(TextEditingController textEditingController) {
  return textEditingController.text.trim().isEmpty
      ? 0
      : int.parse(textEditingController.text.trim());
}

getTotalQty(List<TextEditingController> controllers) {
  var qty = 0;
  controllers.forEach(((element) {
    qty = qty + getQty(element);
  }));
  return qty;
}

horizontalLine() {
  return getHorizontalLine(
      height: 1, color: const Color.fromARGB(255, 234, 234, 234));
}

styleMnuTitle() {
  return styleMediumColor(color: AppTheme.colorText, fontSize: 14);
}

styleMnuBtn({double padding = 25}) {
  return TextButton.styleFrom(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 20),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      foregroundColor: AppTheme.colorPrimary,
      minimumSize: Size.zero);
}

menuView(dynamic mnuIcon, dynamic mnuTitle) {
  return Row(
    children: [
      mnuIcon == 'ic_delete.png'
          ? Image.asset(
              'assets/icons/$mnuIcon',
              color: AppTheme.colorRed,
              width: 28,
            )
          : Image.asset(
              'assets/icons/$mnuIcon',
              width: 28,
            ),
      getHorizontalGap(width: 25),
      Text(mnuTitle, style: styleMnuTitle()),
    ],
  );
}

menuItem(dynamic mnuImg, dynamic mnuImageActive, dynamic mnuTitle,
    {double iconSize = 24}) {
  return BottomNavigationBarItem(
    icon: menuImage(mnuImg, iconSize: iconSize),
    activeIcon:
        menuImage(mnuImg, iconSize: iconSize, color: AppTheme.colorBlue),
    label: mnuTitle,
  );
}

menuImage(dynamic mnuImg, {double iconSize = 24, Color? color}) {
  return Image.asset(
    "assets/icons/$mnuImg",
    color: color,
    height: iconSize,
    width: iconSize,
  );
}

void gotoMenuPage(String tag, BuildContext context) {
  Navigator.pushNamed(context, tag);
}

void gotoPageWithData(String tag, dynamic data, BuildContext context) {
  Navigator.pushNamed(context, tag, arguments: data);
}

gotoNextWithNoBack(Widget widget, BuildContext context) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (Route<dynamic> route) => false,
  );
}

gotoNextClearThis(Widget widget, BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}

showLogoutDialog({bool chnageStatusColor = true, required dynamic context}) {
  //changeSystemUiColor(statusBarColor: Colors.transparent,navBarColor: Colors.black.withOpacity(0.6));
  var dialog = TwoButtonDialog(
      title: "Logout",
      message: "Are you sure, you want to logout?",
      positiveBtnText: 'Yes',
      negativeBtnText: 'No',
      titleColor: AppTheme.black,
      positiveColor: AppTheme.black,
      negativeColor: AppTheme.colorGreyDark,
      onPostivePressed: () {
        //changeSystemUiColor(statusBarColor: AppTheme.white, navBarColor: AppTheme.white);
        hitLogoutApi();
      },
      onNegativePressed: () {
        //changeSystemUiColor(statusBarColor: Colors.transparent, navBarColor: AppTheme.white);
        /* if (chnageStatusColor) {
            changeHomeStatus();
          } else {
            changeSystemUiColor(
                statusBarColor: AppTheme.white, navBarColor: AppTheme.white);
          } */
      });
  showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (BuildContext context) {
        //prevent Back button press
        return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: dialog);
      });
}

Future<void> hitLogoutApi({bool progress = true}) async {
  await AppPref.clearSharedPref();
  // gotoNextWithNoBack(LoginOrGuest(showBack: false));
  //await  AppPref.setIntroViewed(true);

  //await FirebaseAuth.instance.signOut();
  //await OneSignal.logout();
  //gotoNextWithNoBack(NewOrAccount());
  /* logoutFirebase();
    logoutFromOneSignal();
    //AppPref.clearUserPref(); */
  //logout();
}

void logoutFirebase() async {
  try {
/*       await GoogleSignIn().disconnect();
      await FacebookAuth.instance.logOut();
      await FirebaseAuth.instance.signOut();*/
  } catch (e) {}
}

void logoutFromOneSignal() async {
  // await OneSignal.shared.sendTags({'isLoggedIn': 0});
}

Future<bool> onWillPop({bool changeStatus = true}) {
  if (changeStatus) {
    changeSystemUiColor(
        statusBarColor: AppTheme.colorPrimary, navBrightness: Brightness.dark);
  }
  return Future.value(true);
}

Future<bool> onWillPopTrans({bool changeStatus = true}) {
  if (changeStatus) {
    changeSystemUiColor(
        statusBarColor: AppTheme.colorPrimary, navBrightness: Brightness.dark);
  } else {
    changeSystemUiColor(
        statusBarColor: Colors.transparent, navBrightness: Brightness.dark);
  }
  return Future.value(true);
}

Future<bool> noBackPress() {
  return Future.value(false);
}

changeHomeStatus() {
  changeSystemUiColor(
      statusBarColor: AppTheme.colorPrimary, navBrightness: Brightness.dark);
}

Future<Object?> gotoNextPage(
  BuildContext context,
  String routeName, {
  Object? arguments,
}) async {
  hideKeyBoard();
  return await Navigator.pushNamed(context, routeName, arguments: arguments);
}

Future<Object?> gotoNext(BuildContext mContext, Widget v) async {
  return await Navigator.push(
      mContext, MaterialPageRoute(builder: (mContext) => v));
}

void showErrorDialogLogout(String title, String msg, dynamic context) {
  changeSystemUiColor(
      statusBarColor: Colors.transparent,
      navBarColor: Colors.black.withOpacity(0.6));
  var dialog = OneButtonDialog(
      title: title,
      message: msg,
      positiveBtnText: 'OK',
      onPostivePressed: () {
        hitLogoutApi();
      });
  showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (BuildContext context) {
        //prevent Back button press
        return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: dialog);
      });
}

void showSuccessDialog(String title, String msg, dynamic context,
    {BuildContext? buildContext}) {
  changeSystemUiColor(
      statusBarColor: Colors.transparent,
      navBarColor: Colors.black.withOpacity(0.6));
  var dialog = OneButtonDialog(
      title: title,
      message: msg,
      positiveBtnText: "OK",
      titleColor: AppTheme.colorPrimary,
      onPostivePressed: () {
        changeSystemUiColor(
            statusBarColor: Colors.transparent, navBarColor: AppTheme.white);
        if (buildContext != null) {
          Navigator.pop(buildContext);
        }
      });
  showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (BuildContext context) {
        //prevent Back button press
        return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: dialog);
      });
}

void showErrorDialog(String title, String msg, dynamic context,
    {bool changeStatusColor = false,
    Color color = Colors.transparent,
    BuildContext? bContext}) {
  changeSystemUiColor(
      statusBarColor: Colors.transparent,
      navBarColor: Colors.black.withOpacity(0.6));
  var dialog = OneButtonDialog(
      title: title,
      message: msg,
      positiveBtnText: "OK",
      onPostivePressed: () {
        changeSystemUiColor(
            statusBarColor: Colors.transparent, navBarColor: AppTheme.white);

        if (bContext != null) {
          Navigator.pop(bContext);
        }
      });
  showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (BuildContext context) {
        //prevent Back button press
        return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: dialog);
      });
}

void loginDetailsUpdateSuccessDialog(String title, String msg, dynamic context,
    {bool changeStatusColor = false,
    Color color = Colors.transparent,
    BuildContext? bContext}) {
  changeSystemUiColor(
      statusBarColor: Colors.transparent,
      navBarColor: Colors.black.withOpacity(0.6));
  var dialog = OneButtonDialog(
      title: title,
      message: msg,
      titleColor: AppTheme.black,
      positiveBtnText: "OK",
      onPostivePressed: () {
        changeSystemUiColor(
            statusBarColor: Colors.transparent, navBarColor: AppTheme.white);
        hitLogoutApi();
      });
  showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (BuildContext context) {
        //prevent Back button press
        return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: dialog);
      });
}

// showRichTwoButtonDialog(Widget richText, dynamic context) {
//   changeSystemUiColor(
//       statusBarColor: Colors.transparent,
//       navBarColor: Colors.black.withOpacity(0.6));
//   var dialog = RichTextTwoButtonDialog(
//       richText: richText,
//       positiveColor: AppTheme.colorGreen,
//       negativeColor: AppTheme.colorRed,
//       positiveBtnText: 'Subscribe Plan',
//       negativeBtnText: 'Dismiss',
//       onPostivePressed: () {
//         changeSystemUiColor(
//             statusBarColor: Colors.transparent, navBarColor: AppTheme.white);
//         gotoNextWithNoBack(Container());
//       },
//       onNegativePressed: () {
//         changeSystemUiColor(
//             statusBarColor: Colors.transparent, navBarColor: AppTheme.white);
//         // gotoNextWithNoBack(MainPage());
//       });
//   showDialog(
//       context: context,
//       barrierDismissible: false,
//       barrierColor: Colors.black.withOpacity(0.6),
//       builder: (BuildContext context) {
//         //prevent Back button press
//         return WillPopScope(
//             onWillPop: () {
//               return Future.value(false);
//             },
//             child: dialog);
//       });
// }

void showRichTextDialog(Widget richText, dynamic context) {
  changeSystemUiColor(
      statusBarColor: Colors.transparent,
      navBarColor: Colors.black.withOpacity(0.6));
  var dialog = RichTextOneButtonDialog(
      richText: richText,
      positiveBtnText: "OK",
      onPostivePressed: () {
        changeSystemUiColor(
            statusBarColor: Colors.transparent, navBarColor: AppTheme.white);
      });
  showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (BuildContext context) {
        //prevent Back button press
        return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: dialog);
      });
}

getCachedNetworkImage(
    {String? url,
    double width = 64,
    double height = 64,
    double padding = 15,
    Color bgColor = AppTheme.colorGrey,
    String placeHolder = 'place_holder.png'}) {
  return isNullOrEmpty(url)
      ? Container(
          color: bgColor,
          width: width,
          height: height,
          padding: EdgeInsets.all(padding),
          child: getPlaceHolder())
      : CachedNetworkImage(
          imageUrl: getString(url),
          fit: BoxFit.cover,
          width: width,
          height: height,
          errorWidget: (context, s, url) => Container(
              color: bgColor,
              padding: EdgeInsets.all(padding),
              child: getPlaceHolder()),
          placeholder: (context, url) => Container(
              color: bgColor,
              padding: EdgeInsets.all(padding),
              child: getPlaceHolder()));
}

void shareAppUrl() {
  if (clickEnable) {
    futureEnableClick(sec: 2);
    const st =
        'Checkout Teedu Teacher\n\nAndroid\n______\n\niOS\nhttps://apps.apple.com/us/app/teedu-teacher/id6470018352';
    //Share.share(st, subject: 'Check Teedu Teacher App');
  }
}

getStatsView(dynamic icon, dynamic count, dynamic title) {
  return Column(
    children: [
      Image.asset(
        'assets/icons/$icon',
        width: 48,
      ),
      Text(
        count.toString(),
        textAlign: TextAlign.center,
        style: styleBoldColor(fontSize: 16),
      ),
      Text(
        title,
        textAlign: TextAlign.center,
        style: styleSemiBoldColor(fontSize: 10),
      )
    ],
  );
}

void onBackPress({Object? result, required BuildContext context}) {
  Navigator.pop(context, result);
}

buttonStyle(
    {Color? backgroundColor,
    Color? foregroundColor,
    Color borderColor = Colors.transparent,
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

void showSnackBar(dynamic msg, dynamic context,
    {int msgType = AppConstants.SUCCESS,
    BuildContext? buildContext,
    Color bgColor = AppTheme.black,
    Duration d = const Duration(milliseconds: 2500)}) {
  var scaffoldMessenger = ScaffoldMessenger.of(buildContext ?? context);
  var sn = scaffoldMessenger.showSnackBar(SnackBar(
      backgroundColor: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      elevation: 0,
      content: Container(
        decoration: BoxDecoration(
            color:
                msgType == AppConstants.SUCCESS ? bgColor : AppTheme.colorRed,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      msg,
                    ))),
            IconButton(
                icon: const Icon(
                  Icons.close,
                  color: AppTheme.white,
                ),
                onPressed: () {
                  scaffoldMessenger.hideCurrentSnackBar();
                })
          ],
        ),
      ),
      duration: d));
}

Route createRoute(Widget widget) {
  return PageRouteBuilder(
    opaque: false,
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

getStepProgress(int value, BuildContext context, {EdgeInsets? padding}) {
  return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Stack(children: [
        Container(
            height: 16, width: double.infinity, color: AppTheme.colorGrey),
        Container(
            alignment: Alignment.centerRight,
            height: 16,
            width: (MediaQuery.of(context).size.width / 2 - 30) * value / 100,
            color: AppTheme.colorBlue)
      ]));
}

Widget empty() => const SizedBox();
