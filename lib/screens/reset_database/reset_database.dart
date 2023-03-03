import 'package:flutter/material.dart';

class ResetDatabase extends StatefulWidget {
  const ResetDatabase({Key? key}) : super(key: key);

  @override
  State<ResetDatabase> createState() => _ResetDatabaseState();
}

class _ResetDatabaseState extends State<ResetDatabase> {
  bool isProducts = false;
  bool isCustomers = false;
  bool isDocuments = false;

  // TODO : Need to add a way to get the directory path
  // TODO : Need a way reset database need to provide the specific service for that

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Database'),
      ),
      body: ListView(
        children: [
          Row(
            children: [
              Container(
                color: Colors.amber,
                width: 40,
                height: 40,
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                child: const Icon(
                  Icons.warning_amber,
                  color: Colors.brown,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).highlightColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'This is destructive operation.',
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        'Please make sure to proceed only if you only want to proceed',
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    shape: BoxShape.circle,
                    color: Theme.of(context).highlightColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '1',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Backup database path',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      'Location of database backup will be saved',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      'Database backup will be performed before the reset. You can change default backup destination below',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 500,
                          height: 35,
                          child: TextField(
                            decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).focusColor,
                                    width: 1.0),
                              ),
                              hintText: 'Destination Folder Path',
                              suffixStyle:
                                  Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white30,
                          width: 30,
                          height: 30,
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                          child: const Icon(
                            Icons.folder,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    shape: BoxShape.circle,
                    color: Theme.of(context).highlightColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '2',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select entries to reset',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      'Selected entries will be deleted from database',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          checkColor: Theme.of(context).scaffoldBackgroundColor,
                          value: isProducts,
                          onChanged: (bool? value) {
                            setState(() {
                              isProducts = value!;
                            });
                          },
                        ),
                        Text(
                          'Products',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          checkColor: Theme.of(context).scaffoldBackgroundColor,
                          value: isCustomers,
                          onChanged: (bool? value) {
                            setState(() {
                              isCustomers = value!;
                            });
                          },
                        ),
                        Text(
                          'Customers',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          checkColor: Theme.of(context).scaffoldBackgroundColor,
                          value: isDocuments,
                          onChanged: (bool? value) {
                            setState(() {
                              isDocuments = value!;
                            });
                          },
                        ),
                        Text(
                          'Documents',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    shape: BoxShape.circle,
                    color: Theme.of(context).highlightColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '3',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Confirmation',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      'Authorize and perform reset on selected entities',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Enter administrator password',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 200,
                          height: 35,
                          child: TextField(
                            decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).focusColor,
                                    width: 1.0),
                              ),
                              hintText: 'Enter admin password',
                              suffixStyle:
                              Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(10, 5, 5, 10),
            child: Row(
              children: [
                FloatingActionButton.extended(
                  label: Text('Reset Database', style: Theme.of(context).textTheme.bodyMedium,), // <-- Text
                  backgroundColor: Theme.of(context).colorScheme.background,
                  foregroundColor: Theme.of(context).hintColor,
                  icon: const Icon( 
                    Icons.lock_reset,
                    size: 24.0,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
