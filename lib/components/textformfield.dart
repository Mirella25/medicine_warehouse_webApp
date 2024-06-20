import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextInputType textInputType;
  final TextEditingController mycontroller;
  final String? prefixText;
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.mycontroller,
    required this.textInputType,
    this.prefixText,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.obscureText = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      keyboardType: textInputType,
      controller: mycontroller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        prefixText: prefixText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
        ),
        fillColor: Colors.grey[200],
        filled: true,
        hintText: hintText,
        prefixIcon: prefixIcon,
        hintStyle: TextStyle(color: Colors.grey[400]),
      ),
    );
  }
}
