import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Key Presses',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
        key: null,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FocusNode? focus;
  Timer? timer;
  Set<LogicalKeyboardKey>? _pressedKeys;
  Set<LogicalKeyboardKey>? _pressedKeysFromTimer;
  int keyEventCount = 0;
  int clickEventCount = 0;

  @override
  void initState() {
    focus = FocusNode(canRequestFocus: true, onKeyEvent: _onKeyEvent);
    focus!.requestFocus();

    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _pressedKeysFromTimer = RawKeyboard.instance.keysPressed;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  KeyEventResult _onKeyEvent(FocusNode node, KeyEvent event) {
    // Whenever a press occurs, re-build.
    setState(() {
      _pressedKeys = RawKeyboard.instance.keysPressed;
      keyEventCount += 1;
    });
    return KeyEventResult.handled;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GestureDetector(
        onTap: () {
          focus!.requestFocus();
          setState(() {
            clickEventCount++;
          });
        },
        child: Focus(
          focusNode: focus,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Press a key!'),
                const Text(''),
                const Text('current keystrokes'),
                if (_pressedKeysFromTimer != null)
                  ..._pressedKeysFromTimer!
                      .map(
                        (key) => Text(
                          key.debugName ?? 'foo',
                        ),
                      )
                      .toList(growable: false),
                const Text(''),
                const Text('keystrokes @ last onKeyEvent'),
                if (_pressedKeys != null)
                  ..._pressedKeys!
                      .map(
                        (key) => Text(
                          key.debugName ?? 'foo',
                        ),
                      )
                      .toList(growable: false),
                const Text(''),
                Text('We have recorded $keyEventCount key events.'),
                Text('We have recorded $clickEventCount clicks.'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
