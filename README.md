# flutter_hidden_drawer

Tooltip function built in for flutter. Please press star in my repo if you like it. Thank you.

## Usage

```dart
  @override
  Widget build(BuildContext context) {
    return HiddenDrawer(
      child: Scaffold(
        appBar: AppBar(
          leading: HiddenDrawerIcon(),
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.display1,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
        drawer: Container(),
      ),
      drawer: HiddenDrawerMenu(),
    );
  }
```

## Example

Please find example in here: [Example](example/lib/main.dart)
