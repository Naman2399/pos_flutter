import 'package:flutter/material.dart';
import 'package:pos/screens/payment_type/new_payment_type.dart';

void newPaymentTypeBottomSheet(BuildContext context) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => const NewPaymentType());
}
