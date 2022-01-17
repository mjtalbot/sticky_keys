# keys

A new Flutter project to show a keyboard issue with Flutter.

## Getting Started

To run run: `flutter run -d macos`

## Setup

The app is setup to listen to your keystrokes using a Focus node.
we display the number of keystrokes we have recorded
we display the set of keys pressed on last key event `event Keystrokes`
we display the set of keys pressed on a timer (constantly updating) `timer Keystrokes`

## Sticky key Bug

* Reproducing:
  * hold `cmd`
  * hold `a`
  * press `tab` (tabbing to another widow. )
    * both pressed `event Keystrokes` & `timer Keystrokes` show:
      * `Key A`
      * `Meta Left`
  * now refocus the flutter demo page app.
    * both still show the same pressed keys.
    * press another button `k`
    * you should now see the `Meta Left` key cleared, but A still shows
      * if the bug below got triggered the `event Keystrokes` does not get cleared:
        * press an arrow key to clear the bug
    * to clear `Key A`, press `a`

Expected behavior: both `event Keystrokes` and `timer Keystrokes` should set back to empty on regaining focus.
(this does happen if you hold `cmd` and `a` and CLICK out into another window with your mouse cursor)

Modification: rather than pressing `tab` above you can also use three fingers to swipe up on mac & select another window.

Modification: pressing `cmd` and `shift` and just clicking out of hte window will get them both sticking too.

## Bug missing key events, probably incorrect use of FocusNode?

* Reproduce
  * press `a`
  * see `Key A` update in both `event Keystrokes` & `timer Keystrokes`
  * use the mouse to click anywhere inside the flutter app (maybe multiple times)
  * now only `timer Keystrokes` updates.
  * pres any `arrow key` or `tab` and the `event Keystrokes` work again.
