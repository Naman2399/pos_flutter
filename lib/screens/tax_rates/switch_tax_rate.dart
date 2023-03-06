import 'package:flutter/material.dart';

class SwitchTaxRate extends StatefulWidget {

  List<String> taxNames ;
  SwitchTaxRate({Key? key, required this.taxNames}) : super(key: key);

  @override
  State<SwitchTaxRate> createState() => _SwitchTaxRateState();
}

class _SwitchTaxRateState extends State<SwitchTaxRate> {
  String oldTaxRate = "" ;
  String newTaxRate = "" ;

  _SwitchTaxRateState();

  @override
  void initState() {
    super.initState();
    widget.taxNames.add("");
  }

  // TODO : Need to implement the button functionality "Replace Button"

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Switch Taxes',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        body: Container(
          margin: const EdgeInsets.all(10),
          child : Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.blueAccent,
                    child: Icon(
                      Icons.info_outline,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Use this form to replace taxes for all products',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        'Select old tax you which to replace with new tax and click "Replace" button below.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text('Old Tax' , style: Theme.of(context).textTheme.bodyMedium,),
                      const SizedBox(height: 10,),
                      DropdownButton<String>(
                        value: oldTaxRate,
                        items: widget.taxNames
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue){
                          setState(() {
                            oldTaxRate = newValue! ;
                          });
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.forward_rounded,
                        color: Theme.of(context).primaryColorLight,
                        size: 30,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text('New Tax' , style: Theme.of(context).textTheme.bodyMedium,),
                      const SizedBox(height: 10,),
                      DropdownButton<String>(
                        value: newTaxRate,
                        items: widget.taxNames
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue){
                          setState(() {
                            newTaxRate = newValue! ;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      'Replace',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
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
                  const SizedBox(width: 20,),
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
