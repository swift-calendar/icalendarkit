# iCalendarKit for Swift

[![Linux](https://github.com/swift-calendar/icalendarkit/workflows/Linux/badge.svg)](https://github.com/swift-calendar/icalendarkit/actions)
[![macOS](https://github.com/swift-calendar/icalendarkit/workflows/macOS/badge.svg)](https://github.com/swift-calendar/icalendarkit/actions)
[![Docs](https://github.com/swift-calendar/icalendarkit/workflows/Docs/badge.svg)](https://swift-calendar.github.io/icalendarkit)

A lightweight iCalendar (RFC 5545, `.ics`) encoder for Swift.

## Example

```swift
import Foundation
import ICalendarKit

var cal = ICalendar()

cal.events.append(ICalendarEvent(
    description: "My awesome event",
    dtstart: .dateTime(Date()),
    duration: .hours(1),
    rrule: .init(
        frequency: .weekly,
        byDay: [.every(.tuesday), .every(.saturday)]
    )
))

print(cal.vEncoded)

// The output looks similar to this:
//
// BEGIN:VCALENDAR
// VERSION:2.0
// PRODID:-//swift-icalendar//swift-icalendar//EN
// CALSCALE:GREGORIAN
// BEGIN:VEVENT
// DTSTAMP:20201017T000135Z
// UID:327278D1-F140-49C9-AB75-C1D9579C1851
// CREATED:20201017T000135Z
// DESCRIPTION:My awesome event
// DTSTART:20201017T000135Z
// LAST-MODIFIED:20201017T000135Z
// DURATION:P0DT1H0M0S
// RRULE:FREQ=WEEKLY;BYDAY=TU,SA
// END:VEVENT
// END:VCALENDAR
```

> Hint: Run `swift run --repl` to run an interactive Swift shell with access to the library
