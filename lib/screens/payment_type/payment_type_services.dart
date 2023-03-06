import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:pos/database_models_functions/payment_type_functions.dart';
import 'package:pos/models/payment_type.dart';
import 'dart:developer' as developer;

import '../../widgets/snackbar.dart';

class PaymentTypeServices {
  BuildContext context ;
  PaymentTypeServices({required this.context});

  Future<void> saveDetails(
      {required PaymentType paymentType}) async {
    PaymentTYpeFunctions paymentTYpeFunctions = PaymentTYpeFunctions();
    if (await isValidName(name: paymentType.name) &&
        await isValidCode(code: paymentType.code) &&
        await isValidShortcutKey(shortcutKey: paymentType.shortcutKey) &&
        await paymentTYpeFunctions.addNewPaymentType(paymentType)) {
      if(context.mounted){
        displayMessage(
            context: context,
            title: 'Success',
            message: 'New payment type is saved successfully',
            contentType: ContentType.success);
      }

    } else {
      if(context.mounted){
        displayMessage(
            context: context,
            title: 'Failure',
            message:
            'Error in adding new payment type. Please try again after some time.',
            contentType: ContentType.failure);
      }

    }
  }

  Future<void> editDetails(
      {required PaymentType oldPaymentType,
      required PaymentType newPaymentType}) async {
    PaymentTYpeFunctions paymentTypeFunctions = PaymentTYpeFunctions();
    if (await isValidName(name: newPaymentType.name) &&
        await isValidCode(code: newPaymentType.code) &&
        await isValidShortcutKey(shortcutKey: newPaymentType.shortcutKey) &&
        await paymentTypeFunctions.editPaymentType(
            oldPaymentType: oldPaymentType, newPaymentType: newPaymentType)) {
      if(context.mounted){
        displayMessage(
            context: context,
            title: 'Success',
            message: 'Payment type edited successfully',
            contentType: ContentType.success);
      }
    } else {
      if(context.mounted){
        displayMessage(
            context: context,
            title: 'Failure',
            message:
            'Error in editing payment type. Please try again after some time.',
            contentType: ContentType.failure);
      }
    }
  }

  Future<bool> isValidName({required String name}) async {
    if (name.isEmpty) {
      developer.log("Name field can't be empty");
      displayMessage(
          context: context,
          title: 'Error in Name Field',
          message: 'Name field can\'t be left empty',
          contentType: ContentType.failure);
      return false;
    }
    PaymentTYpeFunctions paymentTYpeFunctions = PaymentTYpeFunctions();
    if (await paymentTYpeFunctions.isPaymentNameExisted(name: name)) {
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
    return true;
  }

  Future<bool> isValidShortcutKey({required String shortcutKey}) async {
    PaymentTYpeFunctions paymentTYpeFunctions = PaymentTYpeFunctions();
    if (await paymentTYpeFunctions.isPaymentShortcutKeyExisted(
        shortcutKey: shortcutKey)) {
      if(context.mounted){
        displayMessage(
            context: context,
            title: 'Payment shortcut key already present',
            message:
            'Please change the payment shortcut key as this already existed',
            contentType: ContentType.help);
        return false;
      }
    }
    return true;
  }

  Future<bool> isValidCode({required String code}) async {
    PaymentTYpeFunctions paymentTYpeFunctions = PaymentTYpeFunctions();
    if (await paymentTYpeFunctions.isPaymentCodeExisted(code: code)) {
      if(context.mounted){
        displayMessage(
            context: context,
            title: 'Payment shortcut key already present',
            message:
            'Please change the payment shortcut key as this already existed',
            contentType: ContentType.help);
        return false;
      }
    }
    return true;
  }
}
