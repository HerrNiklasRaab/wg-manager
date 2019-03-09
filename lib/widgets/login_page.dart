import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wgmanager/firebaseauthhelper.dart';
import 'package:wgmanager/models/loginmodel.dart';
import 'package:wgmanager/navigatorhelper.dart';
import 'package:wgmanager/widgets/overlaywidget.dart';

class LoginPage extends StatefulWidget {
  final Function onGoToSignUp;

  LoginPage({this.onGoToSignUp});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var loginMailTextController = TextEditingController();
  var loginPasswordTextController = TextEditingController();
  var _loginFormKey = GlobalKey<FormState>();
  var passwordFocusNode = FocusNode();

  Future _login(LoginModel model, BuildContext context) async {
    if (_loginFormKey.currentState.validate()) {
      OverlayWidget.of(context).showOverlay = true;
      try {
        await model.login(
            loginMailTextController.text, loginPasswordTextController.text);
      } catch (e) {
        print(e);
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(FirebaseAuthHelper.getFirebaseErrorMessage(e)),
            duration: Duration(seconds: 5),
          ),
        );
        OverlayWidget.of(context).showOverlay = false;
        return;
      } finally {
        OverlayWidget.of(context).showOverlay = false;
      }
      OverlayWidget.of(context).showOverlay = false;
      await NavigatorHelper(context).toMain<dynamic>();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:
          ScopedModelDescendant<LoginModel>(builder: (context, child, model) {
        return Form(
          key: _loginFormKey,
          child: Container(
            padding: EdgeInsets.only(top: 150.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Text(
                          "E-MAIL",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).accentColor,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                      const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: Theme.of(context).accentColor,
                          width: 0.5,
                          style: BorderStyle.solid),
                    ),
                  ),
                  padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          textAlign: TextAlign.left,
                          keyboardType: TextInputType.emailAddress,
                          controller: loginMailTextController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Bitte geben Sie Ihre E-Mail Adresse ein.";
                            }
                          },
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(passwordFocusNode);
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'max@outlook.com',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 24.0,
                  color: Colors.transparent,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Text(
                          "PASSWORT",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).accentColor,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                      const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: Theme.of(context).accentColor,
                          width: 0.5,
                          style: BorderStyle.solid),
                    ),
                  ),
                  padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          obscureText: true,
                          textAlign: TextAlign.left,
                          controller: loginPasswordTextController,
                          focusNode: passwordFocusNode,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Bitte geben Sie Ihr Passwort ein.";
                            }
                          },
                          onFieldSubmitted: (_) async =>
                              await _login(model, context),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '*********',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 0.0,
                  color: Colors.transparent,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: FlatButton(
                          child: Text(
                            "Passwort vergessen?",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).accentColor,
                              fontSize: 15.0,
                            ),
                            textAlign: TextAlign.end,
                          ),
                          onPressed: () {
                            NavigatorHelper(context)
                                .toForgotPasswordPage<dynamic>(
                                    loginMailTextController.text);
                          }),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: FlatButton(
                        child: Text(
                          "Noch keinen Account?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).accentColor,
                            fontSize: 15.0,
                          ),
                          textAlign: TextAlign.end,
                        ),
                        onPressed: () {
                          widget.onGoToSignUp();
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                      const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Theme.of(context).accentColor,
                          onPressed: () async {
                            await _login(model, context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 20.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    "EINLOGGEN",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
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
              ],
            ),
          ),
        );
      }),
    );
  }
}
