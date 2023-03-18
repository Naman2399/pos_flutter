import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos/screens/user_and_security/user_services.dart';
import 'dart:developer' as developer;

import '../../models/user.dart';
import '../../widgets/snackbar.dart';
import '../../widgets/text_decorations.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  late UserServices userServices;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController accessLevel = TextEditingController();
  bool isActive = true;
  bool passwordVisible = false ;

  save() {
    try{
      int val = int.parse(accessLevel.text);
      if (val > 9) {
        setState(() {
          accessLevel.text = "9";
        });
        displayMessage(
            context: context,
            title: 'Reached maximum access level field',
            message:
            'Maximum access level field need can be only 9 therefore setting it to maximum value',
            contentType: ContentType.help);
      }
    }on Exception catch(error){
      developer.log("Error in access level field need to be integer type");
      developer.log(error.toString());
      displayMessage(
          context: context,
          title: 'Error in Access Level Field',
          message:
          'Access level field need to contain only numbers in integers (e.g. 2,5)',
          contentType: ContentType.failure);
    }
    developer.log("All the user details");
    developer.log("First Name : ${firstName.text}");
    developer.log("Last Name : ${lastName.text}");
    developer.log("Email Name : ${email.text}");
    developer.log("Password : ${password.text}");
    developer.log("Confirm Password : ${confirmPassword.text}");
    developer.log("Access Level : ${accessLevel.text}");
    developer.log("Active : ${isActive.toString()}");

    User user = User(
        firstName: firstName.text,
        lastName: lastName.text,
        email: email.text,
        password: password.text,
        accessLevel: int.parse(accessLevel.text),
        active: isActive);
    userServices = UserServices(context: context);
    userServices.addUser(user: user, confirmPassword: confirmPassword.text);
  }

  increment() {
    try {
      int val = int.parse(accessLevel.text);
      val = val + 1;
      if (val > 9) {
        val = 9;
        displayMessage(
            context: context,
            title: 'Reached maximum access level field',
            message: 'Maximum access level field need can be only 9',
            contentType: ContentType.help);
      }
      setState(() {
        accessLevel.text = val.toString();
      });
    } on Exception catch (error) {
      developer.log("Error in access level field need to be integer type");
      developer.log(error.toString());
      displayMessage(
          context: context,
          title: 'Error in Access Level Field',
          message:
              'Access level field need to contain only numbers in integers (e.g. 2,5)',
          contentType: ContentType.failure);
    }
  }

  decrement() {
    try {
      int val = int.parse(accessLevel.text);
      val = val - 1;
      if (val < 0) {
        val = 0;
      }
      setState(() {
        accessLevel.text = val.toString();
      });
    } on Exception catch (error) {
      developer.log("Error in access level field need to be integer type");
      developer.log(error.toString());
      displayMessage(
          context: context,
          title: 'Error in Access Level Field',
          message:
              'Access level field need to contain only numbers in integers (e.g. 2,5)',
          contentType: ContentType.failure);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.85,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Add User',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: ListView(
          children: [
            const SizedBox(
              height: 5,
            ),
            Text(
              'First name',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            TextField(
              controller: firstName,
              decoration: inputDecorationCustom(context: context),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Last name',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            TextField(
              controller: lastName,
              decoration: inputDecorationCustom(context: context),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Email',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            TextField(
              controller: email,
              decoration: inputDecorationCustom(context: context),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Password',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: password,
                    decoration: inputDecorationCustom(context: context),
                    obscureText: passwordVisible,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryIconTheme.color,
                    ),),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Confirm Password',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            TextField(
              controller: confirmPassword,
              decoration: inputDecorationCustom(context: context),
              obscureText: true,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Access level',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Values must be between 0 to 9 & only of integer type',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    decrement();
                  },
                  icon: const Icon(
                    Icons.remove,
                    size: 15,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: accessLevel,
                    decoration: inputDecorationCustom(context: context),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    increment();
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 15,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Switch(
                    value: isActive,
                    activeColor: Colors.green,
                    inactiveThumbColor: Colors.redAccent,
                    inactiveTrackColor: Colors.red,
                    onChanged: (bool value) {
                      setState(() {
                        isActive = value;
                      });
                    }),
                Text(
                  'Active',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    save();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    'Save',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    'Cancel',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
