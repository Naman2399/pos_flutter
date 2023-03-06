import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:pos/database_models_functions/payment_type_functions.dart';
import 'package:pos/models/payment_type.dart';
import 'package:pos/screens/payment_type/delete_payment_type_dialog.dart';
import 'package:pos/screens/payment_type/edit_payment_type_bottom_sheet.dart';
import 'dart:developer' as developer;

import 'package:pos/screens/payment_type/new_payment_type_bottom_sheet.dart';

import '../../widgets/snackbar.dart';
import '../../widgets/text_decorations.dart';

class PaymentTypePage extends StatefulWidget {
  const PaymentTypePage({Key? key}) : super(key: key);

  @override
  State<PaymentTypePage> createState() => _PaymentTypePageState();
}

class _PaymentTypePageState extends State<PaymentTypePage> {
  PaymentTYpeFunctions paymentTYpeFunctions = PaymentTYpeFunctions();
  PaymentTypeSource paymentTypeSource =
      PaymentTypeSource(paymentTypes: [], count: 0);
  List<PaymentType> paymentTypes = [];
  List<PaymentType> originalPaymentTypes = [];
  List<PaymentType> selectedPaymentTypes = [];
  Set<String> suggestions = {};
  bool isAscending = true;
  int sortColumnIndex = 0;
  int selectedRowIndex = -1;
  String searchText = "";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    paymentTypes = (await paymentTYpeFunctions.getAllPaymentTypes());
    originalPaymentTypes = paymentTypes;
    paymentTypeSource = PaymentTypeSource(
        paymentTypes: paymentTypes, count: paymentTypes.length);
    for (PaymentType paymentType in paymentTypes) {
      suggestions.add(paymentType.name);
      suggestions.add(paymentType.code);
    }
    setState(() {});
  }

  onSortColumn(int columnIndex, bool ascending) {
    developer.log("Details for sort column");
    developer.log("Column index : $columnIndex");
    developer.log("Ascending : $ascending");
    // Column index = 0 : for Name
    if (columnIndex == 0) {
      if (ascending) {
        paymentTypes.sort((a, b) => a.name.compareTo(b.name));
      } else {
        paymentTypes.sort((a, b) => b.name.compareTo(a.name));
      }
    }

    // Column index = 1 : for Code
    if (columnIndex == 1) {
      if (ascending) {
        paymentTypes.sort((a, b) => a.code.compareTo(b.code));
      } else {
        paymentTypes.sort((a, b) => b.code.compareTo(a.code));
      }
    }
    paymentTypeSource = PaymentTypeSource(paymentTypes: paymentTypes, count: paymentTypes.length);
    setState(() {});
  }

  editPaymentType() {
    if (paymentTypeSource.selectedPaymentTypes.isEmpty) {
      displayMessage(
          context: context,
          title: 'Please select a tax rate',
          message:
              'For editing the pre-existing tax raw please select only one row and click on edit button',
          contentType: ContentType.help);
    } else if (paymentTypeSource.selectedPaymentTypes.length > 1) {
      displayMessage(
          context: context,
          title: 'Please select only 1 row for editing tax rate',
          message:
              'For editing the pre-existing tax raw please select only one row and click on edit button',
          contentType: ContentType.help);
    } else {
      developer.log('Editing tax rate');
      editPaymentTypeBottomSheet(
          context, paymentTypeSource.selectedPaymentTypes.first);
    }
  }

  delete() {
    if (paymentTypeSource.selectedPaymentTypes.isEmpty) {
      displayMessage(
          context: context,
          title: "No row selected",
          message: 'Please select atleast 1 row to perform delete operation',
          contentType: ContentType.help);
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return DeletePaymentTypeDialogBox(paymentTypes: paymentTypeSource.selectedPaymentTypes);
          });
      setState(() {});
    }
  }

  refresh() {
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          refresh();
                          setState(() {});
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
                  size: const Size(100, 80),
                  child: ClipRect(
                    child: Material(
                      color: Theme.of(context).dialogBackgroundColor,
                      child: InkWell(
                        splashColor: Theme.of(context).highlightColor,
                        onTap: () {
                          newPaymentTypeBottomSheet(context);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(Icons.add), // <-- Icon
                            Text(
                              "New payment",
                            ),
                            Text("type"),// <-- Text
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
                          editPaymentType();
                          setState(() {});
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
                          delete();
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
                    List<PaymentType> newPaymentTypes = originalPaymentTypes
                        .where((element) => element.name
                            .toLowerCase()
                            .contains(searchText.toLowerCase()))
                        .toList();
                    developer.log(newPaymentTypes.length.toString());
                    setState(() {
                      paymentTypes = newPaymentTypes;
                      paymentTypeSource = PaymentTypeSource(
                          paymentTypes: paymentTypes,
                          count: paymentTypes.length);
                    });
                  },
                  icon: const Icon(Icons.search),
                  iconSize: 30,
                ),
              ),
            ],
          ),
          // buildTable(taxRates: taxRates, context: context),
          paymentTypes.isNotEmpty
              ? PaginatedDataTable(
                  showCheckboxColumn: true,
                  sortAscending: isAscending,
                  sortColumnIndex: sortColumnIndex,
                  columns: <DataColumn>[
                    DataColumn(
                      label: const Text('Name'),
                      onSort: (columnIndex, ascending) {
                        sortColumnIndex = columnIndex;
                        isAscending = ascending;
                        onSortColumn(sortColumnIndex, isAscending);
                      },
                    ),
                    DataColumn(
                      label: const Text('Code'),
                      onSort: (columnIndex, ascending) {
                        sortColumnIndex = columnIndex;
                        isAscending = ascending;
                        onSortColumn(sortColumnIndex, isAscending);
                      },
                    ),
                    const DataColumn(
                      label: Text('Shortcut Key'),
                    ),
                    const DataColumn(
                      label: Text('Position'),
                    ),
                    const DataColumn(
                      label: Text('Enabled'),
                    ),
                    const DataColumn(
                      label: Text('Quick Payment'),
                    ),
                    const DataColumn(
                      label: Text('Customer Required'),
                    ),
                    const DataColumn(
                      label: Text('Print Receipt'),
                    ),
                    const DataColumn(
                      label: Text('Change Allowed'),
                    ),
                    const DataColumn(
                      label: Text('Mark transaction'),
                    ),
                    const DataColumn(
                      label: Text('Open Cash Drawer'),
                    ),
                  ],
                  source: paymentTypeSource,
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
                        backgroundColor:
                            Theme.of(context).colorScheme.background,
                        foregroundColor: Theme.of(context).hintColor,
                        icon: const Icon(
                          Icons.add,
                          size: 24.0,
                        ),
                        onPressed: () {
                          newPaymentTypeBottomSheet(context);
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

class PaymentTypeSource extends DataTableSource {
  List<PaymentType> paymentTypes;
  List<PaymentType> selectedPaymentTypes = [];
  int count;
  int rowsSelected = 0;

  PaymentTypeSource({
    required this.paymentTypes,
    required this.count,
  });

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      final PaymentType paymentType = paymentTypes[index];
      return DataRow.byIndex(
          index: index,
          selected: selectedPaymentTypes.contains(paymentType),
          onSelectChanged: (selected) {
            if (selected != null) {
              if (selected) {
                selectedPaymentTypes.add(paymentType);
                rowsSelected += 1;
              } else {
                selectedPaymentTypes.remove(paymentType);
                rowsSelected -= 1;
              }
            }
            developer.log("Row is clicked");
            developer.log(rowsSelected.toString());
            notifyListeners();
          },
          cells: [
            DataCell(Text(paymentTypes[index].name)),
            DataCell(Text(paymentTypes[index].code)),
            DataCell(Text(paymentTypes[index].shortcutKey)),
            DataCell(Text(paymentTypes[index].position.toString())),
            DataCell(Text(paymentTypes[index].enabled.toString())),
            DataCell(Text(paymentTypes[index].quickPayment.toString())),
            DataCell(Text(paymentTypes[index].customerRequired.toString())),
            DataCell(Text(paymentTypes[index].printReceipt.toString())),
            DataCell(Text(paymentTypes[index].changeAllowed.toString())),
            DataCell(Text(paymentTypes[index].markTransaction.toString())),
            DataCell(Text(paymentTypes[index].openCashDrawer.toString())),
          ]);
    } else {
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
