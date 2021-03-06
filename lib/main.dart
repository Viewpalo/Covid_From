import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FormPage(),
    );
  }
}

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  String firstname;
  String lastname;
  int age;
  String home;

  String selectedGender;

  bool _isOption1 = false;
  bool _isOption2 = false;
  bool _isOption3 = false;

  List<String> selectedOptions = [];

  void _onRadioButtonChange(String value) {
    setState(() {
      selectedGender = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Form'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text('Firstname'),
                  TextFormField(
                    onSaved: (value) => setState(() {
                      firstname = value;
                    }),
                  ),
                  Text('Lastname'),
                  TextFormField(
                    onSaved: (value) => setState(() {
                      lastname = value;
                    }),
                  ),

                  /// fill age
                  Text('Age'),
                  TextFormField(
                    keyboardType: TextInputType.number, // input number keyboard
                    onSaved: (value) => setState(() {
                      age = int.parse(value);
                    }),
                  ),
                  // fill Home
                  Text('Home'),
                  TextFormField(
                    onSaved: (value) => setState(() {
                      home = value;
                    }),
                  ),
                  Text('Gender'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Male'),
                      Radio(
                          value: 'Male',
                          groupValue: selectedGender,
                          onChanged: (value) => _onRadioButtonChange(value)),
                      Text('Female'),
                      Radio(
                          value: 'Female',
                          groupValue: selectedGender,
                          onChanged: (value) => _onRadioButtonChange(value)),
                    ],
                  ),
                  Text('Symtomps'),
                  Column(
                    children: [
                      CheckboxListTile(
                        title: Text('??????'),
                        value: _isOption1,
                        onChanged: (val) {
                          setState(() {
                            _isOption1 = !_isOption1;
                            if (_isOption1) {
                              selectedOptions.add('??????');
                            } else {
                              selectedOptions.remove('??????');
                            }
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: Text('??????????????????'),
                        value: _isOption2,
                        onChanged: (val) {
                          setState(() {
                            _isOption2 = !_isOption2;
                            if (_isOption2) {
                              selectedOptions.add('??????????????????');
                            } else {
                              selectedOptions.remove('??????????????????');
                            }
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: Text('???????????????'),
                        value: _isOption3,
                        onChanged: (val) {
                          setState(() {
                            _isOption3 = !_isOption3;
                            if (_isOption3) {
                              selectedOptions.add('???????????????');
                            } else {
                              selectedOptions.remove('???????????????');
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  // ignore: deprecated_member_use
                  RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Page1(
                              firstname: firstname,
                              lastname: lastname,
                              age: age,
                              home: home,
                              gender: selectedGender,
                              symtopms: selectedOptions,
                            ),
                          ),
                        );
                      }
                    },
                    child: Text('Save'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  Page1({
    this.firstname,
    this.lastname,
    this.gender,
    this.symtopms,
    this.age,
    this.home,
  });

  final String firstname;
  final String lastname;
  final String gender;
  final int age;
  final List<String> symtopms;
  final String home;

  final String description = 'Hello World';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
              'https://s3.xopic.de/openwho-public/channels/7fSc4JEBeO9H0P4b8d1Cfq/logo_v1.png',
              width: 200,
              height: 200,
            ),
            covidDetect(symtopms),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Page2(
              description: description,
            ),
          ),
        ),
        child: Text('??????????????????'),
      ),
    );
  }

  Widget covidDetect(List<String> symtopms) {
    if (symtopms.length == 3) {
      return Container(
        width: 300,
        height: 300,
        child: Center(
          child: Text(
              '????????? $firstname $lastname, ???????????? $age ???????????????????????????????????? ?????????????????????: $home'),
        ),
      );
    } else {
      return Container(
        width: 300,
        height: 300,
        child: Center(
          child: Text(
              '????????? $firstname $lastname, ???????????? $age ????????????????????????????????????????????? ?????????????????????: $home'),
        ),
      );
    }
  }
}

class Page2 extends StatelessWidget {
  final String description;

  const Page2({Key key, this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text(description),
            ),
            // ignore: deprecated_member_use
            RaisedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
