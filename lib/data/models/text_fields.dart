import 'package:flutter/material.dart';

class TextFieldsData {
  final IconData icon;
  final String text;

  TextFieldsData(this.icon, this.text);
}

List<TextFieldsData> addOffice = [
  TextFieldsData(Icons.location_city, "Введите город"),
  TextFieldsData(Icons.map_rounded, "Введите адрес"),
];
List<TextFieldsData> addAdmin = [
  TextFieldsData(Icons.mail, "Введите почту"),
  TextFieldsData(Icons.lock, "Введите пароль"),
  TextFieldsData(Icons.people, "Введите имя"),
];
List<TextFieldsData> addEmpl = [
  TextFieldsData(Icons.mail, "Введите почту"),
  TextFieldsData(Icons.lock, "Введите пароль"),
  TextFieldsData(Icons.people, "Введите имя"),
];
