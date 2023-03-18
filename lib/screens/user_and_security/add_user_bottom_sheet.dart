import 'package:flutter/material.dart';
import 'package:pos/screens/user_and_security/add_user.dart';

void addUserBottomSheet(BuildContext context) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context, builder: (context) => const AddUser());
}