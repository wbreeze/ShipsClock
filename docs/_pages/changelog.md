---
layout: page
title: What's New
include_in_header: true
---

# Changelog

## Version 1.3.2
- [Issue 22](https://github.com/wbreeze/ShipsClock/issues/22):
  The moon now orients bottom to center. It's phase looks as if lighted by the sun.
- [Issue 40](https://github.com/wbreeze/ShipsClock/issues/40):
  The sun and moon will no longer sometimes hang-up at midnight. Most probably
  no longer.
- [Issue 42](https://github.com/wbreeze/ShipsClock/issues/42):
  Removed support for the watch because presence of the watch disables the bells.
- [Issue 44](https://github.com/wbreeze/ShipsClock/issues/44):
  Notifications (bells) will no longer play after dismissing the app while it is
  running in the background.
- [Issue 45](https://github.com/wbreeze/ShipsClock/issues/45):
  The bell will no longer play when the app is started or moved to
  foreground after being in background.

## Version 1.2.2
- Added Apple Watch display

## Version 1.1.3
- Adds an indicator for hour UTC

## Version 1.1.2
- Provide a title for notifications such that their sound is played in iOS 15

## Version 1.1.0
- Displays the hour angle of the moon, using your longitude, when location is enabled.
- Displays the approximate phase of the moon

## Version 1.0.2
- Corrects display of tics, center dot, and watch hand in dark mode.
- Displays the hour angle of the sun, using your longitude, when location is enabled.

### `Initial Release`
## Version 1.0
This first release includes:
- ship's bell played at half hour intervals
- a twenty-four hour clock face with hands for the hour, minute, and
  the four-hour ship's watch
- display of the current latitude and longitude in degrees, minutes, and seconds
- display of the current heading using points of the compass
- display of velocity in knots
