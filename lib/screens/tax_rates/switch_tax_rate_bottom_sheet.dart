import 'package:flutter/material.dart';
import 'package:pos/screens/tax_rates/switch_tax_rate.dart';

void switchTaxRateBottomSheet(BuildContext context, List<String> taxNames) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context, builder: (context) => SwitchTaxRate(taxNames: taxNames));
}
