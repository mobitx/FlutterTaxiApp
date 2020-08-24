import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taxiapp/components/my_strings.dart';
import 'package:taxiapp/constants.dart';
import 'package:taxiapp/database/database.dart';
import 'package:taxiapp/database/model/payment.dart';
import 'package:taxiapp/database/model/person.dart';
import 'package:taxiapp/screens/payment/input_formatters.dart';
import 'package:taxiapp/screens/payment/payment_card.dart';

class NewPayment extends StatefulWidget {
  NewPayment({Key key, this.title, this.person}) : super(key: key);
  final String title;
  final Person person;

  @override
  _NewPaymentState createState() => new _NewPaymentState();
}

class _NewPaymentState extends State<NewPayment>{
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _formKey = new GlobalKey<FormState>();
  var numberController = new TextEditingController();
  var _paymentCard = new PaymentCard();
  var _autoValidate = false;

  @override
  void initState() {
    super.initState();
    _paymentCard.type = CardType.Others;
    numberController.addListener(_getCardTypeFrmNumber);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: new Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: new Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: new ListView(
                children: <Widget>[
                  new SizedBox(
                    height: 20.0,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      border: const OutlineInputBorder(),
                      filled: true,
                      icon: const Icon(
                        Icons.person,
                        size: 40.0,
                      ),
                      hintText: 'What name is written on card?',
                      labelText: 'Card Name',
                    ),
                    onSaved: (String value) {
                      _paymentCard.name = value;
                    },
                    keyboardType: TextInputType.text,
                    validator: (String value) =>
                    value.isEmpty ? Strings.fieldReq : null,
                  ),
                  new SizedBox(
                    height: 30.0,
                  ),
                  new TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      new LengthLimitingTextInputFormatter(19),
                      new CardNumberInputFormatter()
                    ],
                    controller: numberController,
                    decoration: new InputDecoration(
                      border: const OutlineInputBorder(),
                      filled: true,
                      icon: CardUtils.getCardIcon(_paymentCard.type),
                      hintText: 'What number is written on card?',
                      labelText: 'Number',
                    ),
                    onSaved: (String value) {
                      _paymentCard.number = CardUtils.getCleanedNumber(value);
                    },
                    validator: CardUtils.validateCardNum,
                  ),
                  new SizedBox(
                    height: 30.0,
                  ),
                  new TextFormField(
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      new LengthLimitingTextInputFormatter(4),
                    ],
                    decoration: new InputDecoration(
                      border: const OutlineInputBorder(),
                      filled: true,
                      icon: new Image.asset(
                        'assets/images/card_cvv.png',
                        width: 40.0,
                        color: Colors.grey[600],
                      ),
                      hintText: 'Number behind the card',
                      labelText: 'CVV',
                    ),
                    validator: CardUtils.validateCVV,
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      _paymentCard.cvv = int.parse(value);
                    },
                  ),
                  new SizedBox(
                    height: 30.0,
                  ),
                  new TextFormField(
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      new LengthLimitingTextInputFormatter(4),
                      new CardMonthInputFormatter()
                    ],
                    decoration: new InputDecoration(
                      border: const OutlineInputBorder(),
                      filled: true,
                      icon: new Image.asset(
                        'assets/images/calender.png',
                        width: 40.0,
                        color: Colors.grey[600],
                      ),
                      hintText: 'MM/YY',
                      labelText: 'Expiry Date',
                    ),
                    validator: CardUtils.validateDate,
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      List<int> expiryDate = CardUtils.getExpiryDate(value);
                      _paymentCard.month = expiryDate[0];
                      _paymentCard.year = expiryDate[1];
                    },
                  ),
                  new SizedBox(
                    height: 50.0,
                  ),
                  new Container(
                    alignment: Alignment.center,
                    child: _getPayButton(),
                  )
                ],
              )),
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    numberController.removeListener(_getCardTypeFrmNumber);
    numberController.dispose();
    super.dispose();
  }

  void _getCardTypeFrmNumber() {
    String input = CardUtils.getCleanedNumber(numberController.text);
    CardType cardType = CardUtils.getCardTypeFrmNumber(input);
    setState(() {
      this._paymentCard.type = cardType;
    });
  }

  void _validateInputs() {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      setState(() {
        _autoValidate = true; // Start validating on every change.
      });
      _showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      insertPaymentToDatabase();
      // Encrypt and send send payment details to payment gateway
    }
  }

  Future<void> insertPaymentToDatabase() async{
    WidgetsFlutterBinding.ensureInitialized();

    final database = await $FloorFlutterDatabase
        .databaseBuilder('flutter_database.db')
        .build();

    var paymentDao = database.paymentDao;
    var cardAvailable = await paymentDao.findPaymentByCardNo(_paymentCard.number);
    var id = 0;

    if(cardAvailable == null){
      var payments = await paymentDao.findAllPayments();
      if(payments.length > 0 ) {
        id = payments[payments.length-1].id + 1;
      }

      var length = _paymentCard.number.length;

      var dispayString = "**** ${_paymentCard.number.toString()[length-4]+_paymentCard.number.toString()[length-3]+_paymentCard.number.toString()[length-2]+_paymentCard.number.toString()[length-1]}";

      var payment = Payment(id, widget.person.id, getCardType(_paymentCard.type), _paymentCard.number,
          _paymentCard.name, _paymentCard.month, _paymentCard.year, _paymentCard.cvv, dispayString);
      await paymentDao.insertPerson(payment);

      _showInSnackBar('Payment method successfully saved!');

      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      } else {
        SystemNavigator.pop();
      }
    }else{
      _showInSnackBar('Payment method already available!');
    }
  }

  Widget _getPayButton() {
    if (Platform.isIOS) {
      return new CupertinoButton(
        onPressed: _validateInputs,
        color: CupertinoColors.activeBlue,
        child: const Text(
          Strings.pay,
          style: const TextStyle(fontSize: 17.0),
        ),
      );
    } else {
      return new RaisedButton(
        onPressed: _validateInputs,
        color: kPrimaryColor,
        splashColor: kPrimaryLightColor,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(const Radius.circular(100.0)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 80.0),
        textColor: Colors.white,
        child: new Text(
          Strings.pay.toUpperCase(),
          style: const TextStyle(fontSize: 17.0),
        ),
      );
    }
  }

  void _showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value),
      duration: new Duration(seconds: 3),
    ));
  }

  String getCardType(CardType cardType){
    String name = "";
    switch (cardType) {
      case CardType.Master:
        name = 'mastercard.png';
        break;
      case CardType.Visa:
        name = 'visa.png';
        break;
      case CardType.Verve:
        name = 'verve.png';
        break;
      case CardType.AmericanExpress:
        name = 'american_express.png';
        break;
      case CardType.Discover:
        name = 'discover.png';
        break;
      case CardType.DinersClub:
        name = 'dinners_club.png';
        break;
      case CardType.Jcb:
        name = 'jcb.png';
        break;
      case CardType.Cash:
        name = 'money.png';
        break;
      case CardType.Others:
        name = 'others';
        break;
      case CardType.Invalid:
        name = 'invalid';
        break;
    }
    return name;
  }
}