import 'package:masal_application/anasayfa.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Color(0xFFD12828),
    ));
    return new Scaffold(
      backgroundColor: Color(0xFFD12828),
      body: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "\n\n\n\n\n\nMASAL APPLICATION",
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(height: 48.0),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (input) {
                  if (input.isEmpty) {
                    return "Provide an email";
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Email',
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
                onSaved: (input) => _email = input,
              ),
              SizedBox(height: 8.0),
              TextFormField(
                
                validator: (input) {
                  if (input.length < 6) {
                    return "Longer password please";
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Password',
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
                onSaved: (input) => _password = input,
                obscureText: true,
                autofocus: false,
              ),
              SizedBox(height: 24.0),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  onPressed: signIn,
                  padding: EdgeInsets.all(12),
                  color: Colors.white,
                  child: Text('Login',
                      style: TextStyle(
                          color: Color(0xFFD12828),
                          fontWeight: FontWeight.bold)),
                ),
              )
            ],
          )),
    );
  }

  void signIn() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
   if (connectivityResult == ConnectivityResult.mobile||connectivityResult == ConnectivityResult.wifi) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        AuthResult result = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);

        FirebaseUser user = result.user;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AnaSayfa()));
      } catch (e) {
        showSimpleDialog();
      }
    }
   }
   else{
     
      return showDialog(
      context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("GİRİŞ YAPILAMIYOR!"),
        content: Text("Lütfen internet bağlantınızı kontrol ediniz."),

      );
    }
    );
  }
  }
  Future<Null> showSimpleDialog() async{
    return showDialog(
      context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("OTURUM AÇILAMIYOR!"),
        content: Text("Lütfen geçerli bir e-mail ya da şifre giriniz.Şifrenizi unuttuysanız lütfen bizimle iletişime geçiniz."),
        actions: <Widget>[
          FlatButton(
            child: Text("Tamam"),
            onPressed: () {
              Navigator.of(context).pop();
            },
            )
        ],
      );
    }
    );
  }
}
