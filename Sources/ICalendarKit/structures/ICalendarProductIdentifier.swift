/// The identifier for the product that created the
/// iCalendar object.
///
/// See https://tools.ietf.org/html/rfc5545#section-3.7.3
public struct ICalendarProductIdentifier: ICalendarPropertyEncodable {
    public let segments: [String]

    public var iCalendarEncoded: String {
        "-\(segments.map { "//\($0)" }.joined())"
    }

    public init(segments: [String] = ["swift-icalendar", "swift-icalendar", "EN"]) {
        self.segments = segments
    }
}
