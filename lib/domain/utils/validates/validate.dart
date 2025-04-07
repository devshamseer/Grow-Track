import 'package:dartz/dartz.dart';

import '../../failures/main_failures.dart';
import '../../status/model/success_status_model/success_status_model.dart';

class AppValidateCon {
  // Method to validate a single string value
  static bool isValidString(String? value) {
    return value != null &&
        value.trim().isNotEmpty &&
        value.toLowerCase() != "null";
  }

  // Method to validate a number (amount should be greater than 0)
  static bool isValidAmount(String? value) {
    double? amount = double.tryParse(value ?? '');
    return amount != null && amount > 0;
  }

  // Method to validate expense input fields
  static Right<dynamic, SuccessStatusModel> validateExpense({
    required String? expTitel,
    required String? amount,
    required String? title,
    required String? description,
  }) {
    if (!isValidString(expTitel)) {
      return Right(SuccessStatusModel(
          success: false,
          message: "Please select an expense category",
          isvalidated: false));
    }
    if (!isValidAmount(amount)) {
      return Right(SuccessStatusModel(
          success: false,
          message: "Please enter a valid amount",
          isvalidated: false));
    }
    if (!isValidString(title)) {
      return Right(SuccessStatusModel(
          success: false, message: "Please enter a title", isvalidated: false));
    }
    if (!isValidString(description)) {
      return Right(SuccessStatusModel(
          success: false,
          message: "Please enter a description",
          isvalidated: false));
    }
    return Right(SuccessStatusModel(
        success: true, message: "Validation successful", isvalidated: true));
  }
}
