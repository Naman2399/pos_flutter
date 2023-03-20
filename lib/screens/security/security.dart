import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../database_models_functions/security_functions.dart';
import '../../models/security.dart';
import '../../widgets/text_decorations.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({Key? key}) : super(key: key);

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  late List<Security> securitiesGeneral;
  late List<Security> securitiesSales ; 
  late List<Security> securitiesManagement ; 
  late List<Security> securitiesStock ; 
  // General
  TextEditingController management = TextEditingController();
  TextEditingController settings = TextEditingController();
  TextEditingController endOfDay = TextEditingController();
  TextEditingController userProfile = TextEditingController();
  TextEditingController designFloorPlans = TextEditingController();
  // Sales
  TextEditingController viewAllOpenDrawers = TextEditingController();
  TextEditingController voidOrder = TextEditingController();
  TextEditingController voidItem = TextEditingController();
  TextEditingController lockSale = TextEditingController();
  TextEditingController unlockSale = TextEditingController();
  TextEditingController splitOrder = TextEditingController();
  TextEditingController applyDiscount = TextEditingController();
  TextEditingController deleteDiscount = TextEditingController();
  TextEditingController refund = TextEditingController();
  TextEditingController viewSaleHistory = TextEditingController();
  TextEditingController reprintReceipt = TextEditingController();
  TextEditingController startingCash = TextEditingController();
  TextEditingController openCashDrawer = TextEditingController();
  TextEditingController zeroStockQuantitySale = TextEditingController();
  // Management
  TextEditingController dashboard = TextEditingController();
  TextEditingController documents = TextEditingController();
  TextEditingController products = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController reporting = TextEditingController();
  TextEditingController customersAndSuppliers = TextEditingController();
  TextEditingController promotionsAndActions = TextEditingController();
  TextEditingController usersAndSecurity = TextEditingController();
  TextEditingController paymentTypes = TextEditingController();
  TextEditingController countries = TextEditingController();
  TextEditingController taxRates = TextEditingController();
  TextEditingController myCompany = TextEditingController();
  // Stock
  TextEditingController quickInventory = TextEditingController();
  TextEditingController viewCostPrice = TextEditingController();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future<void> loadData() async {
    SecurityFunctions securityFunctions = SecurityFunctions();
    securitiesGeneral = await securityFunctions.getSecurityDetails(section: 'general');
    securitiesSales = await securityFunctions.getSecurityDetails(section: 'sales');
    securitiesManagement = await securityFunctions.getSecurityDetails(section: 'management');
    securitiesStock = await securityFunctions.getSecurityDetails(section: 'stock');
    setState(() {
      // General values
      management.text = securitiesGeneral.firstWhere((element) => element.keyField.startsWith('management')).accessLevel.toString();
      settings.text = securitiesGeneral.firstWhere((element) => element.keyField.startsWith('settings')).accessLevel.toString();
      endOfDay.text = securitiesGeneral.firstWhere((element) => element.keyField.startsWith('end_of_day')).accessLevel.toString();
      userProfile.text = securitiesGeneral.firstWhere((element) => element.keyField.startsWith('user_profile')).accessLevel.toString();
      designFloorPlans.text = securitiesGeneral.firstWhere((element) => element.keyField.startsWith('design_floor_plans')).accessLevel.toString();
      // Sales values
      viewAllOpenDrawers.text = securitiesSales.firstWhere((element) => element.keyField.startsWith('view_all_open_drawer')).accessLevel.toString();
      voidOrder.text = securitiesSales.firstWhere((element) => element.keyField.startsWith('void_order')).accessLevel.toString();
      voidItem.text = securitiesSales.firstWhere((element) => element.keyField.startsWith('void_item')).accessLevel.toString();
      lockSale.text = securitiesSales.firstWhere((element) => element.keyField.startsWith('lock_sale')).accessLevel.toString();
      unlockSale.text = securitiesSales.firstWhere((element) => element.keyField.startsWith('unlock_sale')).accessLevel.toString();
      splitOrder.text = securitiesSales.firstWhere((element) => element.keyField.startsWith('split_order')).accessLevel.toString();
      applyDiscount.text = securitiesSales.firstWhere((element) => element.keyField.startsWith('apply_discount')).accessLevel.toString();
      deleteDiscount.text = securitiesSales.firstWhere((element) => element.keyField.startsWith('delete_document')).accessLevel.toString();
      refund.text = securitiesSales.firstWhere((element) => element.keyField.startsWith('refund')).accessLevel.toString();
      viewSaleHistory.text = securitiesSales.firstWhere((element) => element.keyField.startsWith('view_sales_history')).accessLevel.toString();
      reprintReceipt.text = securitiesSales.firstWhere((element) => element.keyField.startsWith('reprint_receipt')).accessLevel.toString();
      startingCash.text = securitiesSales.firstWhere((element) => element.keyField.startsWith('starting_cash')).accessLevel.toString();
      openCashDrawer.text = securitiesSales.firstWhere((element) => element.keyField.startsWith('open_cash_drawer')).accessLevel.toString();
      zeroStockQuantitySale.text = securitiesSales.firstWhere((element) => element.keyField.startsWith('zero_stock_quantity_sale')).accessLevel.toString();
      // Management Values
      dashboard.text =  securitiesManagement.firstWhere((element) => element.keyField.startsWith('dashboard')).accessLevel.toString();
      documents.text = securitiesManagement.firstWhere((element) => element.keyField.startsWith('documents')).accessLevel.toString();
      products.text = securitiesManagement.firstWhere((element) => element.keyField.startsWith('products')).accessLevel.toString();
      stock.text = securitiesManagement.firstWhere((element) => element.keyField.startsWith('stock')).accessLevel.toString();
      reporting.text = securitiesManagement.firstWhere((element) => element.keyField.startsWith('reporting')).accessLevel.toString();
      customersAndSuppliers.text = securitiesManagement.firstWhere((element) => element.keyField.startsWith('customers_suppliers')).accessLevel.toString();
      promotionsAndActions.text = securitiesManagement.firstWhere((element) => element.keyField.startsWith('promotions_actions')).accessLevel.toString();
      usersAndSecurity.text = securitiesManagement.firstWhere((element) => element.keyField.startsWith('users_security')).accessLevel.toString();
      paymentTypes.text = securitiesManagement.firstWhere((element) => element.keyField.startsWith('payment_types')).accessLevel.toString();
      countries.text = securitiesManagement.firstWhere((element) => element.keyField.startsWith('countries')).accessLevel.toString();
      taxRates.text = securitiesManagement.firstWhere((element) => element.keyField.startsWith('tax_rates')).accessLevel.toString();
      myCompany.text = securitiesManagement.firstWhere((element) => element.keyField.startsWith('my_company')).accessLevel.toString();
      // Stock Values
      quickInventory.text = securitiesStock.firstWhere((element) => element.keyField.startsWith('quick_inventory')).accessLevel.toString();
      viewCostPrice.text = securitiesStock.firstWhere((element) => element.keyField.startsWith('view_cost_price')).accessLevel.toString();
    });
  }

  refresh() {
    setState(() {
      // General values
      management.text = securitiesGeneral.firstWhere((element) => element.keyField.startsWith('management')).accessLevel.toString();
      settings.text = securitiesGeneral.firstWhere((element) => element.keyField.startsWith('settings')).accessLevel.toString();
      endOfDay.text = securitiesGeneral.firstWhere((element) => element.keyField.startsWith('end_of_day')).accessLevel.toString();
      userProfile.text = securitiesGeneral.firstWhere((element) => element.keyField.startsWith('user_profile')).accessLevel.toString();
      designFloorPlans.text = securitiesGeneral.firstWhere((element) => element.keyField.startsWith('design_floor_plans')).accessLevel.toString();
      // Sales values
      viewAllOpenDrawers.text = securitiesSales.firstWhere((element) => element.keyField.startsWith('view_all_open_drawer')).accessLevel.toString();
      voidOrder.text = securitiesSales.firstWhere((element) => element.keyField.startsWith('void_order')).accessLevel.toString();
      voidItem.text = securitiesSales.firstWhere((element) => element.keyField.startsWith('void_item')).accessLevel.toString();
      lockSale.text = securitiesSales.firstWhere((element) => element.keyField.startsWith('lock_sale')).accessLevel.toString();
      unlockSale.text = securitiesSales.firstWhere((element) => element.keyField.startsWith('unlock_sale')).accessLevel.toString();
      splitOrder.text = securitiesSales.firstWhere((element) => element.keyField.startsWith('split_order')).accessLevel.toString();
      applyDiscount.text = securitiesSales.firstWhere((element) => element.keyField.startsWith('apply_discount')).accessLevel.toString();
      deleteDiscount.text = securitiesSales.firstWhere((element) => element.keyField.startsWith('delete_document')).accessLevel.toString();
      refund.text = securitiesSales.firstWhere((element) => element.keyField.startsWith('refund')).accessLevel.toString();
      viewSaleHistory.text = securitiesSales.firstWhere((element) => element.keyField.startsWith('view_sales_history')).accessLevel.toString();
      reprintReceipt.text = securitiesSales.firstWhere((element) => element.keyField.startsWith('reprint_receipt')).accessLevel.toString();
      startingCash.text = securitiesSales.firstWhere((element) => element.keyField.startsWith('starting_cash')).accessLevel.toString();
      openCashDrawer.text = securitiesSales.firstWhere((element) => element.keyField.startsWith('open_cash_drawer')).accessLevel.toString();
      zeroStockQuantitySale.text = securitiesSales.firstWhere((element) => element.keyField.startsWith('zero_stock_quantity_sale')).accessLevel.toString();
      // Management Values
      dashboard.text =  securitiesManagement.firstWhere((element) => element.keyField.startsWith('dashboard')).accessLevel.toString();
      documents.text = securitiesManagement.firstWhere((element) => element.keyField.startsWith('documents')).accessLevel.toString();
      products.text = securitiesManagement.firstWhere((element) => element.keyField.startsWith('products')).accessLevel.toString();
      stock.text = securitiesManagement.firstWhere((element) => element.keyField.startsWith('stock')).accessLevel.toString();
      reporting.text = securitiesManagement.firstWhere((element) => element.keyField.startsWith('reporting')).accessLevel.toString();
      customersAndSuppliers.text = securitiesManagement.firstWhere((element) => element.keyField.startsWith('customers_suppliers')).accessLevel.toString();
      promotionsAndActions.text = securitiesManagement.firstWhere((element) => element.keyField.startsWith('promotions_actions')).accessLevel.toString();
      usersAndSecurity.text = securitiesManagement.firstWhere((element) => element.keyField.startsWith('users_security')).accessLevel.toString();
      paymentTypes.text = securitiesManagement.firstWhere((element) => element.keyField.startsWith('payment_types')).accessLevel.toString();
      countries.text = securitiesManagement.firstWhere((element) => element.keyField.startsWith('countries')).accessLevel.toString();
      taxRates.text = securitiesManagement.firstWhere((element) => element.keyField.startsWith('tax_rates')).accessLevel.toString();
      myCompany.text = securitiesManagement.firstWhere((element) => element.keyField.startsWith('my_company')).accessLevel.toString();
      // Stock Values
      quickInventory.text = securitiesStock.firstWhere((element) => element.keyField.startsWith('quick_inventory')).accessLevel.toString();
      viewCostPrice.text = securitiesStock.firstWhere((element) => element.keyField.startsWith('view_cost_price')).accessLevel.toString();
    });
  }

  save() async {
    SecurityFunctions securityFunctions = SecurityFunctions();
    // General values

    // Updating Management
    Security security =  securitiesGeneral.firstWhere((element) => element.keyField.startsWith('management')) ;
    security.accessLevel = int.parse(management.text)  ;
    await securityFunctions.updateDetails(security: security);
    // Updating Settings
    security = securitiesGeneral.firstWhere((element) => element.keyField.startsWith('settings'));
    security.accessLevel = int.parse(settings.text) ;
    await securityFunctions.updateDetails(security: security);
    // Updating End of Day
    security = securitiesGeneral.firstWhere((element) => element.keyField.startsWith('end_of_day'));
    security.accessLevel = int.parse(endOfDay.text) ;
    await securityFunctions.updateDetails(security: security);
    // Updating User Profile
    security = securitiesGeneral.firstWhere((element) => element.keyField.startsWith('user_profile'));
    security.accessLevel = int.parse(userProfile.text) ;
    await securityFunctions.updateDetails(security: security);
    // Updating Design Floor Plans
    security = securitiesGeneral.firstWhere((element) => element.keyField.startsWith('design_floor_plans'));
    security.accessLevel = int.parse(designFloorPlans.text) ;
    await securityFunctions.updateDetails(security: security);

    // Sales values
    security = securitiesSales.firstWhere((element) => element.keyField.startsWith('view_all_open_drawer'));
    security.accessLevel = int.parse(viewAllOpenDrawers.text) ;
    await securityFunctions.updateDetails(security: security);

    security = securitiesSales.firstWhere((element) => element.keyField.startsWith('void_order'));
    security.accessLevel = int.parse(voidOrder.text) ;
    await securityFunctions.updateDetails(security: security);

    security = securitiesSales.firstWhere((element) => element.keyField.startsWith('void_item'));
    security.accessLevel = int.parse(voidItem.text) ;
    await securityFunctions.updateDetails(security: security);

    security = securitiesSales.firstWhere((element) => element.keyField.startsWith('lock_sale'));
    security.accessLevel = int.parse(lockSale.text) ;
    await securityFunctions.updateDetails(security: security);

    security = securitiesSales.firstWhere((element) => element.keyField.startsWith('unlock_sale'));
    security.accessLevel = int.parse(unlockSale.text) ;
    await securityFunctions.updateDetails(security: security);

    security = securitiesSales.firstWhere((element) => element.keyField.startsWith('split_order'));
    security.accessLevel = int.parse(splitOrder.text) ;
    await securityFunctions.updateDetails(security: security);

    security = securitiesSales.firstWhere((element) => element.keyField.startsWith('apply_discount'));
    security.accessLevel = int.parse(applyDiscount.text) ;
    await securityFunctions.updateDetails(security: security);

    security = securitiesSales.firstWhere((element) => element.keyField.startsWith('delete_document'));
    security.accessLevel = int.parse(deleteDiscount.text) ;
    await securityFunctions.updateDetails(security: security);

    security = securitiesSales.firstWhere((element) => element.keyField.startsWith('refund'));
    security.accessLevel = int.parse(refund.text) ;
    await securityFunctions.updateDetails(security: security);

    security = securitiesSales.firstWhere((element) => element.keyField.startsWith('view_sales_history'));
    security.accessLevel = int.parse(viewSaleHistory.text) ;
    await securityFunctions.updateDetails(security: security);

    security = securitiesSales.firstWhere((element) => element.keyField.startsWith('reprint_receipt'));
    security.accessLevel = int.parse(reprintReceipt.text) ;
    await securityFunctions.updateDetails(security: security);

    security = securitiesSales.firstWhere((element) => element.keyField.startsWith('starting_cash'));
    security.accessLevel = int.parse(startingCash.text) ;
    await securityFunctions.updateDetails(security: security);

    security = securitiesSales.firstWhere((element) => element.keyField.startsWith('open_cash_drawer'));
    security.accessLevel = int.parse(openCashDrawer.text) ;
    await securityFunctions.updateDetails(security: security);

    security = securitiesSales.firstWhere((element) => element.keyField.startsWith('zero_stock_quantity_sale'));
    security.accessLevel = int.parse(zeroStockQuantitySale.text) ;
    await securityFunctions.updateDetails(security: security);

    // Management Values
    security = securitiesManagement.firstWhere((element) => element.keyField.startsWith('dashboard'));
    security.accessLevel = int.parse(dashboard.text) ;
    await securityFunctions.updateDetails(security: security);

    security = securitiesManagement.firstWhere((element) => element.keyField.startsWith('documents'));
    security.accessLevel = int.parse(documents.text) ;
    await securityFunctions.updateDetails(security: security);

    security = securitiesManagement.firstWhere((element) => element.keyField.startsWith('products'));
    security.accessLevel = int.parse(products.text) ;
    await securityFunctions.updateDetails(security: security);

    security = securitiesManagement.firstWhere((element) => element.keyField.startsWith('stock'));
    security.accessLevel = int.parse(stock.text) ;
    await securityFunctions.updateDetails(security: security);

    security = securitiesManagement.firstWhere((element) => element.keyField.startsWith('reporting'));
    security.accessLevel = int.parse(reporting.text) ;
    await securityFunctions.updateDetails(security: security);

    security = securitiesManagement.firstWhere((element) => element.keyField.startsWith('customers_suppliers'));
    security.accessLevel = int.parse(customersAndSuppliers.text) ;
    await securityFunctions.updateDetails(security: security);

    security = securitiesManagement.firstWhere((element) => element.keyField.startsWith('promotions_actions'));
    security.accessLevel = int.parse(promotionsAndActions.text) ;
    await securityFunctions.updateDetails(security: security);

    security = securitiesManagement.firstWhere((element) => element.keyField.startsWith('users_security'));
    security.accessLevel = int.parse(usersAndSecurity.text) ;
    await securityFunctions.updateDetails(security: security);

    security = securitiesManagement.firstWhere((element) => element.keyField.startsWith('payment_types'));
    security.accessLevel = int.parse(paymentTypes.text) ;
    await securityFunctions.updateDetails(security: security);

    security = securitiesManagement.firstWhere((element) => element.keyField.startsWith('countries'));
    security.accessLevel = int.parse(countries.text) ;
    await securityFunctions.updateDetails(security: security);

    security = securitiesManagement.firstWhere((element) => element.keyField.startsWith('tax_rates'));
    security.accessLevel = int.parse(taxRates.text) ;
    await securityFunctions.updateDetails(security: security);

    security = securitiesManagement.firstWhere((element) => element.keyField.startsWith('my_company'));
    security.accessLevel = int.parse(myCompany.text) ;
    await securityFunctions.updateDetails(security: security);

    // Stock Values
    security = securitiesStock.firstWhere((element) => element.keyField.startsWith('quick_inventory'));
    security.accessLevel = int.parse(quickInventory.text) ;
    await securityFunctions.updateDetails(security: security);

    security = securitiesStock.firstWhere((element) => element.keyField.startsWith('view_cost_price'));
    security.accessLevel = int.parse(viewCostPrice.text) ;
    await securityFunctions.updateDetails(security: security);
  }

  Widget fieldDetails({required String fieldName, required TextEditingController controller}) {
    return Row(
      children: [
        Text(
          fieldName,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        IconButton(
          onPressed: () {
            if (controller.text == "") {
              return;
            }
            int val = int.parse(controller.text);
            val = val - 1;
            if (val < 0) {
              val = 0;
            }
            setState(() {
              controller.text = val.toString();
            });
          },
          icon: const Icon(
            Icons.remove,
            size: 15,
          ),
        ),
        SizedBox(
          width: 100,
          child: TextField(
            controller: controller,
            decoration: inputDecorationCustom(context: context),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            if (controller.text == "") {
              return;
            }
            int val = int.parse(controller.text);
            val = val + 1;
            if (val > 9) {
              val = 9;
            }
            setState(() {
              controller.text = val.toString();
            });
          },
          icon: const Icon(
            Icons.add,
            size: 15,
          ),
        ),
      ],
    );
  }

  Widget subHead({required String headName}) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(10),
      color: Colors.teal,
      child: Text(headName, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white)),
    );
  }

  Widget customRow({required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 2, 30, 2),
        child : Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(border: Border.all(width: 1, color: Theme.of(context).highlightColor)),
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
                decoration: BoxDecoration(border: Border.all(width: 1, color: Theme.of(context).highlightColor)),
                margin: const EdgeInsets.all(5),
                child: SizedBox.fromSize(
                  size: const Size(80, 80),
                  child: ClipRect(
                    child: Material(
                      color: Theme.of(context).dialogBackgroundColor,
                      child: InkWell(
                        splashColor: Theme.of(context).highlightColor,
                        onTap: () {
                          save();
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.check), // <-- Icon
                            Text(
                              "Save",
                            ), // <-- Text
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(border: Border.all(width: 1, color: Theme.of(context).highlightColor)),
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
          Text(
            'Set access level for predefined operations',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            'Set access level for each action in order to set required user permissions',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          // General Entries
          subHead(headName: 'General'),
          customRow(children: [
            fieldDetails(fieldName: 'Management', controller: management),
            fieldDetails(fieldName: 'Settings', controller: settings),
          ]),
          customRow(children: [
            fieldDetails(fieldName: 'End of Day', controller: endOfDay),
            fieldDetails(fieldName: 'User Profile', controller: userProfile),
          ]),
          customRow(children: [
            fieldDetails(fieldName: 'Design floor plans', controller: designFloorPlans),
          ]),

          // Sales Entries
          subHead(headName: 'Sales'),
          customRow(children: [
            fieldDetails(fieldName: 'View all open orders', controller: viewAllOpenDrawers),
            fieldDetails(fieldName: 'Void order', controller: voidOrder),
          ]),
          customRow(children: [
            fieldDetails(fieldName: 'Void item', controller: voidItem),
            fieldDetails(fieldName: 'Lock sale', controller: lockSale),
          ]),
          customRow(children: [
            fieldDetails(fieldName: 'Unlock sale', controller: unlockSale),
            fieldDetails(fieldName: 'Split Order', controller: splitOrder),
          ]),
          customRow(children: [
            fieldDetails(fieldName: 'Apply Discount', controller: applyDiscount),
            fieldDetails(fieldName: 'Delete Discount', controller: deleteDiscount),
          ]),
          customRow(children: [
            fieldDetails(fieldName: 'Refund', controller: refund),
            fieldDetails(fieldName: 'View sales history', controller: viewSaleHistory),
          ]),
          customRow(children: [
            fieldDetails(fieldName: 'Reprint receipt', controller: reprintReceipt),
            fieldDetails(fieldName: 'Starting cash', controller: startingCash),
          ]),
          customRow(children: [
            fieldDetails(fieldName: 'Open cash drawer', controller: openCashDrawer),
            fieldDetails(fieldName: 'Zero stock quantity sale', controller: zeroStockQuantitySale),
          ]),
          // Management Entries
          subHead(headName: 'Management'),
          customRow(children: [
            fieldDetails(fieldName: 'Dashboard', controller: dashboard),
            fieldDetails(fieldName: 'Documents', controller: documents),
          ]),
          customRow(children: [
            fieldDetails(fieldName: 'Products', controller: products),
            fieldDetails(fieldName: 'Stock', controller: stock),
          ]),
          customRow(children: [
            fieldDetails(fieldName: 'Reporting', controller: reporting),
            fieldDetails(fieldName: 'Customers & Suppliers', controller: customersAndSuppliers),
          ]),
          customRow(children: [
            fieldDetails(fieldName: 'Promotions & actions', controller: promotionsAndActions),
            fieldDetails(fieldName: 'Users & security', controller: usersAndSecurity),
          ]),
          customRow(children: [
            fieldDetails(fieldName: 'Payment types', controller: paymentTypes),
            fieldDetails(fieldName: 'Countries', controller: countries),
          ]),
          customRow(children: [
            fieldDetails(fieldName: 'Tax rates', controller: taxRates),
            fieldDetails(fieldName: 'My Company', controller: myCompany),
          ]),

          // Stock Entries
          subHead(headName: 'Stock'),
          customRow(children: [
            fieldDetails(fieldName: 'Quick Inventory', controller: quickInventory),
            fieldDetails(fieldName: 'View cost prices', controller: viewCostPrice),
          ]),

          // Extra Space
          const SizedBox(height: 100,),

        ],
      ),
    );
  }
}
