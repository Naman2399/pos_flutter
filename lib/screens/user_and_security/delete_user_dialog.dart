import 'package:flutter/material.dart';
import 'package:pos/database_models_functions/tax_rate_functions.dart';
import 'package:pos/database_models_functions/user_functions.dart';
import 'dart:developer' as developer;


import '../../models/tax_rate.dart';
import '../../models/user.dart';

class DeleteUserDialogBox extends StatefulWidget {
  List<User> users ;
  DeleteUserDialogBox({Key? key, required this.users}) : super(key: key);

  @override
  State<DeleteUserDialogBox> createState() => _DeleteUserDialogBoxState();
}

class _DeleteUserDialogBoxState extends State<DeleteUserDialogBox> {

  _DeleteUserDialogBoxState();
  String delete = "" ;
  UserFunctions userFunctions = UserFunctions() ;

  @override
  void initState() {
    super.initState();
    for(User user in widget.users){
      delete = "$delete${user.email} , " ;
    }
    delete = delete.substring(0, delete.length - 2);
    developer.log("All the deleted users emails : $delete");
  }

  deleteTaxRate() {
    for(User user in widget.users){
      userFunctions.deleteUser(user: user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.5,
        color: Theme.of(context).colorScheme.background,
        child: Card(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Text('Delete Users', style: Theme.of(context).textTheme.titleLarge,),
              const SizedBox(height: 30,),
              Text('Please confirm to delete following users !!' , style: Theme.of(context).textTheme.titleMedium,),
              const SizedBox(height: 10,),
              Text(delete, style: Theme.of(context).textTheme.titleSmall, maxLines: 3,),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 10,),
                  ElevatedButton(onPressed: () {
                    deleteTaxRate();
                    Navigator.pop(context);
                  },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                      textStyle: Theme.of(context).textTheme.titleMedium,

                    ), child: const Text('Delete'),),
                  const Spacer(),
                  TextButton(onPressed: () {
                    Navigator.pop(context);
                  }, child: Text('Cancel', style: Theme.of(context).textTheme.titleMedium,)),
                  const SizedBox(width: 10,),
                ],
              ),
              const SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }
}
