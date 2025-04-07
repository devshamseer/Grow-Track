import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For input formatters
import '../../theme/app_colors.dart';

class TextFieldHeadingWidget extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final bool isAmountField;

  const TextFieldHeadingWidget({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    this.isAmountField = false, // Add a flag for amount input
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 50,
          child: TextFormField(
            keyboardType: isAmountField
                ? TextInputType.numberWithOptions(decimal: true) // Amount input
                : TextInputType.text, // Regular text input
            controller: controller,
            inputFormatters: isAmountField
                ? [
                    LengthLimitingTextInputFormatter(
                        12), // Max length of 12 characters
                    FilteringTextInputFormatter.allow(
                      RegExp(
                          r'^\d+\.?\d{0,2}'), // Allow numbers with up to 2 decimals
                    ),
                  ]
                : [],
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.cardColor2,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              hintText: hintText,
              hintStyle: const TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(146, 255, 255, 255)), // hint text color
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            style: TextStyle(color: Colors.white), // text color
            cursorColor: Colors.white, // cursor color
          ),
        ),
      ],
    );
  }
}
