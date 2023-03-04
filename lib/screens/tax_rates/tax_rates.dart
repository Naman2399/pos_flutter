import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:pos/database_models_functions/tax_rate_functions.dart';
import 'package:pos/screens/tax_rates/delete_tax_rate_dialog.dart';
import 'package:pos/screens/tax_rates/edit_tax_rate_bottom_sheet.dart';
import 'package:pos/screens/tax_rates/new_tax_rate_bottom_sheet.dart';
import 'package:pos/screens/tax_rates/switch_tax_rate_bottom_sheet.dart';
import 'package:pos/widgets/snackbar.dart';
import 'package:pos/widgets/text_decorations.dart';
import 'dart:developer' as developer;

import '../../models/tax_rate.dart';

class TaxRates extends StatefulWidget {
  const TaxRates({Key? key}) : super(key: key);

  @override
  State<TaxRates> createState() => _TaxRatesState();
}

class _TaxRatesState extends State<TaxRates> {
  TaxRateFunctions taxRateFunctions = TaxRateFunctions();
  TaxRateSource taxRateSource = TaxRateSource(taxRates: [], count: 0);
  List<TaxRate> taxRates = [];
  List<TaxRate> originalTaxRates = [];
  List<TaxRate> selectedTaxRates = [];
  Set<String> suggestions = {};
  bool isAscending = true;
  int sortColumnIndex = 0;
  int selectedRowIndex = -1;
  String searchText = "";

  @override
  void initState() {
    super.initState();
    doSomeAsyncStuff();
  }

  Future<void> doSomeAsyncStuff() async {
    taxRates = (await taxRateFunctions.getAllTaxRates())!;
    originalTaxRates = taxRates;
    taxRateSource = TaxRateSource(taxRates: taxRates, count: taxRates.length);
    for (TaxRate taxRate in taxRates) {
      suggestions.add(taxRate.taxName);
      suggestions.add(taxRate.taxCode);
    }
    setState(() {

    });
  }

  onSortColumn(int columnIndex, bool ascending) {
    // Column index = 0 : for Tax name
    if (columnIndex == 0) {
      if (ascending) {
        taxRates.sort((a, b) => a.taxName.compareTo(b.taxName));
      } else {
        taxRates.sort((a, b) => b.taxName.compareTo(a.taxName));
      }
    }

    // Column index = 1 : for Tax code
    if (columnIndex == 1) {
      if (ascending) {
        taxRates.sort((a, b) => a.taxCode.compareTo(b.taxCode));
      } else {
        taxRates.sort((a, b) => b.taxCode.compareTo(a.taxCode));
      }
    }

    // Column index = 2 : for Tax rate
    if (columnIndex == 2) {
      if (ascending) {
        taxRates.sort((a, b) => a.taxRate.compareTo(b.taxRate));
      } else {
        taxRates.sort((a, b) => b.taxRate.compareTo(a.taxRate));
      }
    }

    // Column index = 3 : is Fixed
    if (columnIndex == 3) {
      if (ascending) {
        taxRates.sort((a, b) =>
            a.isFixedRate.toString().compareTo(b.isFixedRate.toString()));
      } else {
        taxRates.sort(
            (a, b) => b.isFixedRate.toString().compareTo(a.taxName.toString()));
      }
    }
  }

  onEditTaxRate() {
    if (taxRateSource.selectedTaxRates.isEmpty) {
      displayMessage(
          context: context,
          title: 'Please select a tax rate',
          message:
              'For editing the pre-existing tax raw please select only one row and click on edit button',
          contentType: ContentType.help);
    } else if (taxRateSource.selectedTaxRates.length > 1) {
      displayMessage(
          context: context,
          title: 'Please select only 1 row for editing tax rate',
          message:
              'For editing the pre-existing tax raw please select only one row and click on edit button',
          contentType: ContentType.help);
    } else {
      developer.log('Editing tax rate');
      editTaxRateBottomSheet(context, taxRateSource.selectedTaxRates.first) ;

    }
  }

  refresh() {
    doSomeAsyncStuff() ;
  }

  delete() {
    if (taxRateSource.selectedTaxRates.isEmpty){
      displayMessage(context: context, title: "No row selected", message: 'Please select atleast 1 row to perform delete operation', contentType: ContentType.help);
    }
    else{
      showDialog(context: context, builder: (BuildContext context){
        return DeleteTaxRateDialogBox(taxRates: taxRateSource.selectedTaxRates,) ;
      });
      refresh() ;
      setState(() {

      });
    }
  }

  switchTaxRate(){
    switchTaxRateBottomSheet(context, suggestions.toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tax rates'),
      ),
      body: ListView(
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: Theme.of(context).highlightColor)),
                margin: const EdgeInsets.all(5),
                child: SizedBox.fromSize(
                  size: const Size(80, 80),
                  child: ClipRect(
                    child: Material(
                      color: Theme.of(context).dialogBackgroundColor,
                      child: InkWell(
                        splashColor: Theme.of(context).highlightColor,
                        onTap: () {
                          refresh() ;
                          setState(() {

                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.refresh), // <-- Icon
                            Text("Refresh"), // <-- Text
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: Theme.of(context).highlightColor)),
                margin: const EdgeInsets.all(5),
                child: SizedBox.fromSize(
                  size: const Size(80, 80),
                  child: ClipRect(
                    child: Material(
                      color: Theme.of(context).dialogBackgroundColor,
                      child: InkWell(
                        splashColor: Theme.of(context).highlightColor,
                        onTap: () {
                          newTaxRateBottomSheet(context);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.add), // <-- Icon
                            Text(
                              "New tax rate",
                            ), // <-- Text
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: Theme.of(context).highlightColor)),
                margin: const EdgeInsets.all(5),
                child: SizedBox.fromSize(
                  size: const Size(80, 80),
                  child: ClipRect(
                    child: Material(
                      color: Theme.of(context).dialogBackgroundColor,
                      child: InkWell(
                        splashColor: Theme.of(context).highlightColor,
                        onTap: () {
                          onEditTaxRate();
                          refresh() ;
                          setState(() {

                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.edit), // <-- Icon
                            Text("Edit"), // <-- Text
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: Theme.of(context).highlightColor)),
                margin: const EdgeInsets.all(5),
                child: SizedBox.fromSize(
                  size: const Size(80, 80),
                  child: ClipRect(
                    child: Material(
                      color: Theme.of(context).dialogBackgroundColor,
                      child: InkWell(
                        splashColor: Theme.of(context).highlightColor,
                        onTap: () {
                          delete() ;
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.delete), // <-- Icon
                            Text("Delete"), // <-- Text
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: Theme.of(context).highlightColor)),
                margin: const EdgeInsets.all(5),
                child: SizedBox.fromSize(
                  size: const Size(80, 80),
                  child: ClipRect(
                    child: Material(
                      color: Theme.of(context).dialogBackgroundColor,
                      child: InkWell(
                        splashColor: Theme.of(context).highlightColor,
                        onTap: () {
                          switchTaxRate() ;
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.swap_horiz), // <-- Icon
                            Text("Switch Taxes"), // <-- Text
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: Theme.of(context).highlightColor)),
                margin: const EdgeInsets.all(5),
                child: SizedBox.fromSize(
                  size: const Size(80, 80),
                  child: ClipRect(
                    child: Material(
                      color: Theme.of(context).dialogBackgroundColor,
                      child: InkWell(
                        splashColor: Theme.of(context).highlightColor,
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.help_outline), // <-- Icon
                            Text("Help"), // <-- Text
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: Autocomplete(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    setState(() {
                      searchText = textEditingValue.text;
                    });
                    if (textEditingValue.text == '') {
                      return const Iterable<String>.empty();
                    } else {
                      List<String> matches = <String>[];
                      matches.addAll(suggestions.toList());
                      matches.retainWhere((taxName) {
                        return taxName
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase());
                      });
                      return matches;
                    }
                  },
                  fieldViewBuilder: (BuildContext context,
                      TextEditingController fieldTextEditingController,
                      FocusNode fieldFocusNode,
                      VoidCallback onFieldSubmitted) {
                    return TextField(
                      autofocus: true,
                      controller: fieldTextEditingController,
                      focusNode: fieldFocusNode,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      decoration: inputDecorationCustom(context: context),
                    );
                  },
                  onSelected: (String selection) {},
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 20),
                child: IconButton(
                  onPressed: () {
                    developer.log("Search Field content : $searchText}");
                    List<TaxRate> newTaxRates = originalTaxRates
                        .where((element) => element.taxName
                        .toLowerCase()
                        .contains(searchText.toLowerCase()))
                        .toList();
                    developer.log(newTaxRates.length.toString());
                    setState(() {
                      taxRates = newTaxRates;
                      taxRateSource = TaxRateSource(
                          taxRates: taxRates, count: taxRates.length);
                    });
                  },
                  icon: const Icon(Icons.search),
                  iconSize: 30,
                ),
              ),
            ],
          ),
          // buildTable(taxRates: taxRates, context: context),
          taxRates.isNotEmpty
              ? PaginatedDataTable(
            showCheckboxColumn: true,
            sortAscending: isAscending,
            sortColumnIndex: sortColumnIndex,
            columns: <DataColumn>[
              DataColumn(
                label: const Text('Tax name'),
                onSort: (columnIndex, ascending) {
                  setState(() {
                    sortColumnIndex = columnIndex;
                    isAscending = ascending;
                  });
                  onSortColumn(sortColumnIndex, isAscending);
                },
              ),
              DataColumn(
                label: const Text('Tax code'),
                onSort: (columnIndex, ascending) {
                  setState(() {
                    sortColumnIndex = columnIndex;
                    isAscending = ascending;
                  });
                  onSortColumn(sortColumnIndex, isAscending);
                },
              ),
              DataColumn(
                label: const Text('Tax rate'),
                onSort: (columnIndex, ascending) {
                  setState(() {
                    sortColumnIndex = columnIndex;
                    isAscending = ascending;
                  });
                  onSortColumn(sortColumnIndex, isAscending);
                },
              ),
              DataColumn(
                label: const Text('Is Fixed'),
                onSort: (columnIndex, ascending) {
                  setState(() {
                    sortColumnIndex = columnIndex;
                    isAscending = ascending;
                  });
                  onSortColumn(sortColumnIndex, isAscending);
                },
              ),
            ],
            source: taxRateSource,
            rowsPerPage: 8,
            columnSpacing: 8,
          )
              : Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(5),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.remove_red_eye_outlined,
                  size: 50,
                ),
                Text(
                  'No taxes',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                FloatingActionButton.extended(
                  label: Text(
                    'Add new taxes',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.background,
                  foregroundColor: Theme.of(context).hintColor,
                  icon: const Icon(
                    Icons.add,
                    size: 24.0,
                  ),
                  onPressed: () {
                    newTaxRateBottomSheet(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TaxRateSource extends DataTableSource {
  List<TaxRate> taxRates;
  List<TaxRate> selectedTaxRates = [];
  int count;
  int rowsSelected = 0;

  TaxRateSource({
    required this.taxRates,
    required this.count,
  });

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      final TaxRate taxRate = taxRates[index];
      return DataRow.byIndex(
          index: index,
          selected: selectedTaxRates.contains(taxRate),
          onSelectChanged: (selected) {
            if (selected != null) {
              if (selected) {
                selectedTaxRates.add(taxRate);
                rowsSelected += 1;
              } else {
                selectedTaxRates.remove(taxRate);
                rowsSelected -= 1;
              }
            }
            developer.log("Row is clicked");
            developer.log(rowsSelected.toString());
            notifyListeners();
          },
          cells: [
            DataCell(Text(taxRates[index].taxName)),
            DataCell(Text(taxRates[index].taxCode)),
            DataCell(Text(taxRates[index].taxRate.toString())),
            DataCell(Text(taxRates[index].isFixedRate.toString())),
          ]);
    } else{
      return null;
    }
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => rowsSelected;
}



// Extra widget is there for DataTableRow logics
// Widget trialAndTested(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: const Text('Tax rates'),
//     ),
//     body: Column(
//       children: [
//         Row(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                   border: Border.all(
//                       width: 1, color: Theme.of(context).highlightColor)),
//               margin: const EdgeInsets.all(5),
//               child: SizedBox.fromSize(
//                 size: const Size(80, 80),
//                 child: ClipRect(
//                   child: Material(
//                     color: Theme.of(context).dialogBackgroundColor,
//                     child: InkWell(
//                       splashColor: Theme.of(context).highlightColor,
//                       onTap: () {},
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: const [
//                           Icon(Icons.refresh), // <-- Icon
//                           Text("Refresh"), // <-- Text
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               decoration: BoxDecoration(
//                   border: Border.all(
//                       width: 1, color: Theme.of(context).highlightColor)),
//               margin: const EdgeInsets.all(5),
//               child: SizedBox.fromSize(
//                 size: const Size(80, 80),
//                 child: ClipRect(
//                   child: Material(
//                     color: Theme.of(context).dialogBackgroundColor,
//                     child: InkWell(
//                       splashColor: Theme.of(context).highlightColor,
//                       onTap: () {
//                         NewTaxRateBottomSheet(context);
//                       },
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: const [
//                           Icon(Icons.add), // <-- Icon
//                           Text(
//                             "New tax rate",
//                           ), // <-- Text
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               decoration: BoxDecoration(
//                   border: Border.all(
//                       width: 1, color: Theme.of(context).highlightColor)),
//               margin: const EdgeInsets.all(5),
//               child: SizedBox.fromSize(
//                 size: const Size(80, 80),
//                 child: ClipRect(
//                   child: Material(
//                     color: Theme.of(context).dialogBackgroundColor,
//                     child: InkWell(
//                       splashColor: Theme.of(context).highlightColor,
//                       onTap: () {
//                         onEditTaxRate() ;
//                       },
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: const [
//                           Icon(Icons.edit), // <-- Icon
//                           Text("Edit"), // <-- Text
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               decoration: BoxDecoration(
//                   border: Border.all(
//                       width: 1, color: Theme.of(context).highlightColor)),
//               margin: const EdgeInsets.all(5),
//               child: SizedBox.fromSize(
//                 size: const Size(80, 80),
//                 child: ClipRect(
//                   child: Material(
//                     color: Theme.of(context).dialogBackgroundColor,
//                     child: InkWell(
//                       splashColor: Theme.of(context).highlightColor,
//                       onTap: () {},
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: const [
//                           Icon(Icons.delete), // <-- Icon
//                           Text("Delete"), // <-- Text
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               decoration: BoxDecoration(
//                   border: Border.all(
//                       width: 1, color: Theme.of(context).highlightColor)),
//               margin: const EdgeInsets.all(5),
//               child: SizedBox.fromSize(
//                 size: const Size(80, 80),
//                 child: ClipRect(
//                   child: Material(
//                     color: Theme.of(context).dialogBackgroundColor,
//                     child: InkWell(
//                       splashColor: Theme.of(context).highlightColor,
//                       onTap: () {},
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: const [
//                           Icon(Icons.swap_horiz), // <-- Icon
//                           Text("Switch Taxes"), // <-- Text
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               decoration: BoxDecoration(
//                   border: Border.all(
//                       width: 1, color: Theme.of(context).highlightColor)),
//               margin: const EdgeInsets.all(5),
//               child: SizedBox.fromSize(
//                 size: const Size(80, 80),
//                 child: ClipRect(
//                   child: Material(
//                     color: Theme.of(context).dialogBackgroundColor,
//                     child: InkWell(
//                       splashColor: Theme.of(context).highlightColor,
//                       onTap: () {},
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: const [
//                           Icon(Icons.help_outline), // <-- Icon
//                           Text("Help"), // <-- Text
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         // buildTable(taxRates: taxRates, context: context),
//         taxRates.isNotEmpty
//             ? DataTable(
//           showCheckboxColumn: true,
//           sortAscending: isAscending,
//           sortColumnIndex: sortColumnIndex,
//           columns: <DataColumn>[
//             DataColumn(
//               label: Text('Tax name'),
//               onSort: (columnIndex, ascending) {
//                 setState(() {
//                   sortColumnIndex = columnIndex ;
//                   isAscending = ascending ;
//                 });
//                 onSortColumn(sortColumnIndex, isAscending);
//
//               },
//             ),
//             DataColumn(
//               label: Text('Tax code'),
//               onSort: (columnIndex, ascending) {
//                 setState(() {
//                   sortColumnIndex = columnIndex ;
//                   isAscending = ascending ;
//                 });
//                 onSortColumn(sortColumnIndex, isAscending);
//               },
//             ),
//             DataColumn(
//               label: Text('Tax rate'),
//               onSort: (columnIndex, ascending) {
//                 setState(() {
//                   sortColumnIndex = columnIndex ;
//                   isAscending = ascending ;
//                 });
//                 onSortColumn(sortColumnIndex, isAscending);
//               },
//             ),
//             DataColumn(
//               label: Text('Is Fixed'),
//               onSort: (columnIndex, ascending) {
//                 setState(() {
//                   sortColumnIndex = columnIndex ;
//                   isAscending = ascending ;
//                 });
//                 onSortColumn(sortColumnIndex, isAscending);
//               },
//             ),
//           ],
//           rows: taxRates
//               .map(
//             ((taxRate) => DataRow(
//                 selected: selectedTaxRates.contains(taxRate),
//                 cells: <DataCell>[
//                   DataCell(Text(taxRate.taxName)),
//                   DataCell(Text(taxRate.taxCode)),
//                   DataCell(Text(taxRate.taxRate.toString())),
//                   DataCell(Text(taxRate.isFixedRate.toString())),
//                 ],
//                 onSelectChanged: (val) {
//                   if (val == null){
//                     onSelectedRow(false, taxRate);
//                   }else{
//                     onSelectedRow(val, taxRate) ;
//                   }
//                 }
//             )),
//           )
//               .toList(),
//         )
//             : Expanded(
//           child: Container(
//             margin: EdgeInsets.all(5),
//             padding: EdgeInsets.all(5),
//             alignment: Alignment.center,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.remove_red_eye_outlined,
//                   size: 50,
//                 ),
//                 Text(
//                   'No taxes',
//                   style: Theme.of(context).textTheme.titleMedium,
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 FloatingActionButton.extended(
//                   label: Text(
//                     'Add new taxes',
//                     style: Theme.of(context).textTheme.bodyMedium,
//                   ),
//                   backgroundColor: Theme.of(context).backgroundColor,
//                   foregroundColor: Theme.of(context).hintColor,
//                   icon: const Icon(
//                     Icons.add,
//                     size: 24.0,
//                   ),
//                   onPressed: () {
//                     NewTaxRateBottomSheet(context);
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }
