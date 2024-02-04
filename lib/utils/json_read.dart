import 'dart:convert';

import 'package:flutter/services.dart';

Future<List<dynamic>> readJson({required String jsonPath}) async {
  final String response = await rootBundle.loadString(jsonPath);
  final data = await json.decode(response);
  return data;
}