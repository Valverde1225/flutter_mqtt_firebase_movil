import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logincloud/googlepage.dart';
import 'package:logincloud/page.dart';
import 'package:logincloud/registerpage.dart';
import 'package:fluttertoast/fluttertoast.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth',
      home: LoginPage(title: 'Firebase Auth'),
    );
  }
}

class LoginPage extends StatefulWidget {
  final String title;


  LoginPage({Key key, this.title}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false, //evitar error bottom overflowed
      body: Form(
        key: _formKey,
        //autovalidate: _autovalidate,
        child: Container(
          //padding: EdgeInsets.all(15.0),
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage('assets/images/curved.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                child: new Card(
                  color: Colors.grey[100],
                  margin: new EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 250.0, bottom: 80.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  elevation: 8.0,
                  child: new Padding(
                    padding: new EdgeInsets.all(25.0),
                    child: new Column(
                      children: <Widget>[
                        new Container(
                          child: new TextFormField(
                            maxLines: 1,
                            controller: _emailController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            decoration: new InputDecoration(
                                labelText: 'Correo Electronico', icon: Icon(Icons.email,color: Colors.green)),
                            onFieldSubmitted: (value) {
                              //FocusScope.of(context).requestFocus(_phoneFocusNode);
                            },

                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Escribe tú correo';

                              }
                            },
                          ),
                        ),
                        new Container(
                          child: new TextFormField(
                            maxLines: 1,
                            controller: _passwordController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            decoration: new InputDecoration(
                              labelText: 'Contraseña' ,
                              icon: Icon(
                                Icons.visibility_off,
                                color: Colors.green,
                              ),
                            ),
                            obscureText: true,
                            onFieldSubmitted: (value) {
                              //FocusScope.of(context).requestFocus(_phoneFocusNode);
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Escribe tú contraseña';
                              }
                            },
                          ),
                        ),
                        new Padding(padding: new EdgeInsets.only(top: 30.0)),
                        new RaisedButton(
                          color: Colors.green,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          padding: new EdgeInsets.all(16.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Text(
                                'Inicio de sesion',
                                style: new TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {

                            }
                            signInWithEmail ();

                          },
                        ),
                        Divider(),
                       /* new RaisedButton(
                          color: Colors.green,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          padding: new EdgeInsets.all(16.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Text(
                                'Ingresa con Google',
                                style: new TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          onPressed: () => _pushPage(context, SignInDemo()),
                        ),*/
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 6,
                              right: 32,
                            ),
                            child: InkWell(
                              onTap: () => _pushPage(context, RegisterPage()),
                              child: Container(
                                child: Text(
                                  'Registro',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signInWithEmail() async {
    // marked async
    FirebaseUser user;
    try {
      user = await _auth.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
    } catch (e) {
      print(e.toString());
    } finally {
      if (user != null) {
        Fluttertoast.showToast(
            msg: "Inicio de sesión exitoso :D",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
        _pushPage(context, Pintar());
      } else {
        // sign in unsuccessful
        Fluttertoast.showToast(
            msg: "Rellena los datos faltantes, o revisa si es tus datos son correctos",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );

        //print('sign in Not');
        // ex: prompt the user to try again
      }
    }
  }
}

void _pushPage(BuildContext context, Widget page) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (_) => page),
  );
}
