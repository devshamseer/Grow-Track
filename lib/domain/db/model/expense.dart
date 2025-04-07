import 'package:objectbox/objectbox.dart';

@Entity()
class Expense {
  int id = 0; // Required for ObjectBox
  String uuid;
  String title;
  String description;
  String expTitel; // Expense category
  double amount;
  String createdDate;
  bool sync;

  Expense({
    required this.uuid,
    required this.title,
    required this.description,
    required this.expTitel,
    required this.amount,
    required this.createdDate,
    required this.sync,
  });

  @override
  String toString() {
    return 'Expense(uuid: $uuid, title: $title, description: $description, expTitel: $expTitel, amount: $amount, createdDate: $createdDate, sync: $sync)';
  }
}
