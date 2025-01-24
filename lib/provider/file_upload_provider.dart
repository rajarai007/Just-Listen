import 'package:flutter/material.dart';

class FileUploadProgressProvider extends ChangeNotifier {
  double _progressPercent = 0.0;
  double get progressPercent => _progressPercent;

  set progressPercent(double value) {
    _progressPercent = value;
    notifyListeners();
  }
}