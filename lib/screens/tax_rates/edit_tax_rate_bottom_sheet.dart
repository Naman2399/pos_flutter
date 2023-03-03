import 'package:flutter/material.dart';
import 'package:pos/models/tax_rate.dart';
import 'package:pos/screens/tax_rates/edit_tax_rate.dart';

void editTaxRateBottomSheet(BuildContext context, TaxRate taxRate) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context, builder: (context) => EditTaxRate(taxRate: taxRate));
}
