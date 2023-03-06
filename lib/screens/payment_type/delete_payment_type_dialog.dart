import 'package:flutter/material.dart';
import 'package:pos/database_models_functions/payment_type_functions.dart';
import 'dart:developer' as developer;

import '../../models/payment_type.dart';

class DeletePaymentTypeDialogBox extends StatefulWidget {
  List<PaymentType> paymentTypes;
  DeletePaymentTypeDialogBox({Key? key, required this.paymentTypes})
      : super(key: key);

  @override
  State<DeletePaymentTypeDialogBox> createState() =>
      _DeletePaymentTypeDialogBoxState();
}

class _DeletePaymentTypeDialogBoxState
    extends State<DeletePaymentTypeDialogBox> {
  String delete = "";
  PaymentTYpeFunctions paymentTypeFunctions = PaymentTYpeFunctions();

  @override
  void initState() {
    super.initState();
    for (PaymentType paymentType in widget.paymentTypes) {
      delete = "$delete${paymentType.name} , ";
    }
    delete = delete.substring(0, delete.length - 2);
    developer.log("All the deleted tax rates  names : $delete");
  }

  deletePaymentTypes() {
    for (PaymentType paymentType in widget.paymentTypes) {
      paymentTypeFunctions.deletePaymentType(paymentType: paymentType);
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
              const SizedBox(
                height: 20,
              ),
              Text(
                'Delete Payment Types',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Please confirm to delete following payment types !!',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                delete,
                style: Theme.of(context).textTheme.titleSmall,
                maxLines: 3,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      deletePaymentTypes();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                      textStyle: Theme.of(context).textTheme.titleMedium,
                    ),
                    child: const Text('Delete'),
                  ),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: Theme.of(context).textTheme.titleMedium,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
