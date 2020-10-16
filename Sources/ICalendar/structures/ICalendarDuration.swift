/// Specifies a positive duration of time.
///
/// See https://tools.ietf.org/html/rfc5545#section-3.8.2.5
public struct ICalendarDuration: ICalendarEncodable {
    public var negative: Bool
    
    public var weeks: Int?
    public var days: Int?
    public var hours: Int?
    public var minutes: Int?
    public var seconds: Int?

    public var iCalendarEncoded: String {
        var encodedDuration: String

        if let weeks = weeks {
            encodedDuration = "\(weeks)W"
        } else {
            encodedDuration = "\(days ?? 0)D\(hours ?? 0)H\(minutes ?? 0)M\(seconds ?? 0)S"
        }

        return "\(negative ? "-" : "")P\(encodedDuration)"
    }
}
