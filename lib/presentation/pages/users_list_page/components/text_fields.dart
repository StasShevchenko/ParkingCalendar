import 'package:flutter/material.dart';

class TextFieldsData {
  final IconData icon;
  final String text;

  TextFieldsData(this.icon, this.text);
}

List<TextFieldsData> officeFieldsData = [
  TextFieldsData(Icons.location_city, "Введите город"),
  TextFieldsData(Icons.map_rounded, "Введите адрес"),
];
List<TextFieldsData> adminFieldsData = [
  TextFieldsData(Icons.mail, "Введите почту"),
  TextFieldsData(Icons.lock, "Введите пароль"),
  TextFieldsData(Icons.people, "Введите имя"),
];
List<TextFieldsData> employeeFieldsData = [
  TextFieldsData(Icons.mail, "Введите почту"),
  TextFieldsData(Icons.lock, "Введите пароль"),
  TextFieldsData(Icons.people, "Введите имя"),
];
