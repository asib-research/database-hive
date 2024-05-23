import 'package:flutter/material.dart';
import 'package:notepad_app_with_hive/add_new_data_screen.dart';


class NotePad extends StatelessWidget {
  const NotePad({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AddNewDataScreen(),
    );
  }
}
