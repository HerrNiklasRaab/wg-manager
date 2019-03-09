import 'package:flutter/material.dart';
import 'package:wgmanager/widgets/forgotpassword_page.dart';
import 'package:wgmanager/widgets/main_page.dart';
import 'package:wgmanager/widgets/not_authenticated_page.dart';
import 'package:wgmanager/widgets/profile_page.dart';

class NavigatorHelper {
  BuildContext context;
  NavigatorHelper(this.context);

  Future<T> toLogin<T>() async {
    return await Navigator.of(context)
        .push<T>(MaterialPageRoute(builder: (context) {
      return NotAuthenticatedPage();
    }));
  }

  Future<T> toForgotPasswordPage<T>(String mail) async {
    return await Navigator.of(context)
        .push<T>(MaterialPageRoute(builder: (context) {
      return ForgotPasswordPage(mail: mail);
    }));
  }

  Future<T> toMain<T>() async {
    return await Navigator.of(context)
        .push<T>(MaterialPageRoute(builder: (context) {
      return MainPage();
    }));
  }
  
  Future<T> toProfile<T>() async {
    return await Navigator.of(context)
        .push<T>(MaterialPageRoute(builder: (context) {
      return ProfilePage();
    }));
  }
}
