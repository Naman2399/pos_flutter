import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:pos/database_models_functions/user_functions.dart';
import 'dart:developer' as developer;

import '../../models/user.dart';
import '../../widgets/snackbar.dart';

class UserServices {

  BuildContext context ;
  UserServices({required this.context});

  Future<void> addUser({required User user, required String confirmPassword}) async {

    UserFunctions userFunctions = UserFunctions();
    if(validateFirstName(name: user.firstName) &&
    validateLastName(name: user.lastName) &&
    await validateEmail(email: user.email) &&
    validatePassword(password: user.password)  &&
    validatePasswordConfirmPassword(password: user.password, confirmPassword: confirmPassword) &&
        await userFunctions.addUser(user)){
      if(context.mounted){
        displayMessage(
            context: context,
            title: 'Success',
            message: 'User added successfully',
            contentType: ContentType.success);
      }
    }else{
      if(context.mounted){
        displayMessage(
            context: context,
            title: 'Failure',
            message:
            'Error in adding user. Please try again after some time.',
            contentType: ContentType.failure);
      }
    }
  }

  Future<void> editUser({required User oldUser, required User newUser, required String confirmPassword}) async{
    UserFunctions userFunctions = UserFunctions();
    if(validateFirstName(name: newUser.firstName) &&
        validateLastName(name: newUser.lastName) &&
        await validateEmail(email: newUser.email) &&
        validatePassword(password: newUser.password) &&
        validatePasswordConfirmPassword(password: newUser.password, confirmPassword: confirmPassword) &&
    await userFunctions.editUser(oldUser: oldUser, newUser: newUser)){
      if(context.mounted){
        displayMessage(
            context: context,
            title: 'Success',
            message: 'User edited successfully',
            contentType: ContentType.success);
      }
    }else {
      if(context.mounted){
        displayMessage(
            context: context,
            title: 'Failure',
            message:
            'Error in editing user. Please try again after some time.',
            contentType: ContentType.failure);
      }
    }
  }

  bool validateFirstName({required String name}) {
    if (name.isEmpty) {
      developer.log("First Name field can't be empty");
      displayMessage(
          context: context,
          title: 'Error in First Name Field',
          message: 'First Name field can\'t be left empty',
          contentType: ContentType.failure);
      return false;
    }
    return true;

  }

  bool validateLastName({required String name}) {
    if (name.isEmpty) {
      developer.log("Last Name field can't be empty");
      displayMessage(
          context: context,
          title: 'Error in Last Name Field',
          message: 'First Name field can\'t be left empty',
          contentType: ContentType.failure);
      return false;
    }
    return true;

  }

  Future<bool> validateEmail({required String email}) async {

    if(email.isEmpty){
      developer.log("Email field can't be empty") ;
      displayMessage(context: context, title: 'Error in Email Field', message: 'Email field can\'t be left empty',
          contentType: ContentType.failure);
      return false ;
    }

    RegExp regExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+") ;
    if (!regExp.hasMatch(email)){
      developer.log("Please enter a valid email address") ;
      displayMessage(context: context, title: 'Error in Email Field', message: 'Please enter a valid email name',
          contentType: ContentType.failure);
      return false ;
    }

    UserFunctions userFunctions = UserFunctions();
    if(await userFunctions.isEmailExisted(email: email)){
      if(context.mounted){
        displayMessage(
            context: context,
            title: 'Payment name already present',
            message:
            'Please change the payment name as this payment name already existed',
            contentType: ContentType.help);
        return false;
      }
    }
    return true ;

  }

  validatePassword({required String password}){

    if (password.isEmpty) {
      developer.log("Password field can't be empty");
      displayMessage(
          context: context,
          title: 'Error in Password Field',
          message: 'Password field can\'t be left empty',
          contentType: ContentType.failure);
      return false;
    }
    return true;
  }

  bool validatePasswordConfirmPassword({required String password, required String confirmPassword}){
    if(password == confirmPassword){
      return true ;
    }
    displayMessage(
        context: context,
        title: 'Error in Confirm Password Field',
        message: 'Password field and Confirm Password field need to be same',
        contentType: ContentType.failure);
    return false;

  }



}