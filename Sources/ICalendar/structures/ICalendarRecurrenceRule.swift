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
    public var bySecond: [Int]? {
        didSet { assert(bySecond?.allSatisfy { (0...60).contains($0) } ?? true, "by-second rules must be between 0 and 60 (inclusive): \(bySecond ?? [])") }
    }
    /// At which minutes of the hour it should occur.
    /// Must be between 0 and 60 (exclusive).
    public var byMinute: [Int]? {
        didSet { assert(byMinute?.allSatisfy { (0..<60).contains($0) } ?? true, "by-hour rules must be between 0 and 60 (exclusive): \(byMinute ?? [])") }
    }
    /// At which hours of the day it should occur.
    /// Must be between 0 and 24 (exclusive).
    public var byHour: [Int]? {
        didSet { assert(byHour?.allSatisfy { (0..<24).contains($0) } ?? true, "by-hour rules must be between 0 and 24 (exclusive): \(byHour ?? [])") }
    }
    /// At which days (of the week/year) it should occur.
    public var byDay: [Day]?
    /// At which days of the month it should occur. Specifies a COMMA-separated
    /// list of days of the month. Valid values are 1 to 31 or -31 to -1.
    public var byDayOfMonth: [Int]? {
        didSet { assert(byDaysOfYear?.allSatisfy { (1...31).contains(abs($0)) } ?? true, "by-set-pos rules must be between 1 and 31 or -31 and -1: \(byDayOfMonth ?? [])") }
    }
    /// At which days of the year it should occur. Specifies a list of days
    /// of the year.  Valid values are 1 to 366 or -366 to -1.
    public var byDaysOfYear: [Int]? {
        didSet { assert(byWeekOfYear?.allSatisfy { (1...366).contains(abs($0)) } ?? true, "by-set-pos rules must be between 1 and 366 or -366 and -1: \(byDaysOfYear ?? [])") }
    }
    /// At which weeks of the year it should occur. Specificies a list of
    /// ordinals specifying weeks of the year. Valid values are 1 to 53 or -53 to
    /// -1.
    public var byWeekOfYear: [Int]? {
        didSet { assert(byWeekOfYear?.allSatisfy { (1...53).contains(abs($0)) } ?? true, "by-set-pos rules must be between 1 and 53 or -53 and -1: \(byWeekOfYear ?? [])") }
    }
    /// At which months it should occur.
    /// Must be between 1 and 12 (inclusive).
    public var byMonth: [Int]? {
        didSet { assert(byMonth?.allSatisfy { (1...12).contains($0) } ?? true, "by-month-of-year rules must be between 1 and 12: \(byMonth ?? [])") }
    }
    /// Specifies a list of values that corresponds to the nth occurrence within
    /// the set of recurrence instances specified by the rule. By-set-pos
    /// operates on a set of recurrence instances in one interval of the
    /// recurrence rule. For example, in a weekly rule, the interval would be one
    /// week A set of recurrence instances starts at the beginning of the
    /// interval defined by the frequency rule part. Valid values are 1 to 366 or
    /// -366 to -1. It MUST only be used in conjunction with another by-xxx rule
    /// part.
    public var bySetPos: [Int]? {
        didSet { assert(bySetPos?.allSatisfy { (1...366).contains(abs($0)) } ?? true, "by-set-pos rules must be between 1 and 366 or -366 and -1: \(bySetPos ?? [])") }
    }
    /// The day on which the workweek starts.
    /// Monday by default.
    public var startOfWorkweek: DayOfWeek?

    private var properties: [(String, [ICalendarEncodable]?)] {
        [
            ("FREQ", [frequency]),
            ("INTERVAL", interval.map { [$0] }),
            ("UNTIL", until.map { [$0] }),
            ("COUNT", count.map { [$0] }),
            ("BYSECOND", bySecond),
            ("BYMINUTE", byMinute),
            ("BYHOUR", byHour),
            ("BYDAY", byDay),
            ("BYMONTHDAY", byDayOfMonth),
            ("BYYEARDAY", byDaysOfYear),
            ("BYWEEKNO", byWeekOfYear),
            ("BYMONTH", byMonth),
            ("BYSETPOS", bySetPos),
            ("WKST", startOfWorkweek.map { [$0] })
        ]
    }

    public var iCalendarEncoded: String {
        properties.compactMap { (key, values) in values.map { "\(key)=\($0.map(\.iCalendarEncoded).joined(separator: ","))" } }.joined(separator: ";")
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

    public struct Day: ICalendarEncodable {
        /// The week. May be negative.
        public let week: Int?
        /// The day of the week.
        public let dayOfWeek: DayOfWeek

        public var iCalendarEncoded: String { "\(week.map(String.init) ?? "")\(dayOfWeek.iCalendarEncoded)" }

        public init(week: Int? = nil, dayOfWeek: DayOfWeek) {
            self.week = week
            self.dayOfWeek = dayOfWeek

            assert(week.map { (1...53).contains(abs($0)) } ?? true, "Week-of-year \(week.map(String.init) ?? "?") is not between 1 and 53 or -53 and -1 (each inclusive)")
        }

        public static func every(_ dayOfWeek: DayOfWeek) -> Self {
            Self(dayOfWeek: dayOfWeek)
        }

        public static func first(_ dayOfWeek: DayOfWeek) -> Self {
            Self(week: 1, dayOfWeek: dayOfWeek)
        }

        public static func last(_ dayOfWeek: DayOfWeek) -> Self {
            Self(week: -1, dayOfWeek: dayOfWeek)
        }
    }

    public init(
        frequency: Frequency,
        interval: Int? = nil,
        until: ICalendarDate? = nil,
        count: Int? = nil,
        bySecond: [Int]? = nil,
        byMinute: [Int]? = nil,
        byHour: [Int]? = nil,
        byDay: [Day]? = nil,
        byDayOfMonth: [Int]? = nil,
        byWeekOfYear: [Int]? = nil,
        byMonth: [Int]? = nil,
        bySetPos: [Int]? = nil,
        startOfWorkweek: DayOfWeek? = nil
    ) {
        self.frequency = frequency
        self.interval = interval
        self.until = until
        self.count = count
        self.bySecond = bySecond
        self.byMinute = byMinute
        self.byHour = byHour
        self.byDay = byDay
        self.byDayOfMonth = byDayOfMonth
        self.byWeekOfYear = byWeekOfYear
        self.byMonth = byMonth
        self.bySetPos = bySetPos
        self.startOfWorkweek = startOfWorkweek
    }
}
