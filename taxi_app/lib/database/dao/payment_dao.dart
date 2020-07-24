import 'package:floor/floor.dart';
import 'package:taxiapp/database/model/payment.dart';

@dao
abstract class PaymentDAO{
  @Query('SELECT * FROM Payment ORDER BY id ASC')
  Future<List<Payment>> findAllPayments();

  @Query('SELECT * FROM Payment WHERE userId = :userId')
  Future<List<Payment>> findPaymentByUserId(int userId);

  @Query('SELECT * FROM Payment WHERE number = :number')
  Future<Payment> findPaymentByCardNo(String number);

  @insert
  Future<int> insertPerson(Payment payment);
}