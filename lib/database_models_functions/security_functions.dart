import 'package:mysql1/mysql1.dart';

import '../models/security.dart';
import 'mysql_connection.dart';
import 'dart:developer' as developer;

class SecurityFunctions {
  SecurityFunctions();

  Future<List<Security>> getSecurityDetails({required String section}) async {
    try {
      Mysql database = Mysql();
      MySqlConnection connection = await database.getConnection();
      var results = await connection.query('''SELECT `security`.`key_field`,
                    `security`.`key_name`,
                    `security`.`access_level`,
                    `security`.`section`,
                    `security`.`information`
                FROM `pos`.`security` 
                WHERE `security`.`section` = ? 
                ''', [section]);
      List<Security> securities = [];
      for (var row in results) {
        developer.log("Field : ${row[0]}");
        developer.log("Name : ${row[1]}");
        developer.log("Access Level : ${row[2]}");
        developer.log("Section : ${row[3]}");
        developer.log("Information : ${row[4]}");
        String information = row[4] ?? "";
        securities.add(Security(
            keyField: row[0],
            keyName: row[1],
            accessLevel: row[2],
            section: row[3],
            information: information));
      }
      developer.log("Security obtained successfully ");
      return securities;
    } on Exception catch (error, stackTrace) {
      developer.log("Error in loading security options");
      developer.log(error.toString());
      developer.log(stackTrace.toString());
      rethrow;
    }
  }
}
