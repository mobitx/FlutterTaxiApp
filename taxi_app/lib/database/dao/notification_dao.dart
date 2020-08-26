import 'package:floor/floor.dart';
import 'package:taxiapp/database/model/mobile_notification.dart';

@dao
abstract class NotificationDao{
  @Query('SELECT * FROM MobileNotification WHERE userId = :userId')
  Future<MobileNotification> findNotificationByUserId(int userId);

  @insert
  Future<int> insertNotification(MobileNotification notification);

  @update
  Future<int> updateNotification(MobileNotification notification);
//flutter packages pub run build_runner build
}