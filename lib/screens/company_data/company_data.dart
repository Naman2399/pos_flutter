import 'package:flutter/material.dart';
import 'package:pos/screens/company_data/company_data_services.dart';
import '../../models/company_data.dart';
import 'local_widgets.dart';


class Company extends StatefulWidget {
  const Company({super.key});

  @override
  State<Company> createState() => _Company();
}

class _Company extends State<Company> {
  CompanyDataServices companyDataServices = CompanyDataServices();
  TextEditingController name = TextEditingController();
  TextEditingController tax = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController zipCode = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController bankAccountNumber = TextEditingController();
  TextEditingController bankDetails = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CompanyData companyData;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Company Data'),
      ),
      body: FutureBuilder(
        future: companyDataServices.loadCompanyDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'Error occurred',
                  style: TextStyle(fontSize: 18),
                ),
              );
            } else if (snapshot.hasData) {
              companyData = snapshot.data as CompanyData;
              name.text = companyData.name;
              tax.text = companyData.taxNumber;
              address.text = companyData.address;
              zipCode.text = companyData.zipCode;
              city.text = companyData.city;
              state.text = companyData.state;
              country.text = companyData.country;
              phone.text = companyData.phoneNumber;
              email.text = companyData.email;
              bankAccountNumber.text = companyData.bankAccountNumber;
              bankDetails.text = companyData.bankDetails;
              return ListView(
                children: [
                  heading(name: 'My Company Data', context: context),
                  inputField(
                      inputFieldName: 'Name', textEditingController: name , context: context),
                  inputField(
                      inputFieldName: 'TAX / GST No.',
                      textEditingController: tax , context: context),
                  inputField(
                      inputFieldName: 'Address',
                      textEditingController: address, context: context),
                  inputField(
                      inputFieldName: 'Zip Code',
                      textEditingController: zipCode, context: context),
                  inputField(
                      inputFieldName: 'City', textEditingController: city, context: context),
                  inputField(
                      inputFieldName: 'State', textEditingController: state, context: context),
                  inputField(
                      inputFieldName: 'Country',
                      textEditingController: country, context: context),
                  inputField(
                      inputFieldName: 'Phone Number',
                      textEditingController: phone, context: context),
                  inputField(
                      inputFieldName: 'Email', textEditingController: email, context: context),
                  heading(name: 'Bank Details', context: context),
                  inputField(
                      inputFieldName: 'Bank Acount Number',
                      textEditingController: bankAccountNumber, context: context),
                  inputField(
                      inputFieldName: 'Bank Details',
                      textEditingController: bankDetails, context: context),
                  Container(
                    alignment: Alignment.center,
                    width: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // background
                        foregroundColor: Colors.white, // foreground
                      ),
                      onPressed: () {
                        CompanyData companyData = CompanyData(
                            name: name.text,
                            taxNumber: tax.text,
                            address: address.text,
                            zipCode: zipCode.text,
                            city: city.text,
                            state: state.text,
                            country: country.text,
                            phoneNumber: phone.text,
                            email: email.text,
                            bankAccountNumber: bankAccountNumber.text,
                            bankDetails: bankDetails.text);
                        companyDataServices.saveDetails(
                            context: context, companyData: companyData);
                      },
                      child: const Text('Save'),
                    ),
                  ),
                ],
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
