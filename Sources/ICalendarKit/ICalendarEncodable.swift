/// Represents something that can be encoded in
/// the iCalendar format.
public protocol ICalendarEncodable {
    var iCalendarEncoded: String { get }
}
