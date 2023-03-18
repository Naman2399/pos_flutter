import 'package:mysql1/mysql1.dart';

import '../models/user.dart';
import 'mysql_connection.dart';
import 'dart:developer' as developer;

class UserFunctions{
  UserFunctions() ;

  Future<bool> addUser(User user) async {
    try {
      Mysql database = Mysql();
      MySqlConnection connection = await database.getConnection();
      await connection.query(
          '''INSERT INTO `pos`.`user`
                  (`email`,
                  `firstName`,
                  `lastName`,
                  `password`,
                  `access_level`,
                  `active`)
                  VALUES
                  (?,?,?,?,?,?)''',
          [
            user.email, user.firstName, user.lastName, user.password, user.accessLevel, user.active
          ]);
      developer.log("User added successfully ");
      return true;
    } on Exception catch (error, stackTrace) {
      developer.log("Error in adding new user");
      developer.log(error.toString());
      developer.log(stackTrace.toString());
      rethrow;
    }

  }

  Future<List<User>> getAllUsers() async {
    try {
      Mysql database = Mysql();
      MySqlConnection connection = await database.getConnection();
      var results = await connection
          .query('''SELECT `user`.`email`,
                        `user`.`firstName`,
                        `user`.`lastName`,
                        `user`.`password`,
                        `user`.`access_level`,
                        `user`.`active`
                    FROM `pos`.`user` ''');
      List<User> users = [];
      for (var row in results) {
        developer.log("Email : ${row[0]}");
        developer.log("First Name : ${row[1]}");
        developer.log("Last Name : ${row[2]}");
        developer.log("Password : ${row[3]}");
        developer.log("Access level : ${row[4]}");
        developer.log("Active : ${row[5]}");
        bool active;
        if (row[5] == 0) {
          active = false;
        } else {
          active = true;
        }
        users.add(User(email: row[0], firstName: row[1], lastName: row[2], password: row[3], accessLevel: row[4], active: active));
      }

      developer.log("All users are loaded successfully from database ");
      return users;
    } on Exception catch (error, stackTrace) {
      developer.log("Error in fetching users details");
      developer.log(error.toString());
      developer.log(stackTrace.toString());
      rethrow;
    }
  }

  Future<bool> editUser(
      {required User oldUser, required User newUser}) async {
    try {
      Mysql database = Mysql();
      MySqlConnection connection = await database.getConnection();
      connection.query('''UPDATE `pos`.`user`
                          SET
                          `email` = ?,
                          `firstName` = ?,
                          `lastName` = ? ,
                          `password` = ? ,
                          `access_level` = ?,
                          `active` = ?
                          WHERE `email` = ?''', [
        newUser.email,
        newUser.firstName,
        newUser.lastName,
        newUser.password,
        newUser.accessLevel,
        newUser.active,
        oldUser.email
      ]);
      developer.log("User Edited successfully ");
      return true;
    } on Exception catch (error, stackTrace) {
      developer.log("Error in editing user");
      developer.log(error.toString());
      developer.log(stackTrace.toString());
      rethrow;
    }
  }

  Future<bool> deleteUser({required User user}) async {
    try {
      Mysql database = Mysql();
      MySqlConnection connection = await database.getConnection();
      connection.query('''DELETE FROM `pos`.`user`
                          WHERE 'email' = ? ''', []);
      developer.log("User Deleted successfully : ${user.email} ");
      return true;
    } on Exception catch (error, stackTrace) {
      developer.log("Error in deleting user");
      developer.log(error.toString());
      developer.log(stackTrace.toString());
      rethrow;
    }
  }

  Future<bool> isEmailExisted({required String email}) async {
    try {
      Mysql database = Mysql();
      MySqlConnection connection = await database.getConnection();
      var results = await connection.query(
          '''SELECT COUNT(*) FROM user WHERE user.email = ? ''',
          [email]);
      int count = 0;
      for (var result in results) {
        count = result[0];
      }
      if (count > 0) {
        developer.log("User Email already existed ");
        return true;
      }
      return false;
    } on Exception catch (error, stackTrace) {
      developer.log("Error in reaching database for user table");
      developer.log(error.toString());
      developer.log(stackTrace.toString());
      rethrow;
    }
  }

}