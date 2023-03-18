import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:pos/database_models_functions/user_functions.dart';
import 'package:pos/models/user.dart';
import 'package:pos/screens/user_and_security/add_user_bottom_sheet.dart';
import 'package:pos/screens/user_and_security/delete_user_dialog.dart';
import 'package:pos/screens/user_and_security/edit_user_bottom_sheet.dart';

import '../../widgets/snackbar.dart';
import '../../widgets/text_decorations.dart';
import 'dart:developer' as developer;

class UserAndSecurityPage extends StatefulWidget {
  const UserAndSecurityPage({Key? key}) : super(key: key);

  @override
  State<UserAndSecurityPage> createState() => _UserAndSecurityPageState();
}

class _UserAndSecurityPageState extends State<UserAndSecurityPage> {
  UserFunctions userFunctions = UserFunctions();
  bool showActiveUsers = true;
  UserSource userSource = UserSource(users: [], count: 0);
  String searchText = "";
  Set<String> suggestions = {};
  List<User> users = [];
  List<User> originalUsers = [];
  bool isAscending = true;
  int sortColumnIndex = 0;
  int selectedRowIndex = -1;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    users = (await userFunctions.getAllUsers());
    originalUsers = users;
    userSource = UserSource(users: users, count: users.length);
    for (User user in users) {
      suggestions.add(user.firstName);
      suggestions.add(user.lastName);
    }
    setState(() {});
  }

  onSortColumn(int columnIndex, bool ascending) {
    // Column index = 0 : for First name
    if (columnIndex == 0) {
      if (ascending) {
        users.sort((a, b) => a.firstName.compareTo(b.firstName));
      } else {
        users.sort((a, b) => b.firstName.compareTo(a.firstName));
      }
    }

    // Column index = 1 : for Last Name
    if (columnIndex == 1) {
      if (ascending) {
        users.sort((a, b) => a.lastName.compareTo(b.lastName));
      } else {
        users.sort((a, b) => b.lastName.compareTo(a.firstName));
      }
    }

    // Column index = 2 : for Email
    if (columnIndex == 2) {
      if (ascending) {
        users.sort((a, b) => a.email.compareTo(b.email));
      } else {
        users.sort((a, b) => b.email.compareTo(a.email));
      }
    }

    // Column index = 3 : is Access Level
    if (columnIndex == 3) {
      if (ascending) {
        users.sort((a, b) =>
            a.accessLevel.toString().compareTo(b.accessLevel.toString()));
      } else {
        users.sort((a, b) =>
            b.accessLevel.toString().compareTo(a.accessLevel.toString()));
      }
    }

    setState(() {
      userSource = UserSource(users: users, count: users.length);
    });
  }

  refresh() {
    loadData() ;
  }

  addUser() {
    addUserBottomSheet(context);
  }

  editUser() {
    if (userSource.selectedUsers.isEmpty) {
      displayMessage(
          context: context,
          title: 'Please select a user',
          message:
          'For editing the pre-existing user please select only one row and click on edit button',
          contentType: ContentType.help);
    } else if (userSource.selectedUsers.length > 1) {
      displayMessage(
          context: context,
          title: 'Please select only 1 row for editing user',
          message:
          'For editing the pre-existing user please select only one row and click on edit button',
          contentType: ContentType.help);
    } else {
      developer.log('Editing user');
      editUserBottomSheet(context, userSource.selectedUsers.first) ;

    }
  }

  deleteUsers() {
    if (userSource.selectedUsers.isEmpty){
      displayMessage(context: context, title: "No row selected", message: 'Please select atleast 1 row to perform delete operation', contentType: ContentType.help);
    }
    else{
      showDialog(context: context, builder: (BuildContext context){
        return DeleteUserDialogBox(users: userSource.selectedUsers,) ;
      });
      refresh() ;
      setState(() {

      });
    }
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
                          addUser();
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.add), // <-- Icon
                            Text(
                              "Add user",
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
                          editUser();
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
                          deleteUsers();
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
                  size: const Size(100, 80),
                  child: ClipRect(
                    child: Material(
                      color: Theme.of(context).dialogBackgroundColor,
                      child: InkWell(
                        splashColor: Theme.of(context).highlightColor,
                        onTap: () {
                          // TODO : Need to add the reset password functionality
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.password), // <-- Icon
                            Text("Reset password"), // <-- Text
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
                  size: const Size(150, 80),
                  child: ClipRect(
                    child: Material(
                      color: Theme.of(context).dialogBackgroundColor,
                      child: InkWell(
                        splashColor: Theme.of(context).highlightColor,
                        onTap: () {
                          // TODO : Need to add functionality to show inactive users or active users
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Switch(
                                value: showActiveUsers,
                                activeColor: Colors.green,
                                inactiveThumbColor: Colors.grey,
                                inactiveTrackColor: Colors.grey,
                                onChanged: (bool value) {
                                  setState(() {
                                    showActiveUsers = value;
                                  });
                                }), // <-- Icon
                            const Text("Show inactive users"), // <-- Text
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
                      matches.retainWhere((userName) {
                        return userName
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
                    List<User> newUsers = originalUsers
                        .where((element) => element.firstName
                            .toLowerCase()
                            .contains(searchText.toLowerCase()))
                        .toList();
                    developer.log(newUsers.length.toString());
                    setState(() {
                      users = newUsers;
                      userSource =
                          UserSource(users: users, count: users.length);
                    });
                  },
                  icon: const Icon(Icons.search),
                  iconSize: 30,
                ),
              ),
            ],
          ),
          users.isNotEmpty
              ? PaginatedDataTable(
                  showCheckboxColumn: true,
                  sortAscending: isAscending,
                  sortColumnIndex: sortColumnIndex,
                  columns: <DataColumn>[
                    DataColumn(
                      label: const Text('First name'),
                      onSort: (columnIndex, ascending) {
                        sortColumnIndex = columnIndex;
                        isAscending = ascending;
                        onSortColumn(sortColumnIndex, isAscending);
                      },
                    ),
                    DataColumn(
                      label: const Text('Last Name'),
                      onSort: (columnIndex, ascending) {
                        sortColumnIndex = columnIndex;
                        isAscending = ascending;
                        onSortColumn(sortColumnIndex, isAscending);
                      },
                    ),
                    DataColumn(
                      label: const Text('Email'),
                      onSort: (columnIndex, ascending) {
                        sortColumnIndex = columnIndex;
                        isAscending = ascending;
                        onSortColumn(sortColumnIndex, isAscending);
                      },
                    ),
                    DataColumn(
                      label: const Text('Access level'),
                      onSort: (columnIndex, ascending) {
                        sortColumnIndex = columnIndex;
                        isAscending = ascending;
                        onSortColumn(sortColumnIndex, isAscending);
                      },
                    ),
                    DataColumn(
                      label: const Text('Active'),
                      onSort: (columnIndex, ascending) {
                        sortColumnIndex = columnIndex;
                        isAscending = ascending;
                        onSortColumn(sortColumnIndex, isAscending);
                      },
                    ),
                  ],
                  source: userSource,
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
                        'No Users',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FloatingActionButton.extended(
                        label: Text(
                          'Add new users',
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
                          addUser();
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

class UserSource extends DataTableSource {
  List<User> users;
  List<User> selectedUsers = [];
  int count;
  int rowsSelected = 0;

  UserSource({
    required this.users,
    required this.count,
  });

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      final User user = users[index];
      return DataRow.byIndex(
          index: index,
          selected: selectedUsers.contains(user),
          onSelectChanged: (selected) {
            if (selected != null) {
              if (selected) {
                selectedUsers.add(user);
                rowsSelected += 1;
              } else {
                selectedUsers.remove(user);
                rowsSelected -= 1;
              }
            }
            developer.log("Row is clicked");
            developer.log(rowsSelected.toString());
            notifyListeners();
          },
          cells: [
            DataCell(Text(users[index].firstName)),
            DataCell(Text(users[index].lastName)),
            DataCell(Text(users[index].email)),
            DataCell(Text(users[index].accessLevel.toString())),
            DataCell(Text(users[index].active.toString())),
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
