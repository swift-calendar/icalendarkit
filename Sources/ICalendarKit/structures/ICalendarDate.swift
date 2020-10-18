import Foundation
import VComponentKit

/// A date or date/time for use in calendar
/// events, todos or free/busy-components.
public struct ICalendarDate: VPropertyEncodable {
    public var date: Date
    public var ignoreTime: Bool

    public var vEncoded: String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyyMMdd\(ignoreTime ? "" : "'T'HHmmss'Z'")"
        return formatter.string(from: date)
    }
    public var parameters: [(String, [String])] {
        ignoreTime ? [("VALUE", ["DATE"])] : []
    }

    public init(date: Date, ignoreTime: Bool = false) {
        self.date = date
        self.ignoreTime = ignoreTime
    }

    public static func dateOnly(_ date: Date) -> ICalendarDate {
        ICalendarDate(date: date, ignoreTime: true)
    }

    public static func dateTime(_ date: Date) -> ICalendarDate {
        ICalendarDate(date: date, ignoreTime: false)
    }
}
