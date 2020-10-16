import XCTest
import Foundation
@testable import ICalendar

final class ICalendarTests: XCTestCase {
    static var allTests = [
        ("testICalendar", testICalendar)
    ]

    func testICalendar() throws {
        var cal = ICalendar()
        let year = 1970
        let month = 1
        let day = 1
        let hour = 0
        let minute = 0
        let second = 0
        let date = Calendar(identifier: .gregorian).date(from: DateComponents(year: year, month: month, day: day, hour: hour, minute: minute, second: second))!
        let description = "Test"
        let uid = "test"

        cal.events.append(ICalendarEvent(
            dtstamp: date,
            uid: uid,
            created: date,
            description: description,
            dtstart: date,
            lastModified: date
        ))

        let encodedDate = String(format: "%04d%02d%02dT%02d%02d%02d", year, month, day, hour, minute, second)
        XCTAssertEqual(cal.iCalendarEncoded, [
            "BEGIN:VCALENDAR",
            "VERSION:2.0",
            "PRODID:-//swift-icalendar//swift-icalendar//EN",
            "CALSCALE:GREGORIAN",
            "BEGIN:VEVENT",
            "DTSTAMP:\(encodedDate)",
            "UID:\(uid)",
            "CREATED:\(encodedDate)",
            "DESCRIPTION:\(description)",
            "DTSTART:\(encodedDate)",
            "LAST-MODIFIED:\(encodedDate)",
            "END:VEVENT",
            "END:VCALENDAR"
        ].map { "\($0)\r\n" }.joined())
    }
}
