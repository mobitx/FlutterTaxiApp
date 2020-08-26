import 'package:floor/floor.dart';

@entity
class MobileNotification{
  @PrimaryKey(autoGenerate: true)
  int id;
  int userId;
  bool isAccountAndTripUpdatesOn;
  bool isDiscountAndNewsOn;

  MobileNotification(this.id, this.userId, this.isAccountAndTripUpdatesOn, this.isDiscountAndNewsOn);

  @override
  String toString() {
    return 'MobileNotification{id: $id, userId: $userId, isAccountAndTripUpdatesOn: '
        '$isAccountAndTripUpdatesOn, isDiscountAndNewsOn: $isDiscountAndNewsOn}';
  }
}