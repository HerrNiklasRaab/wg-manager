import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wgmanager/firebaseauthhelper.dart';
import 'package:wgmanager/models/loginmodel.dart';
import 'package:wgmanager/navigatorhelper.dart';
import 'package:wgmanager/widgets/overlaywidget.dart';

class SignUpPage extends StatefulWidget {
  final Function onGoToLogin;

  SignUpPage({this.onGoToLogin});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var _signUpFormKey = GlobalKey<FormState>();

  var signUpMailTextController = TextEditingController();
  var signUpPasswordTextController = TextEditingController();
  var signUpNameTextController = TextEditingController();

  var mailFocusNode = FocusNode();
  var passwordFocusNode = FocusNode();

  Future _signUp(LoginModel model, BuildContext context) async {
    if (_signUpFormKey.currentState.validate()) {
      OverlayWidget.of(context).showOverlay = true;
      try {
        await model.signUp(signUpMailTextController.text,
            signUpPasswordTextController.text, signUpNameTextController.text);
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
      if(await model.currentUserIsLogedIntoAnyWorkspace()){
        await NavigatorHelper(context).toMain<dynamic>();
      }
      else{
        await NavigatorHelper(context).toWithoutWorkspacePage<dynamic>();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ScopedModelDescendant<LoginModel>(builder: (_, child, model) {
        return Form(
          key: _signUpFormKey,
          child: Container(
            padding: EdgeInsets.only(top: 100.0),            
            child: Column(
              children: <Widget>[
                Divider(
                  height: 50.0,
                  color: Colors.transparent,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Text(
                          "VORNAME NACHNAME",
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
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Bitte gib einen Namen ein.";
                            }
                          },
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(mailFocusNode);
                          },
                          controller: signUpNameTextController,
                          decoration: InputDecoration(
                            hintText: "Max Mustermann",
                            border: InputBorder.none,
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
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Bitte gib eine E-Mail Adresse ein.";
                            }
                          },
                          controller: signUpMailTextController,
                          focusNode: mailFocusNode,
                          onFieldSubmitted: (_) {
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
                          focusNode: passwordFocusNode,
                          onFieldSubmitted: (_) async => await _signUp(model, context),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Bitte gib ein Passwort ein.";
                            }
                          },
                          controller: signUpPasswordTextController,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: FlatButton(
                        child: Text(
                          "Du hast bereits einen Account?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).accentColor,
                            fontSize: 15.0,
                          ),
                          textAlign: TextAlign.end,
                        ),
                        onPressed: () => widget.onGoToLogin(),
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
                            await _signUp(model, context);
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
                                    "REGISTRIEREN",
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
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
