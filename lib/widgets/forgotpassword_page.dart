import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wgmanager/globalservice.dart';
import 'package:wgmanager/navigatorhelper.dart';

class ForgotPasswordPage extends StatefulWidget {
  final String mail;

  ForgotPasswordPage({this.mail});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  var _forgotPasswordFormKey = GlobalKey<FormState>();

  TextEditingController mailTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    mailTextController.text = widget.mail;
  }

  void _requestNewPassword(BuildContext context, ForgotPasswordModel model) {
    if (_forgotPasswordFormKey.currentState.validate()) {
      model.requestNewPassword(mailTextController.text);
      NavigatorHelper(context).toLogin<dynamic>();
    }
  }

  var forgotPasswordModel = ForgotPasswordModel();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ForgotPasswordModel>(
      model: forgotPasswordModel,
      child: ScopedModelDescendant<ForgotPasswordModel>(
          builder: (context, child, model) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Passwort zurücksetzen"),
          ),
          body: Form(
            key: _forgotPasswordFormKey,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        "Bitte gibt hier deine E-Mail Adresse ein und dir wird ein neues Passwort zugeschickt."),
                    Flexible(
                      child: TextFormField(
                        controller: mailTextController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Bitte gib eine E-Mail Adresse ein.";
                          }
                        },
                        autofocus: true,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'max@outlook.com',
                        ),
                        onFieldSubmitted: (_) =>
                            _requestNewPassword(context, model),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: RaisedButton(
                              child: Text("Absenden"),
                              onPressed: () =>
                                  _requestNewPassword(context, model)),
                        ),
                      ],
                    )
                  ]),
            ),
          ),
        );
      }),
    );
  }
}


class ForgotPasswordModel extends Model{
  GlobalService _service = GlobalService();
  ForgotPasswordModel();

  Future requestNewPassword(String mail) async {
    await _service.resetPassword(email: mail);
  }
}