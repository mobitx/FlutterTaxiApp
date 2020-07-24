import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:taxiapp/database/dao/payment_dao.dart';
import 'package:taxiapp/database/model/payment.dart';

import 'dao/person_dao.dart';
import 'model/person.dart';

part 'database.g.dart';

//flutter packages pub run build_runner build
@Database(version: 1, entities: [Person, Payment])
abstract class FlutterDatabase extends FloorDatabase {
  PersonDao get personDao;
  PaymentDAO get paymentDao;
}