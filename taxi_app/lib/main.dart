import 'package:flutter/material.dart';

void main() => runApp(MyApp());

//class MyApp extends StatefulWidget {
//  @override
//  _State createState() => _State();
//}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Login(),
      ),
    );
  }
}

class Login extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
        child: ListView(
          children: <Widget>[
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.indigoAccent,
                shape: BoxShape.rectangle,
              ),
              child: Center(
                child: Image.asset('assets/images/itx.jpg', height: 100),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter username';
                  }
                  return null;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
              ),
            ),
            FlatButton(
              onPressed: (){
                //forgot password screen
              },
              textColor: Colors.blue,
              child: Text('Forgot Password'),
            ),
            Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: Text('LOGIN'),
                  onPressed: (){
                    if (_formKey.currentState.validate()) {
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text('Login Successful')));
                    }
                  },
                )),
            Container(
                child: Row(
                  children: <Widget>[
                    Text('Do not have an account?'),
                    FlatButton(
                      textColor: Colors.blue,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        //signup screen
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
          ],
        )
    );
  }
}