/// The iCalendar object is organized into individual lines of text,
/// called content lines.  Content lines are delimited by a line break,
/// which is a CRLF sequence (CR character followed by LF character).
///
/// Lines of text SHOULD NOT be longer than 75 octets, excluding the line
/// break.  Long content lines SHOULD be split into a multiple line
/// representations using a line "folding" technique.  That is, a long
/// line can be split between any two characters by inserting a CRLF
/// immediately followed by a single linear white-space character (i.e.,
/// SPACE or HTAB).  Any sequence of CRLF followed immediately by a
/// single linear white-space character is ignored (i.e., removed) when
/// processing the content type.
public struct ICalendarContentLine: ICalendarEncodable {
    private static let maxLength: Int = 75

    public let key: String
    public let params: [(String, [String])]
    public let value: String

    public var iCalendarEncoded: String {
        let raw = "\(key)\(params.map { ";\($0.0)=\($0.1.joined(separator: ","))" }.joined()):\(value)\r\n"
        
        return raw
    }

    public init(key: String, params: [(String, [String])], value: String) {
        self.key = key
        self.params = params
        self.value = value
    }
}
