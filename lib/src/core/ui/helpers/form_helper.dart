import 'package:flutter/material.dart';

void unfocus(BuildContext context) => FocusScope.of(context).unfocus();

/*extension UnFocusExtension on BuildContext {
  void unFocus() => Focus.of(this).unfocus();
}*/
