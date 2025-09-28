import 'package:flutter/material.dart';
import 'package:tagify/app_theme.dart';

class DefaultTextFormField extends StatefulWidget{
  DefaultTextFormField({super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
    this.isPassword = false,
  });

  TextEditingController controller;
  String hintText;
  String? Function(String?)? validator;
  bool isPassword;

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  late bool isObscure = widget.isPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: widget.hintText,
        hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppTheme.darkGrey, fontWeight: FontWeight.bold, fontSize: 18),


      ),
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}