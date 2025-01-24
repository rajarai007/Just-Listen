import 'dart:developer';

import 'package:flutter/material.dart';

class TabSelectionNotifier {
  ValueNotifier<int> bottomTabNotifier = ValueNotifier<int>(0);
  void setBottomTabIndex(int v) {
    bottomTabNotifier.value = v;
  }

  ValueNotifier<int> requestTabNotifier = ValueNotifier<int>(0);
  void setRequestTabIndex(int v) {
    requestTabNotifier.value = v;
  }

  void dispose() {}
}
