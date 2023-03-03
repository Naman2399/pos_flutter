import 'package:flutter/material.dart';

import 'package:pos/utilities/mysql_parameters.dart';

class TextStyleApp {

  static InputDecoration inputDecoration = const InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
    border: OutlineInputBorder(gapPadding: 1.0),
  );
}

InputDecoration inputDecorationCustom({required BuildContext context}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
          width: 1.5, color: Theme.of(context).primaryColorLight),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
          width: 1.5, color: Theme.of(context).focusColor),
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(width: 1.5, color: Colors.red),
    ),
  );
}