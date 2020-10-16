/// Specifies a positive duration of time.
///
/// See https://tools.ietf.org/html/rfc5545#section-3.8.2.5
public struct ICalendarDuration: ICalendarPropertyEncodable {
    public var sign: Bool
    
    public var weeks: Int? = nil
    public var days: Int? = nil
    public var hours: Int? = nil
    public var minutes: Int? = nil
    public var seconds: Int? = nil

    public var iCalendarEncoded: String {
        var encodedDuration: String

        if let weeks = weeks {
            encodedDuration = "\(weeks)W"
        } else {
            encodedDuration = "\(days ?? 0)DT\(hours ?? 0)H\(minutes ?? 0)M\(seconds ?? 0)S"
        }

        return "\(sign ? "" : "-")P\(encodedDuration)"
    }

    public init(sign: Bool = true, weeks: Int) {
        self.sign = sign
        self.weeks = weeks
    }

    public init(sign: Bool = true, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) {
        self.sign = sign
        self.days = days
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
    }
}
