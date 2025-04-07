import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchBarWidget extends StatelessWidget {
final TextEditingController controller;

 final ValueChanged<String> onChanged;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
          color: Color(0xFF171C26), borderRadius: BorderRadius.circular(35)),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Icon(
              CupertinoIcons.tornado,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 20, right: 30),
              height: 25,
              child: TextFormField(
                onChanged: onChanged,
                controller: controller,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(36),
                ],
                style: TextStyle(
                  color: Colors.white,
                ),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  hintStyle: TextStyle(color: Color(0xFF5A6272)),
                  fillColor: Colors.green,
                  counterStyle: TextStyle(color: Colors.white),
                  hintText: 'Search your notes',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
