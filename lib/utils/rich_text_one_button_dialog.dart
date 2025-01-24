import '../baseclass_stateless.dart';
import 'package:flutter/material.dart';
import 'app_theme.dart';

class RichTextOneButtonDialog extends BaseClassStateLess {
  late final Widget richText;
  late final String positiveBtnText;
  late final Function onPostivePressed;

  RichTextOneButtonDialog(
      {required this.richText,
      required this.positiveBtnText,
      required this.onPostivePressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              richText,
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
