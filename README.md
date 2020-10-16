# iCalendar for Swift

[![Linux](https://github.com/fwcd/swift-icalendar/workflows/Linux/badge.svg)](https://github.com/fwcd/swift-icalendar/actions)
[![macOS](https://github.com/fwcd/swift-icalendar/workflows/macOS/badge.svg)](https://github.com/fwcd/swift-icalendar/actions)

A lightweight iCalendar (RFC 5545, `.ics`) encoder for Swift.

## Example

```swift
import Foundation
import ICalendar

var cal = ICalendar()

cal.events.append(ICalendarEvent(
    description: "My awesome event",
    dtstart: Date(),
    duration: ICalendarDuration(hours: 1)
))

print(cal.iCalendarEncoded)

// The output looks similar to this:
//
// BEGIN:VCALENDAR
// VERSION:2.0
// PRODID:-//swift-icalendar//swift-icalendar//EN
// CALSCALE:GREGORIAN
// BEGIN:VEVENT
// DTSTAMP:20201016T194809
// UID:B22CF435-BE06-4EE9-B7B0-6EE6878E3A06
// CREATED:20201016T194809
// DESCRIPTION:My awesome event
// DTSTART:20201016T194809
// LAST-MODIFIED:20201016T194809
// DURATION:P0DT1H0M0S
// END:VEVENT
// END:VCALENDAR
```

> Hint: Run `swift run --repl` to run an interactive Swift shell with access to the library
