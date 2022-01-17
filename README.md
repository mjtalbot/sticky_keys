# keys

A new Flutter project to show a keyboard issue with Flutter.

## Getting Started

To run run: `flutter run -d macos`

## Setup

The app is setup to listen to your keystrokes using a Focus node.
we display the number of keystrokes we have recorded
we display the set of keys pressed on last key event `event Keystrokes`

## 1. Sticky `A key` Bug

you can get any alphanumeric key permanently stuck in "pressed"

* Reproduce:
  * hold `cmd`
  * hold `a`
  * press `tab` (tabbing to another widow. )
    * both pressed `event Keystrokes`
      * `Key A`
      * `Meta Left`
  * now refocus the flutter demo page app.
    * both still show the same pressed keys.
    * press another button `k`
    * to clear `Key A`, press `a`

Expected behavior: both `event Keystrokes` should set back to empty on regaining focus. and we should get an event for the clearing of those keys come through.
(this does happen if you hold `cmd` and `a` and CLICK out into another window with your mouse cursor)

Modification: rather than pressing `tab` above you can also use three fingers to swipe up on mac & select another window has the same behavior

## 2. Sticky `CMD` `SHIFT`

you can get `cmd` and `shift` stuck in pressed

* Reproduce:
  * hold `cmd` `shift` `a`
  * click outside the window
  * let go of `a`
  * let go of `cmd`
  * let go of `shift`
  * refocus the flutter app.
  * command and shift are stuck until you press any other button with the flutter window focussed.

Expected behaviour: the keystrokes should get set to empty.
Note: if you let go of `cmd` & `shift` before `a` , the current keys get set to nothing

## 3. Sticky `SHIFT` or `Control`

* Reproduce:
  * hold `shift` or `control`
  * click outside the flutter window.
  * let go of all keys
  * the key is still recorded as pressed.

## 4. Sticky `Meta`

* Reproduce:
  * hold `cmd`
  * press `tab` to focus a different window
  * let go of all keys
  * the `meta` is still recorded as pressed.
