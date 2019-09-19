import 'package:flutter/material.dart';

class HiddenDrawerMenu extends StatefulWidget {
  @override
  _HiddenDrawerMenuState createState() => _HiddenDrawerMenuState();
}

class _HiddenDrawerMenuState extends State<HiddenDrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
    );
  }
}
