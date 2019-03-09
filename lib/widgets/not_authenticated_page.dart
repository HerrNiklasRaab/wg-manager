import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wgmanager/models/loginmodel.dart';
import 'package:wgmanager/widgets/login_page.dart';
import 'package:wgmanager/widgets/signup_page.dart';

class NotAuthenticatedPage extends StatefulWidget {
  @override
  _NotAuthenticatedPageState createState() => _NotAuthenticatedPageState();
}

class _NotAuthenticatedPageState extends State<NotAuthenticatedPage> {
  SnackBar snackBar;
  Widget homePage() {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.1), BlendMode.dstATop),
            image: AssetImage('assets/images/login-background2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 150.0),
              child: Text(
                "WG-Manager",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin:
                  const EdgeInsets.only(left: 30.0, right: 30.0, top: 120.0),
              alignment: Alignment.center,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: OutlineButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      onPressed: () => gotoSignup(),
                      borderSide:
                          BorderSide(color: Theme.of(context).accentColor),
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
                                    color: Theme.of(context).accentColor,
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
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
              alignment: Alignment.center,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      color: Theme.of(context).accentColor,
                      onPressed: () => gotoLogin(),
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
                                "ANMELDEN",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
  }

  void gotoLogin() {
    _controller.animateToPage(
      0,
      duration: Duration(milliseconds: 800),
      curve: Curves.ease,
    );
  }

  void gotoSignup() {
    _controller.animateToPage(
      2,
      duration: Duration(milliseconds: 800),
      curve: Curves.ease,
    );
  }

  PageController _controller =
      PageController(initialPage: 1, viewportFraction: 1.0);

  var loginModel = LoginModel();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: ScopedModel<LoginModel>(
          model: loginModel,
          child: ScopedModelDescendant<LoginModel>(
              builder: (context, child, model) {
            return Scaffold(
              body: PageView(
                controller: _controller,
                physics: AlwaysScrollableScrollPhysics(),
                children: <Widget>[
                  LoginPage(onGoToSignUp: () => gotoSignup()),
                  homePage(),
                  SignUpPage(onGoToLogin: () => gotoLogin()),
                ],
                scrollDirection: Axis.horizontal,
              ),
            );
          })),
    );
  }
}