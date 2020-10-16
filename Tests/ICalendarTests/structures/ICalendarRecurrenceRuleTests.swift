import XCTest
import Foundation
@testable import ICalendar

final class ICalendarRecurrenceRuleTests: XCTestCase {
    static var allTests = [
        ("testRecurrenceRules", testRecurrenceRules)
    ]
    private var calendar = Calendar(identifier: .gregorian)

    override func setUp() {
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
    }

    func testRecurrenceRules() throws {
        // Examples are (partly) taken from https://tools.ietf.org/html/rfc5545#section-3.8.5.3

        // Daily for 10 occurrences
        XCTAssertEqual(ICalendarRecurrenceRule(frequency: .daily, count: 10).iCalendarEncoded, "FREQ=DAILY;COUNT=10")
        // Daily until December 24, 1997
        XCTAssertEqual(ICalendarRecurrenceRule(frequency: .daily, until: .dateTime(date(1997, 12, 24))).iCalendarEncoded, "FREQ=DAILY;UNTIL=19971224T000000Z")
        // Every other day, forever
        XCTAssertEqual(ICalendarRecurrenceRule(frequency: .daily, interval: 2).iCalendarEncoded, "FREQ=DAILY;INTERVAL=2")
        // Every 10 days, 5 occurrences
        XCTAssertEqual(ICalendarRecurrenceRule(frequency: .daily, interval: 10, count: 5).iCalendarEncoded, "FREQ=DAILY;INTERVAL=10;COUNT=5")
        // Every day in January, until January 31, 2000
        XCTAssertEqual(ICalendarRecurrenceRule(frequency: .yearly, until: .dateOnly(date(2000, 1, 31))).iCalendarEncoded, "FREQ=YEARLY;UNTIL=20000131")
    }

    private func date(_ year: Int, _ month: Int, _ day: Int) -> Date {
        calendar.date(from: DateComponents(year: year, month: month, day: day, hour: 0, minute: 0, second: 0))!
    }
}
