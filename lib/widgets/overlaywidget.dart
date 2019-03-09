import 'package:flutter/material.dart';

class OverlayWidget extends StatefulWidget {
  final Widget child;

  OverlayWidget({this.child});
  _OverlayWidgetState createState() => _OverlayWidgetState();

  static _OverlayWidgetState of(BuildContext context) {
    var state = context.inheritFromWidgetOfExactType(_OverlayInherited)
            as _OverlayInherited;
    return state == null ? null : state.data;
  }
}

class _OverlayWidgetState extends State<OverlayWidget> {
  bool _showOverlay = false;

  bool get showOverlay => _showOverlay;

  set showOverlay(bool showOverlay) {
    setState(() {
      _showOverlay = showOverlay;
    });
  }

  @override
  Widget build(BuildContext context) {
    var stackChildren = List<Widget>();
    stackChildren.add(widget.child);
    if (showOverlay) {
      stackChildren.add(Positioned(
        bottom: 0.0,
        left: 0.0,
        top: 0.0,
        right: 0.0,
        child: Opacity(
          opacity: 0.5,
          child: Container(
            color: Colors.black,
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 5.0,
              ),
            ),
          ),
        ),
      ));
    }

    return _OverlayInherited(data: this, child: Stack(children: stackChildren));
  }
}

class _OverlayInherited extends InheritedWidget {
  final _OverlayWidgetState data;

  _OverlayInherited({Key key, this.data, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(_OverlayInherited old) {
    return true;
  }
}
