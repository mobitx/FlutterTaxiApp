import 'package:flutter/material.dart';
import 'package:country_pickers/country.dart';
import 'package:flutter/cupertino.dart';
import 'package:country_pickers/country_pickers.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MyCustomFormState(),
      ),
    );
  }
}

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SignUp(),
      ),
    );
  }
}

class MyCustomFormState extends StatefulWidget {
  @override
  Login createState() {
    return Login();
  }
}

//class MyCustomFormState2 extends StatefulWidget {
//  @override
//  SignUp createState() {
//    return SignUp();
//  }
//}

class Login extends State<MyCustomFormState> {
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyApp2()),
                          );
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

//class SignUp extends State<MyCustomFormState2> {
//  // Create a global key that uniquely identifies the Form widget
//  // and allows validation of the form.
//  //
//  // Note: This is a GlobalKey<FormState>,
//  // not a GlobalKey<MyCustomFormState>.
//  final _formKey = GlobalKey<FormState>();
//
//  @override
//  Widget build(BuildContext context) {
//    // Build a Form widget using the _formKey created above.
//    return Form(
//      key: _formKey,
//      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: <Widget>[
//          TextFormField(
//            validator: (value) {
//              if (value.isEmpty) {
//                return 'Please enter some text';
//              }
//              return null;
//            },
//          ),
//          Padding(
//            padding: const EdgeInsets.symmetric(vertical: 16.0),
//            child: RaisedButton(
//              onPressed: () {
//                // Validate returns true if the form is valid, or false
//                // otherwise.
//                if (_formKey.currentState.validate()) {
//                  // If the form is valid, display a Snackbar.
//                  Scaffold.of(context)
//                      .showSnackBar(SnackBar(content: Text('Processing Data')));
//                }
//              },
//              child: Text('Submit'),
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//}

//
//void main() => runApp(MyApp());
//
class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Country Pickers Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => DemoPage(),
      },
    );
  }
}

class DemoPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<DemoPage> {
  Country _selectedDialogCountry =
  CountryPickerUtils.getCountryByPhoneCode('94');

  Country _selectedFilteredDialogCountry =
  CountryPickerUtils.getCountryByPhoneCode('94');

  Country _selectedCupertinoCountry =
  CountryPickerUtils.getCountryByIsoCode('LK');

  Country _selectedFilteredCupertinoCountry =
  CountryPickerUtils.getCountryByIsoCode('LK');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country Pickers Demo'),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('CountryPickerDropdown (SOLO)'),
                _buildCountryPickerDropdownSoloExpanded(),
                //ListTile(title: _buildCountryPickerDropdown(longerText: true)),
              ],
            ),
          ),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('CountryPickerDropdown (selectedItemBuilder)'),
                _buildCountryPickerDropdown(hasSelectedItemBuilder: true),
                //ListTile(title: _buildCountryPickerDropdown(longerText: true)),
              ],
            ),
          ),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('CountryPickerDropdown (filtered)'),
                ListTile(title: _buildCountryPickerDropdown(filtered: true)),
              ],
            ),
          ),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('CountryPickerDropdown (sorted by isoCode)'),
                ListTile(
                    title: _buildCountryPickerDropdown(sortedByIsoCode: true)),
              ],
            ),
          ),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("CountryPickerDropdown (has priorityList['GB,'CN'])"),
                ListTile(
                    title: _buildCountryPickerDropdown(hasPriorityList: true)),
              ],
            ),
          ),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("CountryPickerDialog (has priorityList['TR,'US'])"),
                ListTile(
                  onTap: _openCountryPickerDialog,
                  title: _buildDialogItem(_selectedDialogCountry),
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('CountryPickerDialog (filtered)'),
                ListTile(
                  onTap: _openFilteredCountryPickerDialog,
                  title: _buildDialogItem(_selectedFilteredDialogCountry),
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("CountryPickerCupertino (has priorityList['TR,'US'])"),
                ListTile(
                  title: _buildCupertinoSelectedItem(_selectedCupertinoCountry),
                  onTap: _openCupertinoCountryPicker,
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('CountryPickerCupertino (filtered)'),
                ListTile(
                  title: _buildCupertinoSelectedItem(
                      _selectedFilteredCupertinoCountry),
                  onTap: _openFilteredCupertinoCountryPicker,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildCountryPickerDropdownSoloExpanded() {
    return CountryPickerDropdown(
      underline: Container(
        height: 2,
        color: Colors.red,
      ),
      //show'em (the text fields) you're in charge now
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      //if you want your dropdown button's selected item UI to be different
      //than itemBuilder's(dropdown menu item UI), then provide this selectedItemBuilder.
      onValuePicked: (Country country) {
        print("${country.name}");
      },
      itemBuilder: (Country country) {
        return Row(
          children: <Widget>[
            SizedBox(width: 8.0),
            CountryPickerUtils.getDefaultFlagImage(country),
            SizedBox(width: 8.0),
            Expanded(child: Text(country.name)),
          ],
        );
      },
      itemHeight: null,
      isExpanded: true,
      //initialValue: 'TR',
      icon: Icon(Icons.arrow_downward),
    );
  }

  _buildCountryPickerDropdown(
      {bool filtered = false,
        bool sortedByIsoCode = false,
        bool hasPriorityList = false,
        bool hasSelectedItemBuilder = false}) {
    double dropdownButtonWidth = MediaQuery.of(context).size.width * 0.5;
    //respect dropdown button icon size
    double dropdownItemWidth = dropdownButtonWidth - 30;
    double dropdownSelectedItemWidth = dropdownButtonWidth - 30;
    return Row(
      children: <Widget>[
        SizedBox(
          width: dropdownButtonWidth,
          child: CountryPickerDropdown(
            /* underline: Container(
              height: 2,
              color: Colors.red,
            ),*/
            //show'em (the text fields) you're in charge now
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            //if you have menu items of varying size, itemHeight being null respects
            //that, IntrinsicHeight under the hood ;).
            itemHeight: null,
            //itemHeight being null and isDense being true doesn't play along
            //well together. One is trying to limit size and other is saying
            //limit is the sky, therefore conflicts.
            //false is default but still keep that in mind.
            isDense: false,
            //if you want your dropdown button's selected item UI to be different
            //than itemBuilder's(dropdown menu item UI), then provide this selectedItemBuilder.
            selectedItemBuilder: hasSelectedItemBuilder == true
                ? (Country country) => _buildDropdownSelectedItemBuilder(
                country, dropdownSelectedItemWidth)
                : null,
            //initialValue: 'AR',
            itemBuilder: (Country country) => hasSelectedItemBuilder == true
                ? _buildDropdownItemWithLongText(country, dropdownItemWidth)
                : _buildDropdownItem(country, dropdownItemWidth),
            initialValue: 'LK',
            itemFilter: filtered
                ? (c) => ['AR', 'DE', 'GB', 'CN', 'LK'].contains(c.isoCode)
                : null,
            //priorityList is shown at the beginning of list
            priorityList: hasPriorityList
                ? [
              CountryPickerUtils.getCountryByIsoCode('LK')
            ]
                : null,
            sortComparator: sortedByIsoCode
                ? (Country a, Country b) => a.isoCode.compareTo(b.isoCode)
                : null,
            onValuePicked: (Country country) {
              print("${country.name}");
            },
          ),
        ),
        SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: "Phone",
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
            keyboardType: TextInputType.number,
          ),
        )
      ],
    );
  }

  Widget _buildDropdownItem(Country country, double dropdownItemWidth) =>
      SizedBox(
        width: dropdownItemWidth,
        child: Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            SizedBox(
              width: 8.0,
            ),
            Expanded(child: Text("+${country.phoneCode}(${country.isoCode})")),
          ],
        ),
      );

  Widget _buildDropdownItemWithLongText(
      Country country, double dropdownItemWidth) =>
      SizedBox(
        width: dropdownItemWidth,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              CountryPickerUtils.getDefaultFlagImage(country),
              SizedBox(
                width: 8.0,
              ),
              Expanded(child: Text("${country.name}")),
            ],
          ),
        ),
      );

  Widget _buildDropdownSelectedItemBuilder(
      Country country, double dropdownItemWidth) =>
      SizedBox(
          width: dropdownItemWidth,
          child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  CountryPickerUtils.getDefaultFlagImage(country),
                  SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                      child: Text(
                        '${country.name}',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      )),
                ],
              )));

  Widget _buildDialogItem(Country country) => Row(
    children: <Widget>[
      CountryPickerUtils.getDefaultFlagImage(country),
      SizedBox(width: 8.0),
      Text("+${country.phoneCode}"),
      SizedBox(width: 8.0),
      Flexible(child: Text(country.name))
    ],
  );

  void _openCountryPickerDialog() => showDialog(
    context: context,
    builder: (context) => Theme(
      data: Theme.of(context).copyWith(primaryColor: Colors.pink),
      child: CountryPickerDialog(
        titlePadding: EdgeInsets.all(8.0),
        searchCursorColor: Colors.pinkAccent,
        searchInputDecoration: InputDecoration(hintText: 'Search...'),
        isSearchable: true,
        title: Text('Select your phone code'),
        onValuePicked: (Country country) =>
            setState(() => _selectedDialogCountry = country),
        itemBuilder: _buildDialogItem,
        priorityList: [
          CountryPickerUtils.getCountryByIsoCode('LK')
        ],
      ),
    ),
  );

  void _openFilteredCountryPickerDialog() => showDialog(
    context: context,
    builder: (context) => Theme(
        data: Theme.of(context).copyWith(primaryColor: Colors.pink),
        child: CountryPickerDialog(
            titlePadding: EdgeInsets.all(8.0),
            searchCursorColor: Colors.pinkAccent,
            searchInputDecoration: InputDecoration(hintText: 'Search...'),
            isSearchable: true,
            title: Text('Select your phone code'),
            onValuePicked: (Country country) =>
                setState(() => _selectedFilteredDialogCountry = country),
            itemFilter: (c) => ['AR', 'DE', 'GB', 'CN', 'LK'].contains(c.isoCode),
            itemBuilder: _buildDialogItem)),
  );

  void _openCupertinoCountryPicker() => showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CountryPickerCupertino(
          backgroundColor: Colors.black,
          itemBuilder: _buildCupertinoItem,
          pickerSheetHeight: 300.0,
          pickerItemHeight: 75,
          initialCountry: _selectedCupertinoCountry,
          onValuePicked: (Country country) =>
              setState(() => _selectedCupertinoCountry = country),
          priorityList: [
            CountryPickerUtils.getCountryByIsoCode('LK')
          ],
        );
      });

  void _openFilteredCupertinoCountryPicker() => showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CountryPickerCupertino(
          backgroundColor: Colors.white,
          pickerSheetHeight: 200.0,
          initialCountry: _selectedFilteredCupertinoCountry,
          onValuePicked: (Country country) =>
              setState(() => _selectedFilteredCupertinoCountry = country),
          itemFilter: (c) => ['AR', 'DE', 'GB', 'CN', 'LK'].contains(c.isoCode),
        );
      });

  Widget _buildCupertinoSelectedItem(Country country) {
    return Row(
      children: <Widget>[
        CountryPickerUtils.getDefaultFlagImage(country),
        SizedBox(width: 8.0),
        Text("+${country.phoneCode}"),
        SizedBox(width: 8.0),
        Flexible(child: Text(country.name))
      ],
    );
  }

  Widget _buildCupertinoItem(Country country) {
    return DefaultTextStyle(
      style: const TextStyle(
        color: CupertinoColors.white,
        fontSize: 16.0,
      ),
      child: Row(
        children: <Widget>[
          SizedBox(width: 8.0),
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(width: 8.0),
          Text("+${country.phoneCode}"),
          SizedBox(width: 8.0),
          Flexible(child: Text(country.name))
        ],
      ),
    );
  }
}