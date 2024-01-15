// ignore_for_file: unused_local_variable
// #docregion ShakeCurve

// #enddocregion ShakeCurve
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const HelloWorldApp());

class KeyboardMonitor extends StatefulWidget {
  const KeyboardMonitor({
    super.key,
    required this.onKeyPress,
    required this.child,
  });

  final Widget child;
  final Function(String?) onKeyPress;

  @override
  State<KeyboardMonitor> createState() => _KeyboardMonitorState();
}

class _KeyboardMonitorState extends State<KeyboardMonitor> {
  @override
  void initState() {
    super.initState();
    RawKeyboard.instance.addListener(_keyboardCallback);
  }

  @override
  void dispose() {
    RawKeyboard.instance.removeListener(_keyboardCallback);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _keyboardCallback(RawKeyEvent keyEvent) {
    if (keyEvent is! RawKeyDownEvent) return;

    widget.onKeyPress(keyEvent.logicalKey.toString());
  }
}

class KeyPressComponent extends StatefulWidget {
  const KeyPressComponent({super.key});

  @override
  State<KeyPressComponent> createState() => _KeyPressComponentState();
}

class _KeyPressComponentState extends State<KeyPressComponent> {
  // change to false, if you navigated to another page or opened a dialog.
  String? _lastKeyPress = "Waiting for key press. . . ";

  @override
  Widget build(BuildContext context) {
    return KeyboardMonitor(
      onKeyPress: (String? key) {
        setState(() {
          _lastKeyPress = key;
        });
      },
      child: Column(children: [
        const SizedBox(height: 50),
        const Image(image: AssetImage('assets/sky.png'), height: 150),
        const SizedBox(height: 50),
        const Text("Keyboard Monitor",
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 30),
        Text(_lastKeyPress!)
      ]),
    );
  }
}

class HelloWorldApp extends StatelessWidget {
  const HelloWorldApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('EntOS Flutter Test App'),
              foregroundColor: Colors.white,
              backgroundColor: Colors.blueGrey,
            ),
            body: DefaultTextStyle.merge(
                style: const TextStyle(fontSize: 32),
                child: const Center(child: KeyPressComponent())),
            backgroundColor: Colors.white));
  }
}
