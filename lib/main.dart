import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Key Presses',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        title: 'Flutter Demo Home Page',
        key: null,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FocusNode? focus;
  Timer? timer;
  Set<LogicalKeyboardKey>? _pressedKeys;
  Set<LogicalKeyboardKey>? _pressedKeysFromTimer;

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
    super.dispose();
  }

  KeyEventResult _onKeyEvent(FocusNode node, KeyEvent event) {
    // Whenever a press occurs, re-build.
    setState(() {
      _pressedKeys = RawKeyboard.instance.keysPressed;
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
        behavior: HitTestBehavior.opaque,
        onTap: () {
          focus!.requestFocus();
        },
        child: Focus(
          focusNode: focus,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Press a key!'),
                const Text(''),
                const Text('current keystrokes (updated constantly)'),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
