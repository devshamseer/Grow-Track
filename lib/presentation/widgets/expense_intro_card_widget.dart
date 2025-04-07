import 'dart:ffi';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:grow_track/domain/utils/amount/amouont_utils.dart';
import 'package:grow_track/theme/app_colors.dart';
import 'package:intl/intl.dart';

class Expense_indro_cred_widget extends StatelessWidget {
  var ImageIcon;

  var Titel;

  var Descrpriton;

  var Amount;

  var onPressed;

  Expense_indro_cred_widget(
      {super.key,
      required this.ImageIcon,
      required this.Titel,
      required this.Descrpriton,
      required this.onPressed,
      required this.Amount});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        // height: 115,
        // width: 175,
        decoration: BoxDecoration(
          color: Color(0xFF171C26),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                margin: EdgeInsets.only(left: 1, bottom: 12, right: 12),
                height: 35,
                decoration: BoxDecoration(
                  //  color: Colors.amber,
                  // border: Border.all(color: Color.fromARGB(255, 135, 146, 167)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Text(
                        '₹${AmountUtils.formatAmount(amount:  Amount)}',
                        style:
                            TextStyle(color: Color(0xFF8792A7), fontSize: 15),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    ImageIcon,
                    height: 50,
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Color(0xFF1F2531), shape: BoxShape.circle),
                    child: Center(
                        child: Icon(
                      Icons.more_horiz_rounded,
                      color: Colors.white,
                    )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 71),
              child: Text(
                Titel,
                style: TextStyle(
                    color: AppColors.textColor1,
                    fontSize: 21,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
