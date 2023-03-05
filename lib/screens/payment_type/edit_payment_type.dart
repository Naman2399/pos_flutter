import 'dart:ui';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos/models/payment_type.dart';
import 'package:pos/screens/payment_type/payment_type_services.dart';
import 'dart:developer' as developer;

import '../../widgets/snackbar.dart';
import '../../widgets/text_decorations.dart';

class EditPaymentType extends StatefulWidget {
  final PaymentType paymentType;
  const EditPaymentType({Key? key, required this.paymentType})
      : super(key: key);

  @override
  State<EditPaymentType> createState() => _EditPaymentTypeState();
}

class _EditPaymentTypeState extends State<EditPaymentType> {
  PaymentTypeServices paymentTypeServices = PaymentTypeServices();
  TextEditingController name = TextEditingController();
  TextEditingController code = TextEditingController();
  TextEditingController shortcutKey = TextEditingController();
  TextEditingController position = TextEditingController();
  bool isEnabled = true;
  bool isQuickPayment = true;
  bool isCustomerRequired = true;
  bool isPrintReceipt = true;
  bool isChangeAllowed = true;
  bool isPaid = true;
  bool isOpenCashDrawer = true;

  @override
  void initState() {
    super.initState();
    name.text = widget.paymentType.name;
    code.text = widget.paymentType.code;
    shortcutKey.text = widget.paymentType.shortcutKey;
    position.text = widget.paymentType.position.toString();
    isEnabled = widget.paymentType.enabled;
    isQuickPayment = widget.paymentType.quickPayment;
    isPrintReceipt = widget.paymentType.printReceipt;
    isChangeAllowed = widget.paymentType.changeAllowed;
    isPaid = widget.paymentType.markTransaction;
    isOpenCashDrawer = widget.paymentType.openCashDrawer;
  }

  decrement() {
    try {
      int val = int.parse(position.text);
      val = val - 1;
      if (val < 0) {
        val = 0;
        return;
      }
      setState(() {
        position.text = val.toString();
      });
    } on Exception catch (error) {
      developer.log("Error in position field need to be integer type");
      developer.log(error.toString());
      displayMessage(
          context: context,
          title: 'Error in Position Field',
          message:
              'Position field need to contain only numbers in integers format (e.g. 12, 16)',
          contentType: ContentType.failure);
    }
  }

  increment() {
    try {
      int val = int.parse(position.text);
      val = val + 1;
      setState(() {
        position.text = val.toString();
      });
    } on Exception catch (error) {
      developer.log("Error in position field need to be integer type");
      developer.log(error.toString());
      displayMessage(
          context: context,
          title: 'Error in Position Field',
          message:
              'Position field need to contain only numbers in integers format (e.g. 12, 16)',
          contentType: ContentType.failure);
    }
  }

  editDetails() {
    developer.log("Edit Payment Type Details : ");
    developer.log("Name : ${name.text}");
    developer.log("Code : ${code.text}");
    developer.log("Shortcut key : ${shortcutKey.text}");
    developer.log("Position : ${position.text}");
    developer.log("Is Fixed : ${isEnabled.toString()}");
    developer.log("Is Quick Payment : ${isQuickPayment.toString()}");
    developer.log("Is Custom Required : ${isCustomerRequired.toString()}");
    developer.log("Is Print receipt : ${isPrintReceipt.toString()}");
    developer.log("Is Change allowed : ${isChangeAllowed.toString()}");
    developer.log("Is Transaction Paid : ${isPaid.toString()}");
    developer.log("Is Open Cash Drawer : ${isOpenCashDrawer.toString()}");
    if (name.text.isEmpty && code.text.isEmpty && position.text.isEmpty) {
      developer.log("Either name, code or position field is empty");
      displayMessage(
          context: context,
          title: 'Important field is empty',
          message:
              'Please make sure to have a value in name, code, and position field they can\'t be left empty',
          contentType: ContentType.failure);
      return;
    }
    PaymentType newPaymentType = PaymentType(
        name: name.text,
        code: code.text,
        shortcutKey: shortcutKey.text,
        position: int.parse(position.text),
        enabled: isEnabled,
        quickPayment: isQuickPayment,
        customerRequired: isCustomerRequired,
        printReceipt: isPrintReceipt,
        changeAllowed: isChangeAllowed,
        markTransaction: isPaid,
        openCashDrawer: isOpenCashDrawer);
    paymentTypeServices.editDetails(
        context: context,
        oldPaymentType: widget.paymentType,
        newPaymentType: newPaymentType);
  }

  cancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Payment Type : ${widget.paymentType.name}"),
        ),
        body: Container(
          margin: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Wrap(
                children: [
                  Text(
                    "New Payment Type     ",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    ' (* Field must be filled and can\'t be left empty.)',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Wrap(
                children: [
                  Text(
                    'Name ',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    '*',
                    style: TextStyle(fontFeatures: [FontFeature.superscripts()]),
                  ),
                ],
              ),
              TextField(
                controller: name,
                decoration: inputDecorationCustom(context: context),
              ),
              const SizedBox(
                height: 10,
              ),
              Wrap(
                children: [
                  Text(
                    'Code ',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    '*',
                    style: TextStyle(fontFeatures: [FontFeature.superscripts()]),
                  ),
                ],
              ),
              TextField(
                controller: code,
                decoration: inputDecorationCustom(context: context),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Shortcut key',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              TextField(
                controller: shortcutKey,
                decoration: inputDecorationCustom(context: context),
              ),
              const SizedBox(
                height: 10,
              ),
              Wrap(
                children: [
                  Text(
                    'Position ',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    '*',
                    style: TextStyle(fontFeatures: [FontFeature.superscripts()]),
                  ),
                ],
              ),
              Text(
                'This field must contain an integer value',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      decrement();
                    },
                    icon: const Icon(
                      Icons.remove,
                      size: 15,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: position,
                      decoration: inputDecorationCustom(context: context),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      increment();
                    },
                    icon: const Icon(
                      Icons.add,
                      size: 15,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Switch(
                      value: isEnabled,
                      onChanged: (bool value) {
                        setState(() {
                          isEnabled = value;
                        });
                      }),
                  Text(
                    'Enabled',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Row(
                children: [
                  Switch(
                      value: isQuickPayment,
                      onChanged: (bool value) {
                        setState(() {
                          isQuickPayment = value;
                        });
                      }),
                  Text(
                    'Quick Payment',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Row(
                children: [
                  Switch(
                      value: isCustomerRequired,
                      onChanged: (bool value) {
                        setState(() {
                          isCustomerRequired = value;
                        });
                      }),
                  Text(
                    'Customer required',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Row(
                children: [
                  Switch(
                      value: isPrintReceipt,
                      onChanged: (bool value) {
                        setState(() {
                          isPrintReceipt = value;
                        });
                      }),
                  Text(
                    'Print receipt',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Row(
                children: [
                  Switch(
                      value: isChangeAllowed,
                      onChanged: (bool value) {
                        setState(() {
                          isChangeAllowed = value;
                        });
                      }),
                  Text(
                    'Change allowed',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Row(
                children: [
                  Switch(
                      value: isPaid,
                      onChanged: (bool value) {
                        setState(() {
                          isPaid = value;
                        });
                      }),
                  Text(
                    'Mark transaction as paid',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Row(
                children: [
                  Switch(
                      value: isOpenCashDrawer,
                      onChanged: (bool value) {
                        setState(() {
                          isOpenCashDrawer = value;
                        });
                      }),
                  Text(
                    'Open cash drawer',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      editDetails();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      'Save',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      cancel();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      'Cancel',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
