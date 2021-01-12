---
layout: page
title: Clock face
include_in_header: false
---

# Reading the clock

## The elements of the clock

![clock face annotated]({{ 'assets/screenshot/face_annot.jpeg' | relative_url }})

The screen capture shows the elements of the clock face annotated with letters.
The letters correspond to the following descriptions:
- **H**: The hour hand. This is the shortest hand. It points to the hour of the
  day, numbered around the periphery. Zero is midnight. It is shown with the
  hour hand indicating vertically toward the
  bottom. Twelve is high noon. It is shown with the hour hand indicating
  vertically toward the top.
  The hour hand makes one circuit of the clock face every day. That is every
  twenty-four hours.
  The hand in the illustration indicates just after sixteen (16) hours
  (four in the afternoon).
- **M**: The minute hand. This is the longest hand. It reads a little differently
  than a normal clock only because there are twice as many hour labels at the
  edge. The spacing of the hour labels on a twelve hour clock is five minutes.
  The spacing of the hour labels on this twenty-four hour clock is half of
  that-- two and one-half minutes. The even numbers do appear at five minute
  intervals. At 14, we have five minutes after the hour. At 16 we have ten
  minutes after the hour. At 2 we have thirty five minutes after the hour.
  The minute hand makes one circuit of the clock face every hour.
  The hand in the illustration indicates five minutes past the hour.
- **W**: The watch hand. This is the narrow hand. It shows the current place
  within a four hour watch. It points up at the beginning of the
  watch. It points to the right at the end of the first hour of the watch. It points
  down at the end of the second hour of the watch. It points to the left at
  the end of the third hour of the watch.
  The watch hand makes one circuit of the clock face every four hours.
  The hand in the illustration indicates the beginning of the first hour of
  the watch.
- **S**: The sun appears if location is enabled. Knowing the time and your longitude,
  the app computes the local hour angle of the sun and displays it next to the numbered
  hour scale. When the sun is at noon, at the top, it is on your local hour
  meridian, as directly overhead as it will get during the day.
  Before then it will be moving higher. After then it will be moving lower.
  It reaches its lowest (out of sight, below you, on the other side of the
  earth) at midnight.
  See [hour angle](https://en.wikipedia.org/wiki/Hour_angle) on Wikipedia
  for more regarding the hour angle.
- **O**: The moon appears if location is enabled. Knowing your time and your longitude,
  the app computes the local hour angle of the moon and displays it next to the
  numbered hour scale. See the description of **S**, the local hour angle of the
  sun, for more detail.
- **LAT**: Your current latitude (if location is enabled). It reads degrees,
  minutes, and seconds. It will have an "N" for north latitudes and an "S"
  for south latitudes.
- **LON**: Your current longitude (if location is enabled). It reads degrees,
  minutes, and seconds. It will have a "W" for west latitudes (West of
  Greenwich). It will have an "E" for east latitudes (East of Greenwich).
- **VEL**: Your current velocity in tenths of knots and cardinal direction.
  A "knot" is one nautical
  mile per hour. It is the measure of speed used by ships on the sea.
  The clock displays sixteen cardinal directions. They are, moving around
  the compass from the north-- N, NNE, NE, ENE, E, ESE, SE, SSE, S, SSW, SW,
  WSW, W, WNW, NW, NNW. Thus the clock shows your direction to the nearest
  twenty-two and one-half degrees.
- **WT**: These heavy, outer tics correspond to the watch (**W**) hand. See a
  further description in the following.
- **HT**: These light, inner tics correspond to the hour (**H**) hand. See a
  further description in the following.

## How the tics deliniate watches

![clock face tics]({{ 'assets/screenshot/face_annot_dog_pair.png' | relative_url }})

A watch is four hours (in general terms). The watch hand (**W**) runs around
the clock once during the four hours of the watch. It goes a quarter of the
way around every hour. These hours show on the clock face with bold tics. On
the right hand side of the illustration you see the watch hand in the final
hour of the watch. It started this final hour of the watch pointing to the six (6).
It will move to point up at the twelve (12) at the end of the watch.

There are six watches in a day (also in general terms). The lighter tics mark
the hours where a transition occurs from one watch to the next. The hour hand
(**H**) points to an hour marked by one of these lighter tics at the eight bell
changes of the watch. The left of the illustration shows the motion of the hour hand
during the four hours of the fifth watch. The watch starts when the hour hand
indicates to the tic next to hour sixteen (16).
It ends when the hour hand indicates to the tic next to hour twenty (20).

We say "in general terms" above because some watch systems break the fifth
watch into two, two-hour, shortened "dog" watches. The clock does not change
when such a system is in use. The bells in use are the same. The dog watch
splits when the hour indicator points to 18 hours and the watch indicator
points down at the zero.

[FAQ]({{ 'faq' | relative_url }})
