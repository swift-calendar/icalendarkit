import XCTest
import Foundation
@testable import ICalendar

final class ICalendarDurationTests: XCTestCase {
    static var allTests = [
        ("testDurations", testDurations)
    ]

    func testDurations() throws {
        assert(duration: .zero, hasTotalSeconds: 0)
        assert(duration: .seconds(10), hasTotalSeconds: 10)
        assert(duration: .minutes(2), hasTotalSeconds: 120)
        assert(duration: .hours(1), hasTotalSeconds: 3600)
        assert(duration: .days(1), hasTotalSeconds: 24 * 3600)
        assert(duration: .weeks(1) + .days(1), hasTotalSeconds: 8 * 24 * 3600)

        let x: ICalendarDuration = .weeks(1) + .days(1) + .hours(25) + .seconds(63)

        XCTAssertEqual(x.parts.weeks, 1)
        XCTAssertEqual(x.parts.days, 2)
        XCTAssertEqual(x.parts.hours, 1)
        XCTAssertEqual(x.parts.minutes, 1)
        XCTAssertEqual(x.parts.seconds, 3)
    }

    private func assert(duration: ICalendarDuration, hasTotalSeconds totalSeconds: Int64, line: UInt = #line) {
        XCTAssertEqual(duration.totalSeconds, totalSeconds, line: line)
    }
}
