import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wgmanager/globalservice.dart';
import 'package:wgmanager/widgets/main_page.dart';
import 'package:wgmanager/widgets/not_authenticated_page.dart';
import 'package:wgmanager/widgets/overlaywidget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
    final appModel = AppModel();
  @override
  Widget build(BuildContext context) {
    var yellow = Color.fromRGBO(255, 189, 0, 1.0);
    var theme = ThemeData(
        platform: TargetPlatform.android,
        brightness: Brightness.dark,
        primaryTextTheme: TextTheme(
            body1: TextStyle(
          fontSize: 17.0,
        )),
        accentColor: yellow,
        iconTheme: IconThemeData(color: Colors.white),
        buttonColor: yellow,
        toggleableActiveColor: yellow,
        buttonTheme: ButtonThemeData(
            buttonColor: yellow,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0))));
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      builder: (context, child) {
        return OverlayWidget(
          child: child,
        );
      },
      home: ScopedModel<AppModel>(
        model: appModel,
        child:
            ScopedModelDescendant<AppModel>(builder: (context, child, model) {
          Widget page;
          if (model.startupStatus == StartupStatus.signedIn) {
            page = MainPage();
          } else if (model.startupStatus == StartupStatus.notAuthenticated) {
            page = NotAuthenticatedPage();
          } 
          return page;
        }),
      ),
    );
  }
}

class AppModel extends Model {
  GlobalService _globalService = GlobalService();

  StartupStatus _startupStatus = StartupStatus.notAuthenticated;

  StartupStatus get startupStatus => _startupStatus;

  set startupStatus(StartupStatus value) {
    _startupStatus = value;
    notifyListeners();
  }

  AppModel() {
    _globalService.signedInUser().then((user) async {
      startupStatus = user == null
          ? StartupStatus.notAuthenticated
          : StartupStatus.signedIn;
    });
  }
}

enum StartupStatus { notAuthenticated, notFullySignedUp, signedIn, needsUpdate }
