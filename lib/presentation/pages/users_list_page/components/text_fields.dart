import 'package:flutter/material.dart';

class TextFieldsData {
  final IconData icon;
  final String text;
  TextFieldsData(this.icon, this.text);
}

List<TextFieldsData> userFieldsData = [
  TextFieldsData(Icons.mail, "Введите почту"),
  TextFieldsData(Icons.people, "Введите имя"),
  TextFieldsData(Icons.people, "Введите фамилию"),
];
