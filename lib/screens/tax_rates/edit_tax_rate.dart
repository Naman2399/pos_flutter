import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:pos/widgets/text_decorations.dart';
import '../../models/tax_rate.dart';
import '../../widgets/snackbar.dart';
import 'tax_rate_services.dart';
import 'dart:developer' as developer;


class EditTaxRate extends StatefulWidget {
  final TaxRate taxRate ;
  EditTaxRate({Key? key, required TaxRate this.taxRate}) : super (key: key) ;

  @override
  State<EditTaxRate> createState() => _EditTaxRateState(taxRate);
}

class _EditTaxRateState extends State<EditTaxRate> {

  TaxRate taxRate ;
  _EditTaxRateState(this.taxRate);

  bool isFixed = false;
  String rateSign = '%';
  static const IconData currencyRupeeOutlined =
  IconData(0xf05db, fontFamily: 'MaterialIcons');
  TextEditingController name = TextEditingController();
  TextEditingController code = TextEditingController();
  TextEditingController rate = TextEditingController();
  TaxRateServices taxRateServices = TaxRateServices();

  @override
  void initState() {
    super.initState();
    name.text = taxRate.taxName ;
    code.text = taxRate.taxCode ;
    rate.text = taxRate.taxRate.toString() ;
    if(taxRate.isFixedRate){
      isFixed = true ;
    }else{
      isFixed = false ;
    }
  }

  decrement() {
    try{
      double val = double.parse(rate.text) ;
      val = val - 1 ;
      setState(() {
        rate.text = val.toString() ;
      });

    }on Exception catch(error){
      developer.log("Error in rate text field need to be double or integer type");
      developer.log(error.toString());
      displayMessage(
          context: context,
          title: 'Error in Rate Field',
          message:
          'Rate field need to contain only numbers in integers or decimal format (e.g. 12, 16.8)',
          contentType: ContentType.failure);
    }
  }

  increment() {
    try{
      double val = double.parse(rate.text) ;
      val = val + 1 ;
      setState(() {
        rate.text = val.toString() ;
      });
    }on Exception catch(error){
      developer.log("Error in rate text field need to be double or integer type");
      developer.log(error.toString());
      displayMessage(
          context: context,
          title: 'Error in Rate Field',
          message:
          'Rate field need to contain only numbers in integers or decimal format (e.g. 12, 16.8)',
          contentType: ContentType.failure);
    }

  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Scaffold(
        appBar: AppBar(title: Text('Editing Tax Rate : ${taxRate.taxName}', style: Theme.of(context).textTheme.titleMedium,), ),
        body: ListView(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Edit tax rate',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Name',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: name,
                    decoration: inputDecorationCustom(context: context),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Code',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text('Code value will be in all capital mode', style: Theme.of(context).textTheme.bodySmall,),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: code,
                    decoration: inputDecorationCustom(context: context),
                    textCapitalization: TextCapitalization.characters,
                    onChanged: (value) {
                      code.value =
                          TextEditingValue(
                              text: value.toUpperCase(),
                              selection: code.selection);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Rate',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 10,
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
                          controller: rate,
                          decoration: inputDecorationCustom(context: context),
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
                      !isFixed
                          ? Text(
                        rateSign,
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                          : const Icon(
                        currencyRupeeOutlined,
                        size: 15,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Switch(
                          value: isFixed,
                          onChanged: (bool value) {
                            setState(() {
                              isFixed = value;
                            });
                          }),
                      Text(
                        'Fixed',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          taxRateServices.editDetails(context: context, oldTaxRate: taxRate,
                              taxName: name.text, taxCode: code.text, rate: rate.text, isFixed: isFixed);

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
                          taxRateServices.cancel() ;
                          Navigator.of(context).pop() ;
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
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ) ;
  }
}
