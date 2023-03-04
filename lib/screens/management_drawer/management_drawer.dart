import 'package:flutter/material.dart';
import 'package:pos/screens/company_data/company_data.dart';
import 'package:pos/screens/customers_and_suppliers/customers_and_suppliers.dart';
import 'package:pos/screens/payment_type/payment_type.dart';
import 'package:pos/screens/print_station/print_station.dart';
import 'package:pos/screens/products/products.dart';
import 'package:pos/screens/promotion_and_actions/promotion_and_action.dart';
import 'package:pos/screens/report/report.dart';
import 'package:pos/screens/stock/stock.dart';
import 'package:pos/screens/user_and_security/user_and_security.dart';

import '../documents/documents.dart';
import '../tax_rates/tax_rates.dart';
import '../dashboard/dashboard.dart';


class ManagmentDrawer extends StatefulWidget {
  @override
  _ManagmentDrawerState createState() => _ManagmentDrawerState();
}

class _ManagmentDrawerState extends State<ManagmentDrawer> {
  var currentPage = DrawerSections.dashboard;
  String title = "Management" ;

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.dashboard) {
      container = DashboardPage();
      title = "Management" ;
    } else if (currentPage == DrawerSections.documents) {
      container = DocumentsPage();
      title = "Management / Documents" ;
    } else if (currentPage == DrawerSections.products) {
      container = ProductsPage();
      title = "Management / Products" ;
    } else if (currentPage == DrawerSections.stock) {
      container = StockPage();
      title = "Management / Stock" ;
    } else if (currentPage == DrawerSections.reporting) {
      container = ReportPage();
      title = "Management / Reports" ;
    } else if (currentPage == DrawerSections.customersAndSuppliers) {
      container = CustomerAndSupplierPage();
      title = "Management / Customers & Suppliers";
    } else if (currentPage == DrawerSections.promotionAndAction) {
      container = PromotionAndActionPage();
      title = "Management / Promotions & Actions" ;
    } else if (currentPage == DrawerSections.userAndSecurity) {
      container = UserAndSecurityPage();
      title = "Management / User & Security" ;
    } else if (currentPage == DrawerSections.printStation) {
      container = PrintStationPage();
      title = "Management / Print station" ;
    } else if (currentPage == DrawerSections.paymentTypes) {
      container = PaymentTypePage();
      title = "Management / Payment types" ;
    } else if (currentPage == DrawerSections.taxRates) {
      container = TaxRates();
      title = "Management / Tax rates" ;
    } else if (currentPage == DrawerSections.myCompany) {
      container = Company();
      title = "Management / My Company" ;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: Theme.of(context).textTheme.titleLarge,),
      ),
      body: container,
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.background,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Dashboard", Icons.dashboard_outlined,
              currentPage == DrawerSections.dashboard ? true : false),
          menuItem(2, "Documents", Icons.library_books,
              currentPage == DrawerSections.documents ? true : false),
          menuItem(3, "Products", Icons.label,
              currentPage == DrawerSections.products ? true : false),
          menuItem(4, "Stock", Icons.book_outlined,
              currentPage == DrawerSections.stock ? true : false),
          menuItem(5, "Reporting", Icons.event_note_outlined,
              currentPage == DrawerSections.reporting ? true : false),
          menuItem(6, "Customers & Suppliers", Icons.person_sharp,
              currentPage == DrawerSections.customersAndSuppliers ? true : false),
          menuItem(7, "Promotion & Actions", Icons.call_to_action_outlined,
              currentPage == DrawerSections.promotionAndAction ? true : false),
          menuItem(8, "User & Security", Icons.key_rounded,
              currentPage == DrawerSections.userAndSecurity ? true : false),
          menuItem(9, "Print stations", Icons.print,
              currentPage == DrawerSections.printStation ? true : false),
          menuItem(10, "Payment types", Icons.payment_outlined,
              currentPage == DrawerSections.paymentTypes ? true : false),
          menuItem(11, "Tax rates", Icons.percent_outlined,
              currentPage == DrawerSections.taxRates ? true : false),
          menuItem(12, "My Company", Icons.apartment,
              currentPage == DrawerSections.myCompany ? true : false),
          Divider(),
          Container(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_circle_left_outlined),
            ),
          )
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.dashboard;
            } else if (id == 2) {
              currentPage = DrawerSections.documents;
            } else if (id == 3) {
              currentPage = DrawerSections.products;
            } else if (id == 4) {
              currentPage = DrawerSections.stock;
            } else if (id == 5) {
              currentPage = DrawerSections.reporting;
            } else if (id == 6) {
              currentPage = DrawerSections.customersAndSuppliers;
            } else if (id == 7) {
              currentPage = DrawerSections.promotionAndAction;
            } else if (id == 8) {
              currentPage = DrawerSections.userAndSecurity;
            } else if (id == 9){
              currentPage = DrawerSections.printStation;
            } else if (id == 10){
              currentPage = DrawerSections.paymentTypes;
            } else if (id == 11){
              currentPage = DrawerSections.taxRates;
            } else if (id == 12){
              currentPage = DrawerSections.myCompany;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  dashboard,
  documents,
  products,
  stock,
  reporting,
  customersAndSuppliers,
  promotionAndAction,
  userAndSecurity,
  printStation,
  paymentTypes,
  taxRates,
  myCompany
}
