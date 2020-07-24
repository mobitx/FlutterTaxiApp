import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:taxiapp/database/database.dart';
import 'package:taxiapp/database/model/payment.dart';
import 'package:taxiapp/database/model/person.dart';
import 'package:taxiapp/screens/payment/new_payment.dart';
import 'package:taxiapp/screens/payment/payment_card.dart';

class PaymentList extends StatefulWidget{
  final Person person;
  PaymentList({Key key, this.person}) : super(key: key);

  @override
  _PaymentList createState() => new _PaymentList();

}

class _PaymentList extends State<PaymentList>{
  List<Payment> paymentList = [];
  var cashPayment = new Payment(0, 0, "money.png", "Cash", "", 0, 0, 0);

  _updateList() async{
    final database = await $FloorFlutterDatabase
        .databaseBuilder('flutter_database.db')
        .build();

    var paymentDao = database.paymentDao;
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
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      _updateList();
    });
  }

  @override
  void initState(){
    super.initState();
    _updateList();
  }


  @override
  Widget build(BuildContext context) {
    paymentList.clear();
    paymentList.add(cashPayment);
    _updateList();
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            new SizedBox(
              height: 200.0,
              child: new ListView.builder(
                  itemCount: paymentList.length,
                  itemBuilder: (context, index){
                    return ListTile(
                        leading: CardUtils.getCardIcon(CardUtils.getCardType(paymentList[index].cardType)),
                        title: Text(paymentList[index].number),
                    );
                  }
              ),
            ),
            new GestureDetector(
              onTap: (){
                Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new NewPayment(title: "New Payment", person: widget.person,) ));
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