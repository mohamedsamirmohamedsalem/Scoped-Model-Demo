import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final Color backgroundColor;
  final bool enabled;
  final int maxLines;
  final Icon? suffixIcon;
  final TextInputType keyboardType;
  final bool onlyChars;
  final bool requireSpecialChars;
  final bool showError; // Added property to control error display
  final Color? disabledTextColor; // Added property for disabled text color

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.backgroundColor = AppColors.textBackColor,
    this.enabled = true,
    this.maxLines = 1,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.onlyChars = false,
    this.requireSpecialChars = false,
    this.showError = false, // Default to false
    this.disabledTextColor, // Default is null (system's default)
  });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  bool _isObscured = true;
  bool _passwordValidationError = false; // State to track password validation

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  void _toggleVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  // Method to validate the password length
  void validatePassword() {
    if (widget.requireSpecialChars && widget.controller.text.length < 6) {
      setState(() {
        _passwordValidationError = true;
      });
    } else {
      setState(() {
        _passwordValidationError = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: widget.controller,
          obscureText: _isObscured,
          enabled: widget.enabled,
          maxLines: widget.maxLines,
          keyboardType: widget.keyboardType,
          inputFormatters: _getInputFormatters(),
          style: TextStyle(
            color: widget.enabled ? null : widget.disabledTextColor ?? Colors.grey,
          ),
          decoration: InputDecoration(
            labelText: widget.hintText,
            alignLabelWithHint: true,
            filled: true,
            fillColor: widget.backgroundColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            suffixIcon: widget.obscureText
                ? IconButton(
              icon: Icon(
                _isObscured ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: _toggleVisibility,
            )
                : widget.suffixIcon,
          ),
        ),
        if (widget.showError && _passwordValidationError)
          const Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: Text(
              'Password must contain at least one special character and be at least 6 characters long.',
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }

  List<TextInputFormatter>? _getInputFormatters() {
    if (widget.onlyChars) {
      return [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))];
    } else if (widget.requireSpecialChars) {
      return [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9!@#\$&*~]')),
      ];
    }
    return null;
  }
}
