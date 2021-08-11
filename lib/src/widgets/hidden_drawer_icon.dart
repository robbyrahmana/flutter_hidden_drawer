import 'package:flutter/material.dart';
import 'package:flutter_hidden_drawer/flutter_hidden_drawer.dart';

class HiddenDrawerIcon extends StatefulWidget {
  HiddenDrawerIcon({this.backIcon, this.mainIcon});

  final Icon? backIcon;
  final Icon? mainIcon;

  @override
  _HiddenDrawerIconState createState() => _HiddenDrawerIconState();
}

class _HiddenDrawerIconState extends State<HiddenDrawerIcon> {
  @override
  Widget build(BuildContext context) {
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    final bool canPop = parentRoute?.canPop ?? false;

    return canPop
        ? widget.backIcon != null
            ? IconButton(
                icon: widget.backIcon!,
                tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                onPressed: () {
                  Navigator.maybePop(context);
                },
              )
            : const BackButton()
        : IconButton(
            icon: widget.mainIcon ?? const Icon(Icons.menu),
            onPressed: () {
              HiddenDrawer.of(context).handleDrawer();
            },
          );
  }
}
