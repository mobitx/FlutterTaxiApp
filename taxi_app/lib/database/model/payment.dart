import 'package:floor/floor.dart';

@entity
class Payment{
  @PrimaryKey(autoGenerate: true)
  int id;
  int userId;
  String cardType;
  String number;
  String name;
  int month;
  int year;
  int cvv;

  Payment(this.id, this.userId, this.cardType, this.number, this.name,
      this.month, this.year, this.cvv);

  @override
  String toString() {
    return 'Payment{id: $id, userId: $userId, cardType: $cardType, name: $name, '
        'number: $number, name:$name, month:$month, year:$year, cvv:$cvv}';
  }


}