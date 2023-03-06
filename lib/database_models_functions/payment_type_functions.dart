import 'package:mysql1/mysql1.dart';
import 'package:pos/models/payment_type.dart';

import 'mysql_connection.dart';
import 'dart:developer' as developer;

class PaymentTYpeFunctions {
  PaymentTYpeFunctions();

  Future<bool> addNewPaymentType(PaymentType paymentType) async {
    try {
      Mysql database = Mysql();
      MySqlConnection connection = await database.getConnection();
      await connection.query('''INSERT INTO pos.payment_type
              (name, code, shortcut_key , position,
              enabled, quick_payment, customer_required,
              print_receipt, change_allowed, mark_transaction,
              open_cash_drawer)
              VALUES
              (?,?,?,?,?,?,?,?,?,?,?)''', [
        paymentType.name,
        paymentType.code,
        paymentType.shortcutKey,
        paymentType.position,
        paymentType.enabled,
        paymentType.quickPayment,
        paymentType.customerRequired,
        paymentType.printReceipt,
        paymentType.changeAllowed,
        paymentType.markTransaction,
        paymentType.openCashDrawer
      ]);

      developer.log("New Payment Type is saved successfully ");
      return true;
    } on Exception catch (error, stackTrace) {
      developer.log("Error in saving new payment type");
      developer.log(error.toString());
      developer.log(stackTrace.toString());
      rethrow;
    }
  }

  Future<bool> editPaymentType(
      {required PaymentType oldPaymentType,
      required PaymentType newPaymentType}) async {
    try {
      Mysql database = Mysql();
      MySqlConnection connection = await database.getConnection();
      connection.query('''UPDATE `pos`.`payment_type`
                            SET
                            `name` = ?,
                            `code` = ?,
                            `shortcut_key` = ?,
                            `position` = ?,
                            `enabled` = ?,
                            `quick_payment` =?,
                            `customer_required` = ?,
                            `print_receipt` = ?,
                            `change_allowed` = ?,
                            `mark_transaction` = ?,
                            `open_cash_drawer` = ? 
                            WHERE `name` = ?;''', [
        newPaymentType.name,
        newPaymentType.code,
        newPaymentType.shortcutKey,
        newPaymentType.position,
        newPaymentType.enabled,
        newPaymentType.quickPayment,
        newPaymentType.customerRequired,
        newPaymentType.printReceipt,
        newPaymentType.changeAllowed,
        newPaymentType.markTransaction,
        newPaymentType.openCashDrawer,
        oldPaymentType.name
      ]);
      developer.log("Payment Type Edited successfully ");
      return true;
    } on Exception catch (error, stackTrace) {
      developer.log("Error in editing payment type");
      developer.log(error.toString());
      developer.log(stackTrace.toString());
      rethrow;
    }
  }

  Future<bool> deletePaymentType({required PaymentType paymentType}) async {
    try {
      Mysql database = Mysql();
      MySqlConnection connection = await database.getConnection();
      connection.query('''DELETE FROM pos.payment_type 
                          WHERE pos.payment_type.name = ? ''',
          [paymentType.name]);
      developer.log("Payment TYpe Deleted successfully : ${paymentType.name} ");
      return true;
    } on Exception catch (error, stackTrace) {
      developer.log("Error in deleting payment type");
      developer.log(error.toString());
      developer.log(stackTrace.toString());
      rethrow;
    }
  }

  Future<List<PaymentType>> getAllPaymentTypes() async {
    try {
      Mysql database = Mysql();
      MySqlConnection connection = await database.getConnection();
      var results = await connection.query('''SELECT 
                        `payment_type`.`name`,
                        `payment_type`.`code`,
                        `payment_type`.`shortcut_key`,
                        `payment_type`.`position`,
                        `payment_type`.`enabled`,
                        `payment_type`.`quick_payment`,
                        `payment_type`.`customer_required`,
                        `payment_type`.`print_receipt`,
                        `payment_type`.`change_allowed`,
                        `payment_type`.`mark_transaction`,
                        `payment_type`.`open_cash_drawer`
                    FROM
                        `pos`.`payment_type` ''');
      List<PaymentType> paymentTypes = [];
      for (var row in results) {
        developer.log("Payment Name : ${row[0]}");
        developer.log("Payment Code : ${row[1]}");
        developer.log("Payment Shortcut Key : ${row[2]}");
        developer.log("Position : ${row[3]}");
        developer.log("Enabled : ${row[4]}");
        developer.log("Quick Payment : ${row[5]}");
        developer.log("Customer  Required : ${row[6]}");
        developer.log("Print Receipt : ${row[7]}");
        developer.log("Change Allowed : ${row[8]}");
        developer.log("Mark Transaction : ${row[9]}");
        developer.log("Open Cash Drawer : ${row[10]}");
        paymentTypes.add(PaymentType(
            name: row[0],
            code: row[1],
            shortcutKey: row[2],
            position: row[3],
            enabled: row[4] == 0 ? false : true,
            quickPayment: row[5] == 0 ? false : true,
            customerRequired: row[6] == 0 ? false : true,
            printReceipt: row[7] == 0 ? false : true,
            changeAllowed: row[8] == 0 ? false : true,
            markTransaction: row[9] == 0 ? false : true,
            openCashDrawer: row[10] == 0 ? false : true));
      }
      developer
          .log("All the payment types are loaded successfully from database ");
      return paymentTypes;
    } on Exception catch (error, stackTrace) {
      developer.log("Error in fetching payment types");
      developer.log(error.toString());
      developer.log(stackTrace.toString());
      rethrow;
    }
  }

  Future<bool> isPaymentNameExisted({required String name}) async {
    try {
      Mysql database = Mysql();
      MySqlConnection connection = await database.getConnection();
      var results = await connection.query(
          '''select count(*) from pos.payment_type where pos.name = ?''',
          [name]);
      int count = 0;
      for (var result in results) {
        count = result[0];
      }
      if (count > 0) {
        developer.log("Payment Name already existed ");
        return true;
      }
      return false;
    } on Exception catch (error, stackTrace) {
      developer.log("Error in reaching database for payment_type table");
      developer.log(error.toString());
      developer.log(stackTrace.toString());
      rethrow;
    }
  }

  Future<bool> isPaymentCodeExisted({required String code}) async {
    try {
      Mysql database = Mysql();
      MySqlConnection connection = await database.getConnection();
      var results = await connection.query(
          '''select count(*) from pos.payment_type where pos.code = ?''',
          [code]);
      int count = 0;
      for (var result in results) {
        count = result[0];
      }
      if (count > 0) {
        developer.log("Payment Code already existed ");
        return true;
      }
      return false;
    } on Exception catch (error, stackTrace) {
      developer.log("Error in reaching database for payment_type table");
      developer.log(error.toString());
      developer.log(stackTrace.toString());
      rethrow;
    }
  }

  Future<bool> isPaymentShortcutKeyExisted(
      {required String shortcutKey}) async {
    try {
      Mysql database = Mysql();
      MySqlConnection connection = await database.getConnection();
      var results = await connection.query(
          '''select count(*) from pos.payment_type where pos.shortcut_key = ?''',
          [shortcutKey]);
      int count = 0;
      for (var result in results) {
        count = result[0];
      }
      if (count > 0) {
        developer.log("Payment Shortcut Key already existed ");
        return true;
      }
      return false;
    } on Exception catch (error, stackTrace) {
      developer.log("Error in reaching database for payment_type table");
      developer.log(error.toString());
      developer.log(stackTrace.toString());
      rethrow;
    }
  }
}
