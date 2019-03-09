import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wgmanager/globalservice.dart';

class WithoutWorkspacePage extends StatefulWidget {
  final Widget child;

  WithoutWorkspacePage({Key key, this.child}) : super(key: key);

  _WithoutWorkspacePageState createState() => _WithoutWorkspacePageState();
}

class _WithoutWorkspacePageState extends State<WithoutWorkspacePage> {
  TextEditingController joinCodeTextController;
  TextEditingController createCodeTextController;
  var _joinCodeFormKey = GlobalKey<FormState>();
  var _createCodeKey = GlobalKey<FormState>();

  var model = WorkspaceModel();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<WorkspaceModel>(
      model: model,
      child: ScopedModelDescendant<WorkspaceModel>(
          builder: (context, child, model) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 100.0),
              child: Column(
                children: <Widget>[
                  Text("Bist du schon eingezogen?"),
                  Text("Bitte hier Code eingeben:"),
                  Form(
                    key: _joinCodeFormKey,
                    child: TextFormField(
                        textAlign: TextAlign.left,
                        controller: joinCodeTextController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Bitte Workspacecode eingeben.";
                          }
                        },
                        onFieldSubmitted: (String s) {
                          _loginToSpace(model, context);
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'hyprspace',
                          hintStyle: TextStyle(color: Colors.grey),
                        )),
                  ),
                  RaisedButton(
                    child: Text("Beitreten"),
                    onPressed: () => _loginToSpace(model, context),
                  ),
                  Text("Gründest du eine WG?"),
                  Text("Dann hier den neuen Code des Workspaces eingeben:"),
                  Form(
                    key: _createCodeKey,
                    child: TextFormField(
                        textAlign: TextAlign.left,
                        controller: createCodeTextController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Bitte neuen Workspacecode eingeben.";
                          }
                        },
                        onFieldSubmitted: (String s) {
                          _createSpace(model, context);
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'hyprspace',
                          hintStyle: TextStyle(color: Colors.grey),
                        )),
                  ),
                  RaisedButton(
                    child: Text("Erstellen"),
                    onPressed: () => _createSpace(model, context),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  void _loginToSpace(WorkspaceModel model, BuildContext context) {
    if (_joinCodeFormKey.currentState.validate()) {
      model.join(joinCodeTextController.text);
    }
  }

  void _createSpace(WorkspaceModel model, BuildContext context) {
    if (_createCodeKey.currentState.validate()) {
      model.join(createCodeTextController.text);
    }
  }
}

class WorkspaceModel extends Model {
  GlobalService _globalService = GlobalService();

  void join(String code) {
    _globalService.joinWorkspace(code);
  }

  void create(String code) {
    _globalService.createWorkspace(code);
  }
}
