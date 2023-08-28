import 'dart:async';

import 'package:flutter/material.dart';

//Text field that provides debounce functionality
class DebouncedTextField extends TextField {
  final Duration debounceTime;
  late Timer timer;

  DebouncedTextField(
      {super.key,
      super.onChanged,
      super.decoration,
      required this.debounceTime}) {
    timer = Timer(debounceTime, () {});
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      onChanged: (value) {
        timer.cancel();
        timer = Timer(debounceTime, () {
          if (onChanged != null) {
            onChanged!(value);
          }
        });
      },
      decoration: decoration,
    );
  }
}
