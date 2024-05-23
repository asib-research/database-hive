import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DataViewScreen extends StatefulWidget {
  const DataViewScreen({super.key});

  @override
  State<DataViewScreen> createState() => _DataViewScreenState();
}

class _DataViewScreenState extends State<DataViewScreen> {

  Box? box;
  @override
  void initState() {
    box = Hive.box('notepad');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data View"),
      ),
      body: ListView.builder(
          itemCount: box!.keys.toList().length,
          itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(box!.getAt(index).toString()),
          ),        );
      }),
    );
  }
}
