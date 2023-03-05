import 'package:mysql1/mysql1.dart';
import 'package:pos/models/tax_rate.dart';

import 'mysql_connection.dart';
import 'dart:developer' as developer;

class TaxRateFunctions {
  TaxRateFunctions();

  Future<bool> addNewTaxRate(TaxRate taxRate) async {
    try {
      Mysql database = Mysql();
      MySqlConnection connection = await database.getConnection();
      await connection.query(
          'INSERT INTO pos.tax_rates '
          '(tax_name, tax_code, tax_rate, isFixed) '
          'VALUES (?, ? ,? ,?)',
          [
            taxRate.taxName,
            taxRate.taxCode,
            taxRate.taxRate,
            taxRate.isFixedRate
          ]);

      developer.log("New Tax  Rate is saved successfully ");
      return true;
    } on Exception catch (error) {
      developer.log("Error in saving new tax rate");
      developer.log(error.toString());
      return false;
    }
  }

  Future<List<TaxRate>?> getAllTaxRates() async {
    try {
      Mysql database = Mysql();
      MySqlConnection connection = await database.getConnection();
      var results = await connection
          .query('SELECT tax_rates.tax_name, tax_rates.tax_code, '
              'tax_rates.tax_rate, tax_rates.isFixed FROM pos.tax_rates');
      List<TaxRate> taxRates = [];
      for (var row in results) {
        developer.log("Tax Name : ${row[0]}");
        developer.log("Tax Code : ${row[1]}");
        developer.log("Tax Rate : ${row[2]}");
        developer.log("Is Fixed : ${row[3]}");
        bool value;
        if (row[3] == 0) {
          value = false;
        } else {
          value = true;
        }
        taxRates.add(TaxRate(
            taxName: row[0],
            taxCode: row[1],
            taxRate: row[2],
            isFixedRate: value));
      }

      developer.log("All the tax rates are loaded successfully from database ");
      return taxRates;
    } on Exception catch (error) {
      developer.log("Error in fetching tax rates");
      developer.log(error.toString());
      return null;
    }
  }

  Future<bool> editTaxRate(
      {required TaxRate oldTaxRate, required TaxRate newTaxRate}) async {
    try {
      Mysql database = Mysql();
      MySqlConnection connection = await database.getConnection();
      connection.query('''UPDATE pos.tax_rates
                          SET
                          tax_name = ?,
                          tax_code = ?,
                          tax_rate = ?,
                          isFixed = ? 
                          WHERE tax_name = ?''', [
        newTaxRate.taxName,
        newTaxRate.taxCode,
        newTaxRate.taxRate,
        newTaxRate.isFixedRate,
        oldTaxRate.taxName
      ]);
      developer.log("Tax Rate Edited successfully ");
      return true;
    } on Exception catch (error) {
      developer.log("Error in saving new tax rate");
      developer.log(error.toString());
      return false;
    }
  }

  Future<bool> deleteTaxRate({required TaxRate taxRate}) async {
    try {
      Mysql database = Mysql();
      MySqlConnection connection = await database.getConnection();
      connection.query('''DELETE FROM pos.tax_rates
                          WHERE tax_name = ? ''', [taxRate.taxName]);
      developer.log("Tax Rate Deleted successfully : ${taxRate.taxName} ");
      return true;
    } on Exception catch (error) {
      developer.log("Error in saving new tax rate");
      developer.log(error.toString());
      return false;
    }
  }

  Future<bool> isTaxNameExisted({required String taxName}) async {
    try {
      Mysql database = Mysql();
      MySqlConnection connection = await database.getConnection();
      var results = await connection.query(
          '''SELECT count(*) FROM tax_rates WHERE tax_rates.tax_name = ?''',
          [taxName]);
      int count = 0;
      for (var result in results) {
        count = result[0];
      }
      if (count > 0) {
        developer.log("Tax Name already existed ");
        return true;
      }
      return false;
    } on Exception catch (error) {
      developer.log("Error in reaching database for tax_rate table");
      developer.log(error.toString());
      return true;
    }
  }

  Future<bool> isTaxCodeExisted({required String taxCode}) async {
    try {
      Mysql database = Mysql();
      MySqlConnection connection = await database.getConnection();
      var results = await connection.query(
          '''SELECT count(*) FROM tax_rates WHERE tax_rates.tax_code = ?''',
          [taxCode]);
      int count = 0;
      for (var result in results) {
        count = result[0];
      }
      if (count > 0) {
        developer.log("Tax Code already existed ");
        return true;
      }
      return false;
    } on Exception catch (error) {
      developer.log("Error in reaching database for tax_rate table");
      developer.log(error.toString());
      return true;
    }
  }
}
