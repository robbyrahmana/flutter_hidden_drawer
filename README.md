# flutter_hidden_drawer

Tooltip function built in for flutter. Please press star in my repo if you like it. Thank you.

## Screenshots

![example](example/assets/screenshots/image.png?raw=true "example")

## Usage

```dart
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (context) => DrawerMenuState(),
        ),
      ],
      child: HiddenDrawer(
        child: <Your child, can change with the scaffold>,
        drawer: <Drawer child, consider user HiddenDrawerMenu>,
      ),
    );
  }
```

## Example

Please find example in here: [Example](example/lib/main.dart)
