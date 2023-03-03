import 'package:flutter/material.dart';
import 'package:pos/database_models_functions/tax_rate_functions.dart';
import 'dart:developer' as developer;


import '../../models/tax_rate.dart';

class DeleteTaxRateDialogBox extends StatefulWidget {
  List<TaxRate> taxRates ;
  DeleteTaxRateDialogBox({Key? key, required this.taxRates}) : super(key: key);

  @override
  State<DeleteTaxRateDialogBox> createState() => _DeleteTaxRateDialogBoxState(taxRates);
}

class _DeleteTaxRateDialogBoxState extends State<DeleteTaxRateDialogBox> {
  List<TaxRate> taxRates ;
  _DeleteTaxRateDialogBoxState(this.taxRates);
  String delete = "" ;
  TaxRateFunctions taxRateFunctions = TaxRateFunctions() ;

  @override
  void initState() {
    super.initState();
    for(TaxRate taxRate in taxRates){
      delete = "$delete${taxRate.taxName} , " ;
    }
    delete = delete.substring(0, delete.length - 2);
    developer.log("All the deleted tax rates  names : $delete");
  }

  deleteTaxRate() {
    for(TaxRate taxRate in taxRates){
      taxRateFunctions.deleteTaxRate(taxRate: taxRate);
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
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Text('Delete Tax Rates', style: Theme.of(context).textTheme.titleLarge,),
            const SizedBox(height: 30,),
            Text('Please confirm to delete following tax rates !!' , style: Theme.of(context).textTheme.titleMedium,),
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
    );
  }
}
