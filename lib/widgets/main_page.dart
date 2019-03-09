import 'package:flutter/material.dart';
import 'package:wgmanager/navigatorhelper.dart';

class MainPage extends StatefulWidget {
  final Widget child;

  MainPage({Key key, this.child}) : super(key: key);

  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
                      icon: Icon(Icons.person),
                      onPressed: () {
                        NavigatorHelper(context).toProfile<dynamic>();
                      }),
        title: Text("WG-Manager"),
      ),
      body: Container(),
    );
  }
}
