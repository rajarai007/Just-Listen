import '../baseclass_stateless.dart';
import 'package:flutter/material.dart';
import 'app_theme.dart';

class RichTextTwoButtonDialog extends BaseClassStateLess {
  late final Widget richText;
  late final String positiveBtnText;
  late final String negativeBtnText;
  late final Function onPostivePressed;
  late final Function onNegativePressed;
  Color? positiveColor;
  Color? negativeColor;

  RichTextTwoButtonDialog(
      {required this.richText,
      required this.positiveBtnText,
      required this.negativeBtnText,
      required this.onPostivePressed,
      required this.onNegativePressed,
      this.positiveColor,
      this.negativeColor});

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
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: richText),
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
