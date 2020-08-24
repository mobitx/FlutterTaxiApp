import 'package:flutter/material.dart';
import 'package:taxiapp/database/database.dart';
import 'package:taxiapp/database/model/payment.dart';
import 'package:taxiapp/database/model/person.dart';
import 'package:taxiapp/screens/payment/new_payment.dart';
import 'package:taxiapp/screens/payment/payment_card.dart';

import '../../constants.dart';

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
    var cashPayment = new Payment(0, 0, "money.png", "Cash", "", 0, 0, 0, "Cash");

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
      backgroundColor: kPrimaryLightColor,
      appBar: AppBar(
        title: Text("Payment"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            new SizedBox(
              height: 450.0,
              child: FutureBuilder<List<Payment>>(
                future: _updateList(),
                builder: (context, snapshot){
                  if(snapshot == null || snapshot.data == null || snapshot.hasData == false){
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                        strokeWidth: 5,
                      ),
                    );
                  }else {
                    return ListView(
                      children: snapshot.data.map((payment) =>
                          ListTile(
                            leading: CardUtils.getCardIcon(
                                CardUtils.getCardType(payment.cardType)),
                            title: Text(payment.displayString),
                          )).toList(),
                    );
                  }
                },
              ),
            ),
            new Align(
              alignment: Alignment.bottomLeft,
              child: GestureDetector(
                  onTap: () {
                    _awaitReturnValueFromSecondScreen(context);
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
            ),

          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
    );
  }

  void _awaitReturnValueFromSecondScreen(BuildContext context) async {

    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NewPayment(title: "New Payment", person: widget.person)
        ));

    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      _updateList();
    });
  }
}