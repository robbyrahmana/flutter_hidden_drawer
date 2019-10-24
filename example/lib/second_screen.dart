import 'package:flutter/material.dart';
import 'package:flutter_hidden_drawer/flutter_hidden_drawer.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HiddenDrawer(
      drawerWidth: MediaQuery.of(context).size.width * .4,
      child: Scaffold(
        appBar: AppBar(
          leading: HiddenDrawerIcon(
            backIcon: Icon(Icons.arrow_back_ios),
          ),
          title: Text('Second Screen'),
        ),
        body: Center(
          child: Text(
            'Second Screen',
          ),
        ),
      ),
      drawer: HiddenDrawerMenu(
        menu: <DrawerMenu>[
          DrawerMenu(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Menu 1"),
              ),
              onPressed: () {
                print("Menu 1");
              }),
          DrawerMenu(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Menu 2"),
              ),
              onPressed: () {
                print("Menu 2");
              }),
        ],
        header: Text("Header"),
        footer: Text("Footer"),
      ),
    );
  }
}
