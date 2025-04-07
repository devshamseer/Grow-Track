import 'dart:convert';
import 'dart:developer';
import 'package:grow_track/domain/expense/models/expense_card_model/expense_card_model.dart';
import '../../../theme/app_icons.dart';

class CardIconsUtils extends ImageIconPathSet {
  static List<ExpenseCardModel> ExpCardData = [
    ExpenseCardModel(
      imageIcon: '${ImageIconPathSet.basePath}/underground.png',
      titel: 'Train Ticket',
    ),
    ExpenseCardModel(
      imageIcon: '${ImageIconPathSet.basePath}/expenses.png',
      titel: 'Other',
    ),
    ExpenseCardModel(
      imageIcon: '${ImageIconPathSet.basePath}/teth.png',
      titel: 'Dental',
    ),
    ExpenseCardModel(
      imageIcon: '${ImageIconPathSet.basePath}/cutlery.png',
      titel: 'Food',
    ),
    ExpenseCardModel(
      imageIcon: '${ImageIconPathSet.basePath}/shopping-bag.png',
      titel: 'Shopping',
    ),
    ExpenseCardModel(
      imageIcon: '${ImageIconPathSet.basePath}/home.png',
      titel: 'Home',
    ),
    ExpenseCardModel(
      imageIcon: '${ImageIconPathSet.basePath}/medical.png',
      titel: 'Medical',
    ),
    ExpenseCardModel(
      imageIcon: '${ImageIconPathSet.basePath}/gym.png',
      titel: 'Gym',
    ),
    ExpenseCardModel(
      imageIcon: '${ImageIconPathSet.basePath}/petrol-pump.png',
      titel: 'Petrol',
    ),
    ExpenseCardModel(
      imageIcon: '${ImageIconPathSet.basePath}/gas-cylinder.png',
      titel: 'GAS',
    ),
    ExpenseCardModel(
      imageIcon: '${ImageIconPathSet.basePath}/electrical-energy.png',
      titel: 'Electricity Bill',
    ),
    ExpenseCardModel(
      imageIcon: '${ImageIconPathSet.basePath}/sim-card.png',
      titel: 'Phone Recharge',
    ),
    ExpenseCardModel(
      imageIcon: '${ImageIconPathSet.basePath}/popcorn.png',
      titel: 'Entertainment',
    ),
    ExpenseCardModel(
      imageIcon: '${ImageIconPathSet.basePath}/wireless-router.png',
      titel: 'WIFI Bill',
    ),
    ExpenseCardModel(
      imageIcon: '${ImageIconPathSet.basePath}/education.png',
      titel: 'Education',
    ),
    ExpenseCardModel(
      imageIcon: '${ImageIconPathSet.basePath}/tv.png',
      titel: 'OTT',
    ),
    ExpenseCardModel(
      imageIcon: '${ImageIconPathSet.basePath}/cigarette.png',
      titel: 'Cigarette',
    ),
    ExpenseCardModel(
      imageIcon: '${ImageIconPathSet.basePath}/beer.png',
      titel: 'Beer',
    ),
  ];

  static expenseCardData() {
    // Convert the list of ExpenseCardModel to JSON and print it
    List<Map<String, dynamic>> jsonList =
        ExpCardData.map((card) => card.toJson()).toList();
    log(jsonEncode(jsonList)); // Print the encoded JSON string
  }

  // Function to get the imageIcon by title
  static String? getImageIconByTitle({required String title}) {
    // Find the ExpenseCardModel by title
    final card = ExpCardData.firstWhere(
      (card) => card.titel == title,
    );

    // Return the imageIcon or null if not found
    return card?.imageIcon;
  }
}
