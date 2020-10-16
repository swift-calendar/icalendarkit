import XCTest
import Foundation
@testable import ICalendar

final class ICalendarTests: XCTestCase {
    static var allTests = [
        ("testICalendar", testICalendar)
    ]

    /// A few dates for testing 
    private var dates: [(date: Date, encoded: String, encodedWithoutTime: String)]!

    override func setUp() {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        dates = (0..<20).map { (i: Int) -> (date: Date, encoded: String, encodedWithoutTime: String) in
            let year = 1970
            let month = 1
            let day = 1
            let hour = 0
            let minute = 0
            let second = i

            let date = calendar.date(from: DateComponents(year: year, month: month, day: day, hour: hour, minute: minute, second: second))!
            let encoded = String(format: "%04d%02d%02dT%02d%02d%02dZ", year, month, day, hour, minute, second)
            let encodedWithoutTime = String(format: "%04d%02d%02d", year, month, day)

            return (date: date, encoded: encoded, encodedWithoutTime: encodedWithoutTime)
        }
    }

    func testICalendar() throws {
        var cal = ICalendar()
        
        
        let description = "Test"
        let uid = "test"

        cal.events.append(ICalendarEvent(
            dtstamp: dates[0].date,
            uid: uid,
            created: dates[1].date,
            description: description,
            dtstart: dates[2].date,
            lastModified: dates[3].date
        ))

        XCTAssertEqual(cal.iCalendarEncoded, [
            "BEGIN:VCALENDAR",
            "VERSION:2.0",
            "PRODID:-//swift-icalendar//swift-icalendar//EN",
            "CALSCALE:GREGORIAN",
            "BEGIN:VEVENT",
            "DTSTAMP:\(dates[0].encoded)",
            "UID:\(uid)",
            "CREATED:\(dates[1].encoded)",
            "DESCRIPTION:\(description)",
            "DTSTART:\(dates[2].encoded)",
            "LAST-MODIFIED:\(dates[3].encoded)",
            "END:VEVENT",
            "END:VCALENDAR"
        ].map { "\($0)\r\n" }.joined())
    }
}
