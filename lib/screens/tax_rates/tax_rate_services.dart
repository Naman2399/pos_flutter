import 'dart:developer' as developer;

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:pos/database_models_functions/tax_rate_functions.dart';
import 'package:pos/models/tax_rate.dart';

import '../../widgets/snackbar.dart';

class TaxRateServices {
  final BuildContext context;

  TaxRateServices({required this.context});

  Future<void> saveDetails(
      {required TaxRate taxRate}) async {

    if (await validateName(name: taxRate.taxName) &&
        await validateCode(code: taxRate.taxCode) &&
        validateRate(rate: taxRate.taxRate.toString())) {

      TaxRateFunctions taxRateFunctions = TaxRateFunctions();
      if (await taxRateFunctions.addNewTaxRate(taxRate)) {
        if(context.mounted){
          displayMessage(
              context: context,
              title: 'Success',
              message: 'New tax rate is saved successfully',
              contentType: ContentType.success);
        }

      } else {
        if(context.mounted){
          displayMessage(
              context: context,
              title: 'Failure',
              message:
              'Error in adding new tax rate. Please try again after some time.',
              contentType: ContentType.failure);
        }

      }
    }
  }

  Future<void> editDetails(
      {required TaxRate oldTaxRate,
      required TaxRate newTaxRate}) async {

    if (await validateName(name: newTaxRate.taxName) &&
        await validateCode(code: newTaxRate.taxCode) &&
        validateRate(rate: newTaxRate.taxRate.toString())) {

      TaxRateFunctions taxRateFunctions = TaxRateFunctions();
      if (await taxRateFunctions.editTaxRate(
          oldTaxRate: oldTaxRate, newTaxRate: newTaxRate)) {
        if(context.mounted){
          displayMessage(
              context: context,
              title: 'Success',
              message: 'Tax rate edited successfully',
              contentType: ContentType.success);
        }

      } else {
        if(context.mounted){
          displayMessage(
              context: context,
              title: 'Failure',
              message:
              'Error in editing tax rate. Please try again after some time.',
              contentType: ContentType.failure);
        }

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
      {required String name}) async {
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
      if(context.mounted){
        displayMessage(
            context: context,
            title: 'Tax name already present',
            message:
            'Please change the tax name as this tax name already existed',
            contentType: ContentType.help);
        return false;
      }
    }
    return true;
  }

  Future<bool> validateCode(
      {required String code}) async {
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
      if (context.mounted){
        displayMessage(
            context: context,
            title: 'Tax code already present',
            message:
            'Please change the tax code as this tax name already existed',
            contentType: ContentType.help);
        return false;
      }

    }
    return true;
  }

  bool validateRate({required String rate}) {
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
