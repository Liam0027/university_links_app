import 'package:flutter/material.dart';

void unFocus() {
  return FocusManager.instance.primaryFocus?.unfocus();
}
