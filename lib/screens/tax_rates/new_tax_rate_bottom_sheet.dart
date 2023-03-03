import 'package:flutter/material.dart';
import 'package:pos/screens/tax_rates/new_tax_rate.dart';

void newTaxRateBottomSheet(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
      context: context, builder: (context) => const NewTaxRate());
}
