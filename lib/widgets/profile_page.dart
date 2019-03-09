import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wgmanager/globalservice.dart';
import 'package:wgmanager/navigatorhelper.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var profilePageModel = ProfileModel();
  @override
  Widget build(BuildContext context) {
    return ScopedModel<ProfileModel>(
      model: profilePageModel,
      child: ScopedModelDescendant<ProfileModel>(
        builder: (context, child, model) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Profil"),
            ),
            body: ListView(
              children: <Widget>[
                ListTile(
                  title: Text("Abmelden"),
                  onTap: () {
                    model.logout();
                    NavigatorHelper(context).toLogin<dynamic>();
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class ProfileModel extends Model{
  GlobalService _service = GlobalService();

  Future logout() async{
      await _service.logOut();
  }
}