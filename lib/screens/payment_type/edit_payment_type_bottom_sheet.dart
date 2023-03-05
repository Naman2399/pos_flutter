import 'package:flutter/material.dart';
import 'package:pos/models/payment_type.dart';
import 'package:pos/screens/payment_type/edit_payment_type.dart';

void editPaymentTypeBottomSheet(BuildContext context, PaymentType paymentType) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => EditPaymentType(paymentType: paymentType));
}
