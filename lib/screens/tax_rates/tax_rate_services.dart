import 'dart:developer' as developer;

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:pos/database_models_functions/tax_rate_functions.dart';
import 'package:pos/models/tax_rate.dart';

import '../../database_models_functions/mysql_connection.dart';
import '../../widgets/snackbar.dart';

class TaxRateServices {
  TaxRateServices();

  Future<void> saveDetails(
      {required BuildContext context,
      required String taxName,
      required String taxCode,
      required String rate,
      required bool isFixed}) async {
    developer.log("Saving New Tax Details");
    developer.log("Tax Name : $taxName");
    developer.log("Code : $taxCode");
    developer.log("Rate : $rate");
    developer.log("Is Tax Rate Fixed : $isFixed");

    if (await validateName(context: context, name: taxName) &&
        await validateCode(context: context, code: taxCode) &&
        validateRate(context: context, rate: rate)) {
      TaxRate taxRate = TaxRate(
          taxName: taxName,
          taxCode: taxCode,
          taxRate: double.parse(rate),
          isFixedRate: isFixed);

      TaxRateFunctions taxRateFunctions = TaxRateFunctions();
      if (await taxRateFunctions.addNewTaxRate(taxRate)) {
        displayMessage(
            context: context,
            title: 'Success',
            message: 'New tax rate is saved successfully',
            contentType: ContentType.success);
      } else {
        displayMessage(
            context: context,
            title: 'Failure',
            message:
                'Error in adding new tax rate. Please try again after some time.',
            contentType: ContentType.failure);
      }
    }
  }

  Future<void> editDetails(
      {required BuildContext context,
      required TaxRate oldTaxRate,
      required String taxName,
      required String taxCode,
      required String rate,
      required bool isFixed}) async {
    developer.log("Editing the Tax Rate");
    developer.log("Old Tax Rate");
    developer.log("Tax Name : ${oldTaxRate.taxName}");
    developer.log("Code : ${oldTaxRate.taxCode}");
    developer.log("Rate : ${oldTaxRate.taxRate}");
    developer.log("Is Tax Rate Fixed : ${oldTaxRate.isFixedRate.toString()}");
    developer.log("New Tax Rate");
    developer.log("Tax Name : $taxName");
    developer.log("Code : $taxCode");
    developer.log("Rate : $rate");
    developer.log("Is Tax Rate Fixed : ${isFixed.toString()}");

    if (await validateName(context: context, name: taxName) &&
        await validateCode(context: context, code: taxCode) &&
        validateRate(context: context, rate: rate)) {
      TaxRate newTaxRate = TaxRate(
          taxName: taxName,
          taxCode: taxCode,
          taxRate: double.parse(rate),
          isFixedRate: isFixed);

      TaxRateFunctions taxRateFunctions = TaxRateFunctions();
      if (await taxRateFunctions.editTaxRate(
          oldTaxRate: oldTaxRate, newTaxRate: newTaxRate)) {
        displayMessage(
            context: context,
            title: 'Success',
            message: 'Tax rate edited successfully',
            contentType: ContentType.success);
      } else {
        displayMessage(
            context: context,
            title: 'Failure',
            message:
                'Error in editing tax rate. Please try again after some time.',
            contentType: ContentType.failure);
      }
    }
  }

  void deleteTaxRate({required TaxRate taxRate}) {
    developer.log("Deleting tax rate");
    developer.log("Details of Tax Rate");
    developer.log("Tax Name : ${taxRate.taxName}");
    developer.log("Code : ${taxRate.taxCode}");
    developer.log("Rate : ${taxRate.taxRate}");
    developer.log("Is Fixed : ${taxRate.isFixedRate.toString()}");

    TaxRateFunctions taxRateFunctions = TaxRateFunctions();
    taxRateFunctions.deleteTaxRate(taxRate: taxRate);
  }

  void cancel() {}

  Future<bool> validateName(
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

    TaxRateFunctions taxRateFunctions = TaxRateFunctions();
    if (await taxRateFunctions.isTaxNameExisted(taxName: name)) {
      displayMessage(
          context: context,
          title: 'Tax name already present',
          message:
              'Please change the tax name as this tax name already existed',
          contentType: ContentType.help);
      return false;
    }
    return true;
  }

  Future<bool> validateCode(
      {required BuildContext context, required String code}) async {
    if (code.isEmpty) {
      developer.log("Code field can't be empty");
      displayMessage(
          context: context,
          title: 'Error in Code Field',
          message: 'Code field can\'t be left empty',
          contentType: ContentType.failure);
      return false;
    }

    TaxRateFunctions taxRateFunctions = TaxRateFunctions();
    if (await taxRateFunctions.isTaxCodeExisted(taxCode: code)) {
      displayMessage(
          context: context,
          title: 'Tax code already present',
          message:
              'Please change the tax code as this tax name already existed',
          contentType: ContentType.help);
      return false;
    }
    return true;
  }

  bool validateRate({required BuildContext context, required String rate}) {
    if (rate.isEmpty) {
      developer.log("Rate field can't be empty");
      displayMessage(
          context: context,
          title: 'Error in Rate Field',
          message: 'Rate field can\'t be left empty',
          contentType: ContentType.failure);
      return false;
    }
    if (!(double.tryParse(rate) != null)) {
      developer.log("Rate field must contain only number");
      displayMessage(
          context: context,
          title: 'Error in Rate Field',
          message:
              'Rate field need to contain only numbers in integers or decimal format (e.g. 12, 16.8)',
          contentType: ContentType.warning);
      return false;
    }
    return true;
  }
}
