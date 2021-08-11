import 'package:flutter/material.dart';

class DrawerMenu {
  DrawerMenu({required this.child, required this.onPressed});

  final Widget child;
  final VoidCallback onPressed;
}
