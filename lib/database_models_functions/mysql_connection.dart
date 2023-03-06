import 'package:mysql1/mysql1.dart';
import 'package:pos/utilities/mysql_parameters.dart';
import 'dart:developer' as developer;

class Mysql {
  Mysql();

  Future<MySqlConnection> getConnection() async {
    try{
      var settings = ConnectionSettings(
          host: host, port: port, user: user, password: password, db: db);
      return await MySqlConnection.connect(settings);
    }on Exception catch(error, stackTrace){
      developer.log("Error in connecting with database. Please check the credentials");
      developer.log(error.toString());
      developer.log(stackTrace.toString());
      rethrow;
    }

  }
}
