import '../baseclass_stateless.dart';
import 'package:flutter/material.dart';
import 'app_theme.dart';

class TwoButtonDialog extends BaseClassStateLess {
  late final String title;
  late final String message;
  late final String positiveBtnText;
  late final String negativeBtnText;
  late final Function onPostivePressed;
  late final Function onNegativePressed;
  Color? titleColor;
  Color? positiveColor;
  Color? negativeColor;

  TwoButtonDialog(
      {required this.title,
      required this.message,
      required this.positiveBtnText,
      required this.negativeBtnText,
      required this.onPostivePressed,
      required this.onNegativePressed,
      this.titleColor,
      this.positiveColor,
      this.negativeColor});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: Container(
            decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(8.0)),
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      title,
                      style: styleMediumColor(
                          titleColor ?? AppTheme.colorPrimary,
                          fontSize: 16),
                    )),
                Padding(
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 20, left: 15, right: 15),
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: styleRegularColor(AppTheme.black, fontSize: 13),
                    )),
                getHorizontalLine(color: AppTheme.colorGreyLight),
                IntrinsicHeight(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                        child: TextButton(
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(15),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                foregroundColor: AppTheme.colorPrimary),
                            onPressed: () {
                              Navigator.of(context).pop();
                              onNegativePressed();
                            },
                            child: Text(negativeBtnText,
                                style: styleMediumColor(
                                    negativeColor ?? AppTheme.colorGreyDark,
                                    fontSize: 14)))),
                    Container(
                      width: 1,
                      color: AppTheme.colorGreyLight,
                    ),
                    Expanded(
                        child: TextButton(
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(15),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                foregroundColor: AppTheme.colorPrimary),
                            onPressed: () {
                              Navigator.of(context).pop();
                              onPostivePressed();
                            },
                            child: Text(positiveBtnText,
                                style: styleMediumColor(
                                    positiveColor ?? AppTheme.colorGreyDark,
                                    fontSize: 14))))
                  ],
                ))
              ],
            )),
        backgroundColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)));
  }
}
