import 'package:mysql1/mysql1.dart';
import 'package:pos/utilities/mysql_parameters.dart';

class Mysql {
  Mysql();

  Future<MySqlConnection> getConnection() async {
    var settings = ConnectionSettings(
        host: host, port: port, user: user, password: password, db: db);
    return await MySqlConnection.connect(settings);
  }
}
