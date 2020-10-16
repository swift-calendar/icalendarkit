/// This value type is used to identify properties that contain
/// a recurrence rule specification.
///
/// See https://tools.ietf.org/html/rfc5545#section-3.3.10
public struct ICalendarRecurrenceRule: ICalendarPropertyEncodable {
    /// The frequency of the recurrence.
    public var frequency: Frequency
    /// At which interval the recurrence repeats (in terms of the frequency).
    /// E.g. 1 means every hour for an hourly rule, ...
    /// The default value is 1.
    public var interval: Int?

    /// The end date/time. Must have the same 'ignoreTime'-value as dtstart.
    public var until: ICalendarDate? {
        willSet { count = nil }
    }
    /// The number of recurrences.
    public var count: Int? {
        willSet { until = nil }
    }

    /// At which seconds of the minute it should occur.
    /// Must be between 0 and 60 (inclusive).
    public var bySeconds: [Int]? {
        didSet { assert(bySeconds?.allSatisfy { (0...60).contains($0) } ?? true, "by-second rules must be between 0 and 60 (inclusive): \(bySeconds ?? [])") }
    }
    /// At which minutes of the hour it should occur.
    /// Must be between 0 and 60 (exclusive).
    public var byMinutes: [Int]? {
        didSet { assert(byMinutes?.allSatisfy { (0..<60).contains($0) } ?? true, "by-hour rules must be between 0 and 60 (exclusive): \(byMinutes ?? [])") }
    }
    /// At which hours of the day it should occur.
    /// Must be between 0 and 24 (exclusive).
    public var byHours: [Int]? {
        didSet { assert(byHours?.allSatisfy { (0..<24).contains($0) } ?? true, "by-hour rules must be between 0 and 24 (exclusive): \(byHours ?? [])") }
    }
    /// At which days (of the week/year) it should occur.
    public var byDay: [SignedDay]?
    /// At which days of the month it should occur.
    public var byDaysOfMonth: [SignedDayOfMonth]?
    /// At which days of the year it should occur.
    public var byDaysOfYear: [SignedDayOfYear]?
    /// At which weeks of the year it should occur.
    public var byWeekOfYear: [SignedWeekOfYear]?
    /// At which months it should occur.
    /// Must be between 1 and 12 (inclusive).
    public var byMonthOfYear: [Int]? {
        didSet { assert(byMonthOfYear?.allSatisfy { (1...12).contains($0) } ?? true, "by-month-of-year rules must be between 1 and 12: \(byMonthOfYear ?? [])") }
    }
    /// The day on which the workweek starts.
    /// Monday by default.
    public var startOfWorkweek: DayOfWeek?

    private var properties: [String: ICalendarEncodable?] {
        [
            "FREQ": frequency,
            "INTERVAL": interval,
            "UNTIL": until,
            "COUNT": count
        ]
    }

    public var iCalendarEncoded: String {
        properties.compactMap { (key, value) in value.map { "\(key)=\($0.iCalendarEncoded)" } }.joined(separator: ";")
    }

    public enum Frequency: String, ICalendarEncodable {
        case secondly = "SECONDLY"
        case minutely = "MINUTELY"
        case hourly = "HOURLY"
        case daily = "DAILY"
        case weekly = "WEEKLY"
        case monthly = "MONTHLY"
        case yearly = "YEARLY"

        public var iCalendarEncoded: String { rawValue }
    }

    public enum DayOfWeek: String, ICalendarEncodable {
        case monday = "MO"
        case tuesday = "TU"
        case wednesday = "WE"
        case thursday = "TH"
        case friday = "FR"
        case saturday = "SA"
        case sunday = "SU"

        public var iCalendarEncoded: String { rawValue }
    }

    public struct SignedDay: ICalendarEncodable {
        /// The week of the day. May be negative.
        public let weekOfYear: Int?
        /// The day of the week.
        public let dayOfWeek: DayOfWeek

        public var iCalendarEncoded: String { "\(weekOfYear.map { "\($0.signum() > 0 ? "" : "-")\(abs($0))" } ?? "")\(dayOfWeek.iCalendarEncoded)" }

        public init(weekOfYear: Int? = nil, dayOfWeek: DayOfWeek) {
            self.weekOfYear = weekOfYear
            self.dayOfWeek = dayOfWeek

            assert(weekOfYear.map { (1...53).contains(abs($0)) } ?? true, "Week-of-year \(weekOfYear.map(String.init) ?? "?") is not between 1 and 53 (inclusive)")
        }
    }

    public struct SignedDayOfMonth: ICalendarEncodable {
        /// The day of the month. May be negative.
        public let dayOfMonth: Int

        public var iCalendarEncoded: String { "\(dayOfMonth.signum() > 0 ? "" : "-")\(abs(dayOfMonth))" }

        public init(dayOfMonth: Int) {
            self.dayOfMonth = dayOfMonth

            assert((1...31).contains(abs(dayOfMonth)), "Day-of-month \(dayOfMonth) is not between 1 and 31 (inclusive)")
        }
    }

    public struct SignedDayOfYear: ICalendarEncodable {
        /// The day of the year. May be negative.
        public let dayOfYear: Int

        public var iCalendarEncoded: String { "\(dayOfYear.signum() > 0 ? "" : "-")\(abs(dayOfYear))" }

        public init(dayOfYear: Int) {
            self.dayOfYear = dayOfYear

            assert((1...366).contains(abs(dayOfYear)), "Day-of-year \(dayOfYear) is not between 1 and 366 (inclusive)")
        }
    }

    public struct SignedWeekOfYear: ICalendarEncodable {
        /// The week of the year. May be negative.
        public let weekOfYear: Int

        public var iCalendarEncoded: String { "\(weekOfYear.signum() > 0 ? "" : "-")\(abs(weekOfYear))" }

        public init(weekOfYear: Int) {
            self.weekOfYear = weekOfYear

            assert((1...53).contains(abs(weekOfYear)), "Week-of-year \(weekOfYear) is not between 1 and 53 (inclusive)")
        }
    }

    // TODO: Initializer
}
