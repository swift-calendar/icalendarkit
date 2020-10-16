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

    public enum Weekday: String, ICalendarEncodable {
        case monday = "MO"
        case tuesday = "TU"
        case wednesday = "WE"
        case thursday = "TH"
        case friday = "FR"
        case saturday = "SA"
        case sunday = "SU"

        public var iCalendarEncoded: String { rawValue }
    }

    // TODO: Initializer
}
