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
  Set<LogicalKeyboardKey>? _pressedKeysByRaw;
  Set<LogicalKeyboardKey>? _pressedKeysByKey;
  Set<LogicalKeyboardKey>? _rawKeysKeysFromTimer;
  Set<LogicalKeyboardKey>? _hardwareKeysFromTimer;

  @override
  void initState() {
    focus = FocusNode(
        canRequestFocus: true, onKeyEvent: _onKeyEvent, onKey: _onKey);
    focus!.requestFocus();

    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _rawKeysKeysFromTimer = RawKeyboard.instance.keysPressed;
        _hardwareKeysFromTimer = HardwareKeyboard.instance.logicalKeysPressed;
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
    print('OnKeyEvent $event');
    setState(() {
      _pressedKeysByKey = HardwareKeyboard.instance.logicalKeysPressed;
    });
    return KeyEventResult.handled;
  }

  KeyEventResult _onKey(FocusNode node, RawKeyEvent event) {
    // Whenever a press occurs, re-build.
    setState(() {
      _pressedKeysByRaw = RawKeyboard.instance.keysPressed;
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
                const Text('Timed Checks:'),
                const Text('HardwareKeyboard.instance.logicalKeysPressed:'),
                if (_hardwareKeysFromTimer != null)
                  ..._hardwareKeysFromTimer!
                      .map(
                        (key) => Text(
                          key.debugName ?? 'foo',
                        ),
                      )
                      .toList(growable: false),
                const Text(''),
                const Text('RawKeyboard.instance.keysPressed:'),
                if (_rawKeysKeysFromTimer != null)
                  ..._rawKeysKeysFromTimer!
                      .map(
                        (key) => Text(
                          key.debugName ?? 'foo',
                        ),
                      )
                      .toList(growable: false),
                const Text(''),
                const Text(''),
                const Text('Evented Checks:'),
                const Text('logicalKeysPressed @ _onKeyEvent'),
                if (_pressedKeysByKey != null)
                  ..._pressedKeysByKey!
                      .map(
                        (key) => Text(
                          key.debugName ?? 'foo',
                        ),
                      )
                      .toList(growable: false),
                const Text(''),
                const Text('keysPressed @ last _onKey:'),
                if (_pressedKeysByRaw != null)
                  ..._pressedKeysByRaw!
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
