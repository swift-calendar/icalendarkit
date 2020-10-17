/// The iCalendar object is organized into individual lines of text,
/// called content lines.  Content lines are delimited by a line break,
/// which is a CRLF sequence (CR character followed by LF character).
///
/// See https://tools.ietf.org/html/rfc5545#section-3.1
public struct ICalendarContentLine: ICalendarEncodable {
    private static let maxLength: Int = 75

    public let key: String
    public let value: ICalendarPropertyEncodable

    public var iCalendarEncoded: String {
        let params = value.parameters
        let raw = "\(key)\(params.map { ";\($0.0)=\($0.1.joined(separator: ","))" }.joined()):\(value.iCalendarEncoded)"
        let chunks = raw.chunks(ofLength: Self.maxLength)
        assert(!chunks.isEmpty)

        // From the RFC (section 3.1):
        //
        // Lines of text SHOULD NOT be longer than 75 octets, excluding the line
        // break.  Long content lines SHOULD be split into a multiple line
        // representations using a line "folding" technique.  That is, a long
        // line can be split between any two characters by inserting a CRLF
        // immediately followed by a single linear white-space character (i.e.,
        // SPACE or HTAB).  Any sequence of CRLF followed immediately by a
        // single linear white-space character is ignored (i.e., removed) when
        // processing the content type.

        return chunks
            .enumerated()
            .map { (i, c) in i > 0 ? " \(c)" : c }
            .map { "\($0)\r\n" }
            .joined()
    }

    public init?(key: String, value: ICalendarPropertyEncodable) {
        self.key = key
        self.value = value
    }

    public static func line(_ key: String, _ value: ICalendarPropertyEncodable?) -> ICalendarContentLine? {
        guard let value = value else { return nil }
        return ICalendarContentLine(key: key, value: value)
    }
}
