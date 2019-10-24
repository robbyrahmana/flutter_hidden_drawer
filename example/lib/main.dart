import 'package:example/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hidden_drawer/flutter_hidden_drawer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (context) => DrawerMenuState(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Hidden Drawer',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Hidden Drawer'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return HiddenDrawer(
      drawerWidth: MediaQuery.of(context).size.width * .4,
      child: Scaffold(
        appBar: AppBar(
          leading: HiddenDrawerIcon(
            mainIcon: Icon(Icons.art_track),
          ),
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text(
                'First Screen',
              ),
              RaisedButton(
                child: Text("Go to next screen"),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => SecondScreen()));
                },
              )
            ],
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
