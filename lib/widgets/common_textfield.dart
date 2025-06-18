import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextField extends StatefulWidget {
  final String hintText;
  final Widget? suffixIcon;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final TextInputType? keyBoardType;
  final TextEditingController? controller;
  final bool? readOnly;
  final VoidCallback? onTap;
  final bool isNumberPad;
  final bool isEmail;

  const CommonTextField(
      {super.key,
        required this.hintText,
        this.obscureText = false,
        this.validator,
        this.onChanged,
        this.onSubmitted,
        this.isEmail = false,
        this.keyBoardType,
        this.controller,
        this.readOnly = false,
        this.onTap,
        this.suffixIcon,
        this.isNumberPad = false});

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  List<TextInputFormatter> inputFormatterList = [
    FilteringTextInputFormatter.allow(
      RegExp("^[a-zA-Z0-9!@._-]+"),
    )
  ];

  @override
  void initState() {
    if (widget.isNumberPad) {
      inputFormatterList.add(FilteringTextInputFormatter.digitsOnly);
    }
    if (widget.isEmail) {
      inputFormatterList
          .add(FilteringTextInputFormatter.allow(RegExp("^[a-zA-Z0-9!@._-]+")));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      readOnly: widget.readOnly ?? false,
      onTap: widget.onTap,
      decoration: InputDecoration(
        suffixIcon: widget.suffixIcon,
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        errorStyle: const TextStyle(height: 0.8),
      ),
      validator: widget.validator != null
          ? (value) => widget.validator!.call(value!)
          : null,
      onChanged: (value) {
        widget.onChanged?.call(value);
      },
      onFieldSubmitted: (value) => widget.onSubmitted?.call(value),
      keyboardType: widget.isEmail
          ? TextInputType.emailAddress
          : widget.isNumberPad
          ? TextInputType.number
          : TextInputType.name,
      inputFormatters: inputFormatterList,
    );
  }
}
