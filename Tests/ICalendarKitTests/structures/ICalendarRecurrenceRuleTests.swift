import XCTest
import Foundation
@testable import ICalendarKit

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
        XCTAssertEqual(ICalendarRecurrenceRule(frequency: .daily, count: 10).vEncoded, "FREQ=DAILY;COUNT=10")
        // Daily until December 24, 1997
        XCTAssertEqual(ICalendarRecurrenceRule(frequency: .daily, until: .dateTime(date(1997, 12, 24))).vEncoded, "FREQ=DAILY;UNTIL=19971224T000000Z")
        // Every other day, forever
        XCTAssertEqual(ICalendarRecurrenceRule(frequency: .daily, interval: 2).vEncoded, "FREQ=DAILY;INTERVAL=2")
        // Every 10 days, 5 occurrences
        XCTAssertEqual(ICalendarRecurrenceRule(frequency: .daily, interval: 10, count: 5).vEncoded, "FREQ=DAILY;INTERVAL=10;COUNT=5")
        // Every day in January, until January 31, 2000
        XCTAssertEqual(ICalendarRecurrenceRule(frequency: .yearly, until: .dateOnly(date(2000, 1, 31))).vEncoded, "FREQ=YEARLY;UNTIL=20000131")
        // Weekly on tuesday and thursday for 5 weeks
        XCTAssertEqual(ICalendarRecurrenceRule(frequency: .weekly, count: 10, byDay: [.every(.tuesday), .every(.thursday)]).vEncoded, "FREQ=WEEKLY;COUNT=10;BYDAY=TU,TH")
        // Each other week on monday, wednesday and friday until December 24, 1997
        XCTAssertEqual(ICalendarRecurrenceRule(frequency: .weekly, interval: 2, until: .dateTime(date(1997, 12, 24)), byDay: [.every(.monday), .every(.wednesday), .every(.friday)], startOfWorkweek: .monday).vEncoded, "FREQ=WEEKLY;INTERVAL=2;UNTIL=19971224T000000Z;BYDAY=MO,WE,FR;WKST=MO")
        // Every other month of the first and last sunday of the month for 10 occurrences
        XCTAssertEqual(ICalendarRecurrenceRule(frequency: .monthly, interval: 2, count: 10, byDay: [.first(.sunday), .last(.sunday)]).vEncoded, "FREQ=MONTHLY;INTERVAL=2;COUNT=10;BYDAY=1SU,-1SU")
        // Monthly on the third-to-the-last day of the month, forever
        XCTAssertEqual(ICalendarRecurrenceRule(frequency: .monthly, byDayOfMonth: [-3]).vEncoded, "FREQ=MONTHLY;BYMONTHDAY=-3")
        // Monthly on the 2nd and 15th of the month for 10 occurrences
        XCTAssertEqual(ICalendarRecurrenceRule(frequency: .monthly, byDayOfMonth: [2, 15]).vEncoded, "FREQ=MONTHLY;BYMONTHDAY=2,15")
        // Yearly in June and July for 10 occurrences
        XCTAssertEqual(ICalendarRecurrenceRule(frequency: .yearly, byMonth: [6, 7]).vEncoded, "FREQ=YEARLY;BYMONTH=6,7")
        // Every third year on the 1st, 100th and 200th day for 10 occurrences
        XCTAssertEqual(ICalendarRecurrenceRule(frequency: .yearly, interval: 3, byDayOfYear: [1, 100, 200]).vEncoded, "FREQ=YEARLY;INTERVAL=3;BYYEARDAY=1,100,200")
        // Every 20th monday of the year, forever
        XCTAssertEqual(ICalendarRecurrenceRule(frequency: .yearly, byDay: [.init(week: 20, dayOfWeek: .monday)]).vEncoded, "FREQ=YEARLY;BYDAY=20MO")
    }

    private func date(_ year: Int, _ month: Int, _ day: Int) -> Date {
        calendar.date(from: DateComponents(year: year, month: month, day: day, hour: 0, minute: 0, second: 0))!
    }
}
