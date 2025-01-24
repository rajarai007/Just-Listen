import '../baseclass_stateless.dart';
import 'package:flutter/material.dart';
import 'app_theme.dart';

class OneButtonDialog extends BaseClassStateLess {
  late final String title;
  late final String message;
  late final String positiveBtnText;
  late final Function onPostivePressed;
  Color? titleColor;

  OneButtonDialog(
      {required this.title,
      required this.message,
      required this.positiveBtnText,
      required this.onPostivePressed,
      this.titleColor});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: styleMediumColor(
                        titleColor ?? AppTheme.colorGreyDark,
                        fontSize: 16),
                  )),
              Padding(
                  padding: const EdgeInsets.only(
                      top: 0, bottom: 20, left: 15, right: 15),
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    maxLines: 8,
                    overflow: TextOverflow.ellipsis,
                    style:
                        styleRegularColor(AppTheme.colorGreyDark, fontSize: 13),
                  )),
              getHorizontalLine(color: AppTheme.colorGreyLight),
              SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(13),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          foregroundColor: AppTheme.colorPrimary),
                      onPressed: () {
                        Navigator.of(context).pop();
                        onPostivePressed();
                      },
                      child: Text(positiveBtnText,
                          style:
                              styleMediumColor(AppTheme.black, fontSize: 15))))
            ],
          )),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    );
  }
}
