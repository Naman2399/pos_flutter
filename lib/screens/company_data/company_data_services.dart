import 'package:flutter/cupertino.dart';
import 'dart:developer' as developer;

import 'package:mysql1/mysql1.dart';

import '../../models/company_data.dart';
import '../../database_models_functions/mysql_connection.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import '../../widgets/snackbar.dart';


class CompanyDataServices {
  CompanyDataServices() ;

  Future<CompanyData> loadCompanyDetails() async{
    developer.log('Loading all the details from the database');
    Mysql database = Mysql() ;
    MySqlConnection connection = await database.getConnection()   ;
    var results =  await connection.query('SELECT name, tax_number, address, '
        'zip_code, city, state, country, phone_number, '
        'email, bank_account_number, bank_details '
        'FROM company_details');

    CompanyData companyData = CompanyData() ;
    for (var row in results) {
      companyData = CompanyData(name: row[0], taxNumber: row[1], address: row[2],
      zipCode: row[3], city: row[4], state: row[5], country: row[6], phoneNumber: row[7],
      email: row[8], bankAccountNumber: row[9], bankDetails: row[10]);
    }
    return companyData ;
  }

  Future<void> saveDetails({required BuildContext context, required CompanyData companyData}) async {
    developer.log("Saving all the company details");
    developer.log("Updating the company details");
    developer.log("Company Details ... ") ;
    developer.log("Name : ${companyData.name}");
    developer.log("Tax : ${companyData.taxNumber}");
    developer.log("Address : ${companyData.address}");
    developer.log("Zip Code : ${companyData.zipCode}");
    developer.log("City : ${companyData.city}");
    developer.log("State : ${companyData.state}");
    developer.log("Country : ${companyData.country}");
    developer.log("Phone Number : ${companyData.phoneNumber}");
    developer.log("Email : ${companyData.email}");
    developer.log("Bank Account Number : ${companyData.bankAccountNumber}");
    developer.log("Bank Details : ${companyData.bankDetails}");

    if (validateName(context, companyData.name) &&
        validateAddress(context, companyData.address) &&
        validateZipCode(context, companyData.zipCode) &&
        validateCity(context, companyData.city) &&
        validateState(context, companyData.state) &&
        validateCountry(context, companyData.country) &&
        validatePhoneNumber(context, companyData.phoneNumber) &&
        validateEmail(context, companyData.email)) {

      Mysql database = Mysql() ;
      MySqlConnection connection = await database.getConnection()   ;

      connection.query('UPDATE company_details SET name = ? , tax_number = ?, '
          'address = ? , zip_code = ?, city = ?, state = ?, '
          'country = ?, phone_number = ?, email = ?, '
          'bank_account_number = ?, bank_details = ? ',
          [companyData.name, companyData.taxNumber, companyData.address, companyData.zipCode,
            companyData.city , companyData.state, companyData.country,
            companyData.phoneNumber, companyData.email, companyData.bankAccountNumber,
            companyData.bankDetails]) ;
      connection.query('commit') ;
      developer.log('All The Details Saved Successfully') ;

    }

  }

  bool validateName(BuildContext context, String string) {
    if(string.isEmpty){
      developer.log("Name Field can't be empty");
      displayMessage(context: context, title: 'Error in Name Field', message: 'Name field can\'t be left empty',
          contentType: ContentType.failure);
      return false ;
    }
    return true ;
  }

  bool validateAddress(BuildContext context, String string){

    if(string.isEmpty){
      developer.log("Address field can't be empty") ;
      displayMessage(context: context, title: 'Error in Address Field', message: 'Address field can\'t be left empty',
          contentType: ContentType.failure);
      return false ;
    }
    return true ;

  }

  bool validateZipCode(BuildContext context, String string){

    if(string.isEmpty){
      developer.log("Zip Code can't be empty") ;
      displayMessage(context: context, title: 'Error in Zip Code Field', message: 'Zip Code field can\'t be left empty',
          contentType: ContentType.failure);
      return false ;
    }
    return true;

  }

  bool validateCity(BuildContext context, String string){

    if(string.isEmpty){
      developer.log("City field can't be empty") ;
      displayMessage(context: context, title: 'Error in City Field', message: 'City field can\'t be left empty',
          contentType: ContentType.failure);
      return false ;
    }
    return true ;

  }

  bool validateState(BuildContext context, String string){

    if(string.isEmpty){
      developer.log("State field can't be empty") ;
      displayMessage(context: context, title: 'Error in State Field', message: 'State field can\'t be left empty',
          contentType: ContentType.failure);
      return false ;
    }
    return true;

  }

  bool validateCountry(BuildContext context, String string){

    if(string.isEmpty){
      developer.log("Country field can't be empty") ;
      displayMessage(context: context, title: 'Error in Country Field', message: 'Country field can\'t be left empty',
          contentType: ContentType.failure);
      return false ;
    }
    return true ;

  }

  bool validatePhoneNumber(BuildContext context, String string){
    if(string.isEmpty){
      developer.log("Phone Number field can't be empty") ;
      displayMessage(context: context, title: 'Error in Phone Number Field', message: 'Phone Number field can\'t be left empty',
          contentType: ContentType.failure);
      return false ;
    }
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(patttern);
    if (!regExp.hasMatch(string)){
      developer.log("Please enter a valid phone number");
      // Phone number need to start with + or 0 followed by a 9. Than matches 10 digits
      displayMessage(context: context, title: 'Error in Phone Number Field', message: 'Phone number need to start with + or 0 followed by a 9. Than matches 10 digits',
          contentType: ContentType.failure);
      return false ;
    }
    return true;

  }

  bool validateEmail(BuildContext context, String string){

    if(string.isEmpty){
      developer.log("Email field can't be empty") ;
      displayMessage(context: context, title: 'Error in Email Field', message: 'Email field can\'t be left empty',
          contentType: ContentType.failure);
      return false ;
    }

    RegExp regExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+") ;
    if (!regExp.hasMatch(string)){
      developer.log("Please enter a valid email address") ;
      displayMessage(context: context, title: 'Error in Email Field', message: 'Please enter a valid email name',
          contentType: ContentType.failure);
      return false ;
    }

    return true;

  }


}