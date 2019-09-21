import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hidden_drawer/src/providers/drawer_menu_state.dart';
import 'package:provider/provider.dart';

class HiddenDrawer extends StatefulWidget {
  HiddenDrawer({@required this.child, @required this.drawer, Key key})
      : assert(child != null),
        assert(drawer != null),
        super(key: key);

  final Widget child;

  /// Hidden drawer widget that will build your drawer,
  /// you should use HiddenDrawerMenu for more user experience
  final Widget drawer;

  @override
  HiddenDrawerState createState() => HiddenDrawerState();

  static HiddenDrawerState of(BuildContext context) {
    assert(context != null);
    final HiddenDrawerState result =
        context.ancestorStateOfType(const TypeMatcher<HiddenDrawerState>());
    if (result != null) return result;
    throw FlutterError(
        'HiddenDrawer.of() called with a context that does not contain a HiddenDrawer.');
  }
}

class HiddenDrawerState extends State<HiddenDrawer>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _scale;
  Animation<double> _leftOffset;
  Animation<double> _blur;
  bool _drawerState = false;

  bool get isDrawerOpen => _drawerState;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _scale = Tween<double>(begin: 1, end: .8).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _leftOffset = Tween<double>(begin: 0, end: 250).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _blur = Tween<double>(begin: 0, end: 12).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.drawer,
        Positioned(
          left: _leftOffset.value,
          child: Transform.scale(
            scale: _scale.value,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: GestureDetector(
                onHorizontalDragUpdate: _move,
                onHorizontalDragEnd: _settle,
                dragStartBehavior: DragStartBehavior.start,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(blurRadius: _blur.value)],
                  ),
                  child: widget.child,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _move(DragUpdateDetails details) {
    double delta = details.primaryDelta / MediaQuery.of(context).size.width;
    switch (Directionality.of(context)) {
      case TextDirection.rtl:
        _controller.value -= delta;
        break;
      case TextDirection.ltr:
        _controller.value += delta;
        break;
    }
  }

  void _settle(DragEndDetails details) {
    if (_controller.isDismissed) return;
    if (details.velocity.pixelsPerSecond.dx.abs() >= 365.0) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;
      switch (Directionality.of(context)) {
        case TextDirection.rtl:
          _controller.fling(velocity: -visualVelocity);
          setState(() {
            _drawerState = false;
          });
          break;
        case TextDirection.ltr:
          _controller.fling(velocity: visualVelocity);
          setState(() {
            _drawerState = true;
          });
          break;
      }
    } else if (_controller.value < 0.5) {
      _close();
    } else {
      _open();
    }
  }

  void _open() {
    _controller.fling(velocity: 1.0);
    setState(() {
      _drawerState = true;
    });
  }

  void _close() {
    _controller.fling(velocity: -1.0);
    setState(() {
      _drawerState = false;
    });
  }

  void handleDrawer() {
    if (_drawerState) {
      _close();
    } else {
      _open();
    }
  }
}
