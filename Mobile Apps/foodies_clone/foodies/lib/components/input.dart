import 'package:flutter/material.dart';
import 'package:foodies/constants/constants.dart';

class InputComponent extends StatefulWidget {
  final bool? isObscured;
  final String hintText;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  const InputComponent(
      {super.key,
      this.isObscured,
      required this.hintText,
      this.prefixIcon,
      this.keyboardType});

  @override
  State<InputComponent> createState() => _InputComponentState();
}

class _InputComponentState extends State<InputComponent> {
  @override
  Widget build(BuildContext context) {
    bool isObscured = widget.isObscured ?? false;

    return TextField(
      keyboardType: widget.keyboardType ?? TextInputType.text,
      obscureText: isObscured,
      decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          contentPadding: const EdgeInsets.all(15),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 16,
          ),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: primaryColor),
          ),
          suffixIcon: isObscured
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      isObscured = !isObscured;
                    });
                  },
                  child: isObscured
                      ? Icon(Icons.visibility, color: Colors.grey.shade500)
                      : Icon(Icons.visibility_off, color: Colors.grey.shade500),
                )
              : null),
    );
  }
}
