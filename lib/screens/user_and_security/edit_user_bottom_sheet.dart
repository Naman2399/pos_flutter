import 'package:flutter/material.dart';
import 'package:pos/screens/user_and_security/add_user.dart';
import 'package:pos/screens/user_and_security/edit_user.dart';

import '../../models/user.dart';

void editUserBottomSheet(BuildContext context, User user) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context, builder: (context) => EditUser(user: user));
}