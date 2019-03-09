

import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wgmanager/globalservice.dart';

class LoginModel extends Model {
  GlobalService service = GlobalService();

  String _mailValidationMessage;

  String get mailValidationMessage => _mailValidationMessage;

  set mailValidationMessage(String value) {
    _mailValidationMessage = value;
    notifyListeners();
  }

  String _passwordValidationMessage;

  String get passwordValidationMessage => _passwordValidationMessage;

  set passwordValidationMessage(String value) {
    _passwordValidationMessage = value;
    notifyListeners();
  }

  Future<FirebaseUser> login(String mail, String password) async {
    return await service.login(mail, password);
  }

  Future<FirebaseUser> signUp(String mail, String password, String name) async {
    return await service.signup(mail, password, name);
  }

  Future<FirebaseUser> currentUser() async {
    return await service.signedInUser();
  }
}
