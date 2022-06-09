import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.controller,
      this.keyboardType = TextInputType.text,
      this.text = "",
      this.additionalText = "",
      this.isDecimal = false,
      this.isNumber = false,
      this.readOnly = false,
      this.hint,
      this.onChanged,
      this.maxLines,
      this.suffix,
      this.obscure = false})
      : super(key: key);

  final TextEditingController controller;
  final TextInputType keyboardType;
  final String text;
  final String additionalText;
  final bool isDecimal;
  final bool isNumber;
  final bool readOnly;
  final String? hint;
  final Function(String t)? onChanged;
  final int? maxLines;
  final Widget? suffix;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                text,
              ),
            ),
            Text(
              additionalText,
            ),
          ],
        ),
        SizedBox(height: 10),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          readOnly: readOnly,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            // labelText: "$text...",
            hintText: hint ?? "Masukkan $text..",
            suffixIcon: suffix,
          ),
          obscureText: obscure,
          inputFormatters: [],
          maxLines: obscure ? 1 : maxLines,
          autofocus: false,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
