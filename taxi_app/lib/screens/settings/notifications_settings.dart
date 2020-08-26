
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxiapp/database/database.dart';
import 'package:taxiapp/database/model/mobile_notification.dart';
import 'package:taxiapp/database/model/person.dart';

import '../../constants.dart';

class NotificationsSettings extends StatefulWidget{
  final FlutterDatabase database;
  final Person person;
  final MobileNotification mobileNotification;
  final bool isLocation;

  NotificationsSettings({Key key, this.person, this.database, this.isLocation,
    this.mobileNotification}) : super(key: key);

  @override
  _NotificationsSettings createState() => new _NotificationsSettings();
}

enum NotificationType { pushNotification, textMessage, off}

class _NotificationsSettings extends State<NotificationsSettings>{
  NotificationType _type;

  @override
  void initState() {
    super.initState();

    setState(() {
      if(widget.isLocation) {
        if (widget.mobileNotification.isAccountAndTripUpdatesOn) {
          _type = NotificationType.pushNotification;
        } else {
          _type = NotificationType.textMessage;
        }
      }else {
        if (widget.mobileNotification.isDiscountAndNewsOn) {
          _type = NotificationType.pushNotification;
        } else {
          _type = NotificationType.off;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if(widget.isLocation){
      return locationNotification("Account and Trip Updates",
        "Push Notifications (recommended)", "Text Messages",
        NotificationType.pushNotification, NotificationType.textMessage,
      "These notifications are important for your experience and can't "
      "be permanently turned off. If you change these settings, it may "
      "take a few minutes to update.");
    }else{
      return locationNotification("Discounts and News", "Push Notifications",
      "Off", NotificationType.pushNotification, NotificationType.off,
      "When turned off, you may still receive promotional emails from Taxi App. "
          "If you change these settings, it may take a few minutes to update.");
    }
  }

  Widget locationNotification(String heading, String radioValue1,
      String radioValue2, NotificationType type1, NotificationType type2,
      String extraText){
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      appBar: AppBar(
        title: Text(heading),
      ),
      body: Center(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(radioValue1),
                leading: Radio(
                  value: type1,
                  groupValue: _type,
                  onChanged: (NotificationType value){
                    setState(() {
                      _type = value;
                      changeNotification(_type);
                    });
                  },
                ),
              ),
              ListTile(
                title: Text(radioValue2),
                leading: Radio(
                  value: type2,
                  groupValue: _type,
                  onChanged: (NotificationType value){
                    setState(() {
                      _type = value;
                      changeNotification(_type);
                    });
                  },
                ),
              ),
              ListTile(
                subtitle: Text(extraText),
              ),
            ],
          ),
      ),
    );
  }



  Future<void> changeNotification(NotificationType type) async{
    var notificationDao = widget.database.notificationDao;
    var mobileNotification = await notificationDao.findNotificationByUserId(widget.person.id);
    var newMobileNotification;

    if(widget.isLocation){
      if(type == NotificationType.pushNotification){
        widget.mobileNotification.isAccountAndTripUpdatesOn = true;
        newMobileNotification = MobileNotification(mobileNotification.id,
            mobileNotification.userId, true, mobileNotification.isDiscountAndNewsOn);
        await notificationDao.updateNotification(newMobileNotification);
      }else{
        widget.mobileNotification.isAccountAndTripUpdatesOn = false;
        newMobileNotification = MobileNotification(mobileNotification.id,
            mobileNotification.userId, false, mobileNotification.isDiscountAndNewsOn);
      }
    }else{
      if(type == NotificationType.pushNotification){
        widget.mobileNotification.isDiscountAndNewsOn = true;
        newMobileNotification = MobileNotification(mobileNotification.id,
            mobileNotification.userId, mobileNotification.isAccountAndTripUpdatesOn,
            true);
        await notificationDao.updateNotification(newMobileNotification);
      }else{
        widget.mobileNotification.isDiscountAndNewsOn = false;
        newMobileNotification = MobileNotification(mobileNotification.id,
            mobileNotification.userId, mobileNotification.isDiscountAndNewsOn,
            false);
      }
    }

    await notificationDao.updateNotification(newMobileNotification);
  }
}