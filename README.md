# keys

A new Flutter project to show a keyboard issue with Flutter.

## Getting Started

To run run: `flutter run -d macos`

## Setup

The app is setup to listen to your keystrokes using a Focus node.
we display the number of keystrokes we have recorded
we display the set of keys pressed on last key event `event Keystrokes`

## Sticky any key Bug (web only. )

you can get any alphanumeric key permanently stuck in "pressed" by simply pressing it with a cmd

* Reproduce:
  * hold `cmd`
  * press `a`
  * let go of `a`
  * let go of `cmd`
  * `a` is stuck now.
  * the system knows a has been let go of
    * the contently updating checker shows this.

note: if you wait about 2 seconds before letting go of cmd, `a` does clear. but if you press cmd+a and let go in a natural way it does not.
note: if you let go of cmd before a it clears as well.
note: you can get more keys stuck this way by pressing more of them in combination with cmd and letting go of "the lot"

## Sticky `key A` Bug (mac os only. )

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

## Sticky `CMD` `SHIFT` (mac os & web)

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

## Sticky `SHIFT` or `Control` or `Alt` (mac os & web)

* Reproduce:
  * hold `shift` or `control`
  * click outside the flutter window.
  * let go of all keys
  * the key is still recorded as pressed.

## Sticky `Meta` (mac os & web)

* Reproduce:
  * hold `cmd`
  * press `tab` to focus a different window
  * let go of all keys
  * the `meta` is still recorded as pressed.
