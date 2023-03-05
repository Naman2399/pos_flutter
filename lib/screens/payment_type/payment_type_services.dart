import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:pos/database_models_functions/payment_type_functions.dart';
import 'package:pos/models/payment_type.dart';
import 'dart:developer' as developer;

import '../../widgets/snackbar.dart';

class PaymentTypeServices {
  PaymentTypeServices();

  Future<void> saveDetails(
      {required BuildContext context, required PaymentType paymentType}) async {
    PaymentTYpeFunctions paymentTYpeFunctions = PaymentTYpeFunctions();
    if (await isValidName(context: context, name: paymentType.name) &&
        await isValidCode(context: context, code: paymentType.code) &&
        await isValidShortcutKey(
            context: context, shortcutKey: paymentType.shortcutKey) &&
        await paymentTYpeFunctions.addNewPaymentType(paymentType)) {
      displayMessage(
          context: context,
          title: 'Success',
          message: 'New payment type is saved successfully',
          contentType: ContentType.success);
    } else {
      displayMessage(
          context: context,
          title: 'Failure',
          message:
              'Error in adding new payment type. Please try again after some time.',
          contentType: ContentType.failure);
    }
  }

  Future<void> editDetails(
      {required BuildContext context,
      required PaymentType oldPaymentType,
      required PaymentType newPaymentType}) async {
    PaymentTYpeFunctions paymentTypeFunctions = PaymentTYpeFunctions();
    if (await isValidName(context: context, name: newPaymentType.name) &&
        await isValidCode(context: context, code: newPaymentType.code) &&
        await isValidShortcutKey(
            context: context, shortcutKey: newPaymentType.shortcutKey) &&
        await paymentTypeFunctions.editPaymentType(
            oldPaymentType: oldPaymentType, newPaymentType: newPaymentType)) {
      displayMessage(
          context: context,
          title: 'Success',
          message: 'Payment type edited successfully',
          contentType: ContentType.success);
    } else {
      displayMessage(
          context: context,
          title: 'Failure',
          message:
              'Error in editing payment type. Please try again after some time.',
          contentType: ContentType.failure);
    }
  }

  Future<bool> isValidName(
      {required BuildContext context, required String name}) async {
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
      displayMessage(
          context: context,
          title: 'Payment name already present',
          message:
              'Please change the payment name as this payment name already existed',
          contentType: ContentType.help);
      return false;
    }
    return true;
  }

  Future<bool> isValidShortcutKey(
      {required BuildContext context, required String shortcutKey}) async {
    PaymentTYpeFunctions paymentTYpeFunctions = PaymentTYpeFunctions();
    if (await paymentTYpeFunctions.isPaymentShortcutKeyExisted(
        shortcutKey: shortcutKey)) {
      displayMessage(
          context: context,
          title: 'Payment shortcut key already present',
          message:
              'Please change the payment shortcut key as this already existed',
          contentType: ContentType.help);
      return false;
    }
    return true;
  }

  Future<bool> isValidCode(
      {required BuildContext context, required String code}) async {
    PaymentTYpeFunctions paymentTYpeFunctions = PaymentTYpeFunctions();
    if (await paymentTYpeFunctions.isPaymentCodeExisted(code: code)) {
      displayMessage(
          context: context,
          title: 'Payment shortcut key already present',
          message:
              'Please change the payment shortcut key as this already existed',
          contentType: ContentType.help);
      return false;
    }
    return true;
  }
}
