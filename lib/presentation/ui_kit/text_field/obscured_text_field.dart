import 'package:flutter/material.dart';
import 'package:parking_project/assets/colors/app_colors.dart';

//Text field that provides debounce functionality
class ObscuredTextField extends TextField {
  const ObscuredTextField({
    super.key,
    super.onChanged,
    super.decoration,
    super.controller,
    super.textInputAction,
  });

  @override
  State<ObscuredTextField> createState() => _ObscuredTextFieldState();
}

class _ObscuredTextFieldState extends State<ObscuredTextField> {
  var _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: widget.textInputAction,
      obscureText: !_isVisible,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      controller: widget.controller,
      onChanged: (value) {
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
      decoration: widget.decoration!.copyWith(
          suffixIcon: IconButton(
        onPressed: () {
          setState(() {
            _isVisible = !_isVisible;
          });
        },
        icon: Icon(_isVisible ? Icons.visibility : Icons.visibility_off,
            color: AppColors.primaryBlue),
      )),
    );
  }
}
