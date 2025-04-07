

import 'package:intl/intl.dart';

class AmountUtils {

     static String formatAmountT({double? amount}){
     return '${NumberFormat('#,##0.0').format(amount)}';
     }
  static String formatAmount({double? amount}) {
    // Check if amount is null
    if (amount == null) {
      return '';
    }

   if (amount >= 1e18) {
     double quintillionValue = (amount / 1e18).toDouble();
      // Format for quintillions (Qn)
      return '${NumberFormat('#,##0.0').format(quintillionValue)}Qn';
    }else if (amount >= 1e15) {
      // Format for quadrillions (Q), rounding to one decimal point
      return '${NumberFormat('#,##0.0').format(amount / 1e15)}Q';
    } else if (amount >= 1e12) {
      // Format for trillions (T), rounding to one decimal point
      return '${NumberFormat('#,##0.0').format(amount / 1e12)}T';
    } else if (amount >= 1e9) {
      // Format for billions (B), rounding to one decimal point
      return '${NumberFormat('#,##0.0').format(amount / 1e9)}B';
    } else if (amount >= 1e6) {
      // Format for millions (M), rounding to one decimal point
      return '${NumberFormat('#,##0.0').format(amount / 1e6)}M';
    }  else {
   // If the amount has a decimal part, format with two decimal places
  if (amount % 1 != 0) {
    return '${NumberFormat('#,##,##0.00').format(amount)}';
  }

  // If the amount is an integer, format without decimals
  return '${NumberFormat('#,##,##0').format(amount)}';
    }
  }


}
