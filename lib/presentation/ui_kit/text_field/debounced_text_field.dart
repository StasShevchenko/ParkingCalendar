import 'dart:async';

import 'package:flutter/material.dart';

//Text field that provides debounce functionality
class DebouncedTextField extends TextField {
  final Duration debounceTime;

  const DebouncedTextField(
      {super.key,
      super.onChanged,
      super.decoration,
      required this.debounceTime});

  @override
  State<DebouncedTextField> createState() => _DebouncedTextFieldState();
}

class _DebouncedTextFieldState extends State<DebouncedTextField> {
  late Timer timer = Timer(widget.debounceTime, () {});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      onChanged: (value) {
        timer.cancel();
        timer = Timer(widget.debounceTime, () {
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        });
      },
      decoration: widget.decoration,
    );
  }
}
