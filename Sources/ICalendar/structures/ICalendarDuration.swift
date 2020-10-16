fileprivate let second: Int64 = 1
fileprivate let minute: Int64 = second * 60
fileprivate let hour: Int64 = minute * 60
fileprivate let day: Int64 = hour * 24
fileprivate let week: Int64 = day * 7

/// Specifies a positive duration of time.
///
/// See https://tools.ietf.org/html/rfc5545#section-3.8.2.5
public struct ICalendarDuration: ICalendarPropertyEncodable, AdditiveArithmetic {
    public static let zero: ICalendarDuration = ICalendarDuration(totalSeconds: 0)

    /// The total seconds of this day.
    public var totalSeconds: Int64

    public var parts: (weeks: Int, days: Int, hours: Int, minutes: Int, seconds: Int) {
        let weeks = totalSeconds / week
        let rest1 = totalSeconds % week
        let days = rest1 / day
        let rest2 = rest1 % day
        let hours = rest2 / hour
        let rest3 = rest2 % hour
        let minutes = rest3 / minute
        let rest4 = rest3 % minute
        let seconds = rest4 / second

        return (weeks: Int(weeks), days: Int(days), hours: Int(hours), minutes: Int(minutes), seconds: Int(seconds))
    }
    
    public var iCalendarEncoded: String {
        var encodedDuration: String
        let (weeks, days, hours, minutes, seconds) = parts

        if weeks != 0 {
            encodedDuration = "\(weeks)W"
        } else {
            encodedDuration = "\(days)DT\(hours)H\(minutes)M\(seconds)S"
        }

        return "\(totalSeconds >= 0 ? "" : "-")P\(encodedDuration)"
    }

    public init(totalSeconds: Int64 = 0) {
        self.totalSeconds = totalSeconds
    }

    public init(integerLiteral: Int64) {
        self.init(totalSeconds: integerLiteral)
    }

    public mutating func negate() {
        totalSeconds.negate()
    }

    public static prefix func -(operand: Self) -> Self {
        Self(totalSeconds: -operand.totalSeconds)
    }

    public static func +(lhs: Self, rhs: Self) -> Self {
        Self(totalSeconds: lhs.totalSeconds + rhs.totalSeconds)
    }

    public static func -(lhs: Self, rhs: Self) -> Self {
        Self(totalSeconds: lhs.totalSeconds - rhs.totalSeconds)
    }

    public static func weeks(_ weeks: Int) -> Self {
        Self(totalSeconds: Int64(weeks) * week)
    }

    public static func days(_ days: Int) -> Self {
        Self(totalSeconds: Int64(days) * day)
    }

    public static func hours(_ hours: Int) -> Self {
        Self(totalSeconds: Int64(hours) * hour)
    }

    public static func minutes(_ minutes: Int) -> Self {
        Self(totalSeconds: Int64(minutes) * minute)
    }
    
    public static func seconds(_ seconds: Int) -> Self {
        Self(totalSeconds: Int64(seconds) * second)
    }
}
