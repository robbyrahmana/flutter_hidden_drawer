import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HiddenDrawer extends StatefulWidget {
  HiddenDrawer(
      {required this.child,
      required this.drawer,
      this.drawerBlurRadius = 12,
      this.drawerWidth = 250,
      this.drawerHeaderHeight = 250,
      Key? key})
      : super(key: key);

  final Widget child;

  /// Hidden drawer widget that will build your drawer,
  /// you should use HiddenDrawerMenu for more user experience
  final Widget drawer;

  final double drawerWidth;

  final double drawerHeaderHeight;

  final double drawerBlurRadius;

  @override
  HiddenDrawerState createState() => HiddenDrawerState();

  static HiddenDrawerState of(BuildContext? context) {
    assert(context != null);
    final HiddenDrawerState? result = context!.findAncestorStateOfType();
    if (result != null) return result;
    throw FlutterError(
        'HiddenDrawer.of() called with a context that does not contain a HiddenDrawer.');
  }
}

class HiddenDrawerState extends State<HiddenDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<double> _leftOffset;
  late Animation<double> _blur;
  bool _drawerState = false;

  bool get isDrawerOpen => _drawerState;
  double get drawerWidth => widget.drawerWidth * 1.2;
  double get drawerHeaderHeight => widget.drawerHeaderHeight;

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
    _leftOffset =
        Tween<double>(begin: 0, end: widget.drawerWidth).animate(_controller)
          ..addListener(() {
            setState(() {});
          });
    _blur = Tween<double>(begin: 0, end: widget.drawerBlurRadius)
        .animate(_controller)
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
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [BoxShadow(blurRadius: _blur.value)],
                      ),
                      child: widget.child,
                    ),
                    isDrawerOpen
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            color: Colors.transparent,
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _move(DragUpdateDetails details) {
    if (Navigator.of(context).canPop()) {
    } else {
      double delta = details.primaryDelta! / MediaQuery.of(context).size.width;
      switch (Directionality.of(context)) {
        case TextDirection.rtl:
          _controller.value -= delta;
          break;
        case TextDirection.ltr:
          _controller.value += delta;
          break;
      }
    }
  }

  void _settle(DragEndDetails details) {
    if (Navigator.of(context).canPop()) {
    } else {
      if (_controller.isDismissed) return;
      if (details.velocity.pixelsPerSecond.dx.abs() >= 365.0) {
        double visualVelocity = details.velocity.pixelsPerSecond.dx /
            MediaQuery.of(context).size.width;
        setState(() {
          _drawerState = visualVelocity > 0;
        });
        switch (Directionality.of(context)) {
          case TextDirection.rtl:
            _controller.fling(velocity: -visualVelocity);
            break;
          case TextDirection.ltr:
            _controller.fling(velocity: visualVelocity);
            break;
        }
      } else if (_controller.value < 0.5) {
        _close();
      } else {
        _open();
      }
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
