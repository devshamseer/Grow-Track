import 'dart:developer';

import 'package:grow_track/domain/db/model/expense.dart';
import 'package:grow_track/domain/expense/models/expense_home_page_model/expense_home_page_model.dart';
import 'package:grow_track/main.dart';
import 'package:injectable/injectable.dart';
import 'package:objectbox/objectbox.dart';
import '../../objectbox.g.dart';

class ObjectBox {
  late final Store store;
  static late final Box<Expense> expenseBox;

  ObjectBox._create(this.store) {
    expenseBox = store.box<Expense>();
  }

  static Future<ObjectBox> create() async {
    final store = await openStore();
    return ObjectBox._create(store);
  }

  /// Add expense
  int addExpense(Expense expense) {
    return expenseBox.put(expense);
  }

  /// Get all expenses
  List<Expense> getAllExpenses() {
    return expenseBox.getAll();
  }

  // ➤ **Filter by Category**
  List<Expense> getExpensesByCategory({String? category}) {
    return expenseBox
      .query(Expense_.expTitel.equals(category!))
      .order(Expense_.createdDate, flags: 1) // Assuming you have a date field
      .build()
      .find();
  }

  // ➤ **Get Total Expense Amount**
  double getTotalExpenseAmount() {
    return expenseBox
        .getAll()
        .map((e) => e.amount)
        .fold(0.0, (sum, amount) => sum + amount);
  }

  // ➤ **Get Total Amount by Category**
  double getTotalAmountByCategory({required String category}) {
    return expenseBox
        .query(Expense_.expTitel.equals(category))
        .build()
        .find()
        .map((e) => e.amount)
        .fold(0.0, (sum, amount) => sum + amount);
  }

  // ➤ **Update Expense**
  void updateExpense(Expense expense) {
    expenseBox.put(expense);
  }

  // ➤ **Update Expense by UUID**
  Future<void> updateExpenseByUuid(String uuid, Expense updatedExpense) async {
    // Find the expense with the given uuid
    final expense = expenseBox.query(Expense_.uuid.equals(uuid)).build().findFirst();

    if (expense != null) {
      // Update the fields of the expense
      expense.title = updatedExpense.title;
      expense.description = updatedExpense.description;
      expense.expTitel = updatedExpense.expTitel;
      expense.amount = updatedExpense.amount;
      expense.createdDate = updatedExpense.createdDate;
      expense.sync = updatedExpense.sync;

      // Save the updated expense back to the database
      expenseBox.put(expense);
    } else {
      log('Expense with UUID $uuid not found');
    }
  }

  // ➤ **Delete Expense by UUID**
  Future<void> deleteExpenseByUuid(String uuid) async {
    // Find the expense with the given uuid
    final expense = expenseBox.query(Expense_.uuid.equals(uuid)).build().findFirst();

    if (expense != null) {
      // Remove the expense from the database
      expenseBox.remove(expense.id);
    } else {
      log('Expense with UUID $uuid not found');
    }
  }



  // ➤ **Delete Expense**
  void deleteExpense(int id) {
    expenseBox.remove(id);
  }

  // ➤ **Delete All Expenses**
  void deleteAllExpenses() {
    expenseBox.removeAll();
  }

  // ➤ **Group Expenses by Category and Calculate Total** and return a list of ExpenseHomePageModel
List<ExpenseHomePageModel> getGroupedExpensesWithTotal() {
  // Get all expenses
  List<Expense> allExpenses = expenseBox.getAll();

  // Group expenses by 'expTitel'
  Map<String, List<Expense>> groupedExpenses = {};
  for (var expense in allExpenses) {
    if (!groupedExpenses.containsKey(expense.expTitel)) {
      groupedExpenses[expense.expTitel] = [];
    }
    groupedExpenses[expense.expTitel]!.add(expense);
  }

  // Create a result list with category and total amount
  List<ExpenseHomePageModel> groupedExpensesWithTotal = [];
  groupedExpenses.forEach((category, expenses) {
    double totalAmount = expenses.fold(
        0.0, // Start with a double value
        (sum, expense) =>
            sum + (expense.amount ?? 0.0) // Handle nullable double with default value
    );
    
    groupedExpensesWithTotal.add(
      ExpenseHomePageModel(
        expTitel: category,
        totalAmount: totalAmount,
      ),
    );
  });

  return groupedExpensesWithTotal;
}

}

// import 'package:grow_track/domain/db/model/expense.dart';
// import 'package:grow_track/main.dart';
// import 'package:injectable/injectable.dart';
// import 'package:objectbox/objectbox.dart';
// import '../../objectbox.g.dart';

// class ObjectBox {
//   static late final Store store;
//   static late final Box<Expense> expenseBox;

//   // Private constructor to prevent instantiation (static class).
//   ObjectBox._();

//   // Static method to create the store and initialize static fields
//   static Future create() async {
//     store = await openStore();  // Open the ObjectBox store
//     expenseBox = store.box<Expense>();  // Initialize the expenseBox
//   }

//   // ➤ **Add expense**
//   static  addExpense(Expense expense) {
//     return expenseBox.put(expense);
//   }

//   // ➤ **Get all expenses**
//   static List<Expense> getAllExpenses() {
//     return expenseBox.getAll();
//   }

//   // ➤ **Filter by Category**
//   static List<Expense> getExpensesByCategory({String? category}) {
//     return expenseBox
//         .query(Expense_.expTitel.equals(category!))
//         .build()
//         .find();
//   }

//   // ➤ **Get Total Expense Amount**
//   static double getTotalExpenseAmount() {
//     return expenseBox
//         .getAll()
//         .map((e) => e.amount)
//         .fold(0.0, (sum, amount) => sum + amount);
//   }

//   // ➤ **Get Total Amount by Category**
//   static double getTotalAmountByCategory(String category) {
//     return expenseBox
//         .query(Expense_.expTitel.equals(category))
//         .build()
//         .find()
//         .map((e) => e.amount)
//         .fold(0.0, (sum, amount) => sum + amount);
//   }

//   // ➤ **Update Expense**
//   static void updateExpense(Expense expense) {
//     expenseBox.put(expense);
//   }

//   // ➤ **Delete Expense**
//   static void deleteExpense(int id) {
//     expenseBox.remove(id);
//   }

//   // ➤ **Delete All Expenses**
//   static void deleteAllExpenses() {
//     expenseBox.removeAll();
//   }
// }
