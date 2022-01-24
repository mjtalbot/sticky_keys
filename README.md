# keys

A new Flutter project to show a keyboard issue with Flutter.

## Getting Started

To run run macos: `flutter run -d macos`
To run run web: `flutter run -d chrome`

## Setup

The app is setup to listen to your keystrokes using a Focus node.
we display the number of keystrokes we have recorded
we display the set of keys pressed on last key event `event Keystrokes`

## 1 - macos - break onkey & onkeyevent

produces this error:
Another exception was thrown: A KeyUpEvent is dispatched, but the state shows that the physical key is pressed on a different logical key. If this occurs
in real application, please report this bug to Flutter. If this occurs in unit tests, please ensure that simulated events follow Flutter's event model as
documented in `HardwareKeyboard`. This was the event: KeyUpEvent#aa942(physicalKey: PhysicalKeyboardKey#70004(usbHidUsage: "0x00070004", debugName: "Key
A"), logicalKey: LogicalKeyboardKey#70004(keyId: "0x1400070004", keyLabel: "", debugName: "Key with ID 0x01400070004"), character: null, timeStamp:
5:24:44.700573) and the recorded logical key LogicalKeyboardKey#00061(keyId: "0x00000061", keyLabel: "A", debugName: "Key A")

- open app
- press a
- three finger swipe up on mac touchpad to see window selection
- let go of a (this only happens with the a key)
- select the flutter window with the sticky keys app
- press a again and note the error log

## 2 - macos & web - sticky any alphanumeric key

- open app
- press key (e.g. g) or multiple alphanumeric keys
- three finger swipe up on mac touchpad to see window selection
- let go of all keys
- select the flutter window with the sticky keys app
- the keys are now stuck, until you press those specific keys again.

note: note for web, this is just on the rawkeyboard, maybe expected behaviour.

## 3 - macos & web - sticky meta/ control/ alt key (you can sticky multiple)

- open app
- press meta/ control/ alt
- three finger swipe up on mac touchpad to see window selection
- let go of all keys
- select SOME OTHER  window with the sticky keys app
- three finger swipe & select the flutter
- the keys are now stuck, until you press any button

## 4 - web - permanently sticky alphanumeric keys (for _onKey/ RawKeyboard.instance.keysPressed)

- open app
- press any alpha numeric key (e.g. A)
- press command
- let go of alpha numeric key (e.g. A)
- let go of command
- now the alpha numeric key is stuck until you press the key again.

note: this has to be done in one smooth motion, it's quite unnatural.
note for web, this is just on the rawkeyboard, maybe expected behaviour.
