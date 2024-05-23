import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddNewDataScreen extends StatefulWidget {
  const AddNewDataScreen({super.key});

  @override
  State<AddNewDataScreen> createState() => _AddNewDataScreenState();
}

class _AddNewDataScreenState extends State<AddNewDataScreen> {
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _updateEditingController =  TextEditingController();

  Box? notepad;

  @override
  void initState() {
    notepad = Hive.box('notepad');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 2),
                  ),
                  labelText: "Write data",
                  hintText: "Write Data"),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  fixedSize: Size.fromWidth(double.maxFinite),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              onPressed: () async {
                try {
                  final userInput = _textEditingController.text;
                  await notepad!.add(userInput);
                  _textEditingController.clear();
                  Fluttertoast.showToast(msg: "Data Added");
                } catch (e) {
                  Fluttertoast.showToast(msg: "$e");
                }
              },
              child: Text("Add"),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: ValueListenableBuilder(
              valueListenable: Hive.box('notepad').listenable(),
              builder: (context, box, widget) {
                return ListView.builder(
                    itemCount: notepad!.keys.toList().length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(notepad!.getAt(index).toString()),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Dialog(
                                              child: Container(
                                                height: 200,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(20.0),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      TextField(
                                                        controller: _updateEditingController,
                                                        decoration: InputDecoration(
                                                          hintText:
                                                              "Write something",
                                                          labelText:
                                                              "Write something",
                                                        ),
                                                      ),
                                                      ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor: Colors.purple,
                                                          foregroundColor: Colors.white
                                                        ),
                                                        onPressed: () async {
                                                          final updateData = _updateEditingController.text;
                                                          await   notepad!.putAt(index, updateData);
                                                          Fluttertoast.showToast(msg: "Updated");
                                                          Navigator.pop(context);
                                                        },
                                                        child: Text("Update"),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.green,
                                    )),
                                IconButton(
                                    onPressed: () async {
                                      await notepad!.deleteAt(index);
                                      Fluttertoast.showToast(
                                          msg: "Deleted Successfully");
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
            )),
          ],
        ),
      ),
    );
  }
}
