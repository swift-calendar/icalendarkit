/// Represents something that can be encoded in
/// the iCalendar format, but may require additional
/// parameters in the content line.
public protocol ICalendarPropertyEncodable: ICalendarEncodable {
    var parameters: [(String, [String])] { get }
}

public extension ICalendarPropertyEncodable {
    var parameters: [(String, [String])] { [] }
}
