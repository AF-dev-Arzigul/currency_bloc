import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  String _chooseLang = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              ListTile(
                title: Text("O'zbekcha"),
                leading: Radio(value: "O'zbekcha", groupValue: _chooseLang, onChanged: (value){
                  context.setLocale(const Locale("uz", "UZ"));
                  _chooseLang = value!;
                  // setState(() {});
                }),
              ),
              ListTile(
                title: Text("Крилча"),
                leading: Radio(value: "Крилча", groupValue: _chooseLang, onChanged: (value){
                  context.setLocale(const Locale("uz", "UZC"));
                  _chooseLang = value!;
                  // setState(() {});
                }),
              ),
              ListTile(
                title: Text("Русский"),
                leading: Radio(value: "Русский", groupValue: _chooseLang, onChanged: (value){
                  context.setLocale(const Locale("ru", "RU"));
                  _chooseLang = value!;
                  // setState(() {});
                }),
              ),
              ListTile(
                title: Text("English"),
                leading: Radio(value: "English", groupValue: _chooseLang, onChanged: (value){
                  context.setLocale(const Locale("en", "EN"));
                  _chooseLang = value!;
                  // setState(() {});
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
