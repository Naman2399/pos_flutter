import 'package:flutter/material.dart';
import 'package:pos/screens/user/edit_user.dart';

import '../../models/user.dart';

void editUserBottomSheet(BuildContext context, User user) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context, builder: (context) => EditUser(user: user));
}