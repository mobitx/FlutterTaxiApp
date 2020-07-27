import 'package:flutter/material.dart';
import 'package:taxiapp/database/database.dart';
import 'package:taxiapp/database/model/payment.dart';
import 'package:taxiapp/database/model/person.dart';
import 'package:taxiapp/screens/payment/new_payment.dart';
import 'package:taxiapp/screens/payment/payment_card.dart';

class PaymentList extends StatefulWidget{
  final Person person;
  final FlutterDatabase database;
  PaymentList({Key key, this.person, this.database}) : super(key: key);

  @override
  _PaymentList createState() => new _PaymentList();

}

class _PaymentList extends State<PaymentList>{

  Future<List<Payment>>_updateList() async{
    List<Payment> paymentList = new List();
    var cashPayment = new Payment(0, 0, "money.png", "Cash", "", 0, 0, 0);

    var paymentDao = widget.database.paymentDao;
    var payments = await paymentDao.findPaymentByUserId(widget.person.id);

    if(payments.length > 0){
      paymentList.clear();
      for(var i=0; i<payments.length; i++){
        paymentList.add(payments[i]);
      }
      paymentList.add(cashPayment);
    }else{
      paymentList.clear();
      paymentList.add(cashPayment);
    }

    return paymentList;
  }

  @override
  void initState(){
    super.initState();
    _updateList();
  }


  @override
  Widget build(BuildContext context) {
    _updateList();
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            new SizedBox(
              height: 500.0,
              child: FutureBuilder<List<Payment>>(
                future: _updateList(),
                builder: (context, snapshot){
                  return ListView(
                    children: snapshot.data.map((payment) => ListTile(
                      leading: CardUtils.getCardIcon(CardUtils.getCardType(payment.cardType)),
                      title: Text(payment.number),
                    )).toList(),
                  );
                },
              ),
            ),
            new GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    new MaterialPageRoute(
                        builder: (context) => new NewPayment(title: "New Payment", person: widget.person,) ));
              },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: new Column(
                    children: [
                      new Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Add payment or redeem gift card",
                          style: TextStyle(color: Colors.lightBlue, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                )
              ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
    );
  }
}