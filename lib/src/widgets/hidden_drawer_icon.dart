import 'package:flutter/material.dart';
import 'package:flutter_hidden_drawer/flutter_hidden_drawer.dart';

class HiddenDrawerIcon extends StatefulWidget {
  @override
  _HiddenDrawerIconState createState() => _HiddenDrawerIconState();
}

class _HiddenDrawerIconState extends State<HiddenDrawerIcon> {
  @override
  Widget build(BuildContext context) {
    final ModalRoute<dynamic> parentRoute = ModalRoute.of(context);
    final bool canPop = parentRoute?.canPop ?? false;

    return canPop
        ? const BackButton()
        : IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              HiddenDrawer.of(context).handleDrawer();
            },
          );
  }
}
