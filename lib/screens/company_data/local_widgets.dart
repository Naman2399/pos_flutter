import 'package:flutter/material.dart';

import '../../widgets/text_decorations.dart';

Widget heading({required String name, required BuildContext context}) {
  return Row(
    children: [
      Text(
        name,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      Expanded(
        child: Container(
            margin: const EdgeInsets.only(left: 15.0, right: 10.0),
            child: const Divider(
              color: Colors.black,
              height: 50,
            )),
      ),
    ],
  );
}

Widget inputField(
    {required String inputFieldName,
    required TextEditingController textEditingController, required BuildContext context}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            inputFieldName,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Expanded(
            flex: 3,
            child: TextField(
              controller: textEditingController,
              decoration: TextStyleApp.inputDecoration,
              maxLines: 1,
            )),
      ],
    ),
  );
}

