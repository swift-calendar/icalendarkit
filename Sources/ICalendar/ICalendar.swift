/// A collection of calendaring and scheduling information.
///
/// See https://tools.ietf.org/html/rfc5545#section-3.4
public struct ICalendar: ICalendarEncodable {
    private static let object = "VCALENDAR"
    private static let version = "2.0"

    public var iCalendarEncoded: String {
        [
            "BEGIN:\(Self.object)\r\n",
            "VERSION:\(Self.version)\r\n",
            "END:\(Self.object)\r\n"
        ].joined()
    }
}
