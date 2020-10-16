/// A component of an iCalendar.
public protocol ICalendarComponent: ICalendarEncodable {
    /// The component's 'type' that is used in the BEGIN/END
    /// declaration.
    var component: String { get }

    /// The component's properties.
    var properties: [(String, String?)] { get }

    /// The component's children.
    var children: [ICalendarComponent] { get }
}

public extension ICalendarComponent {
    var properties: [(String, String?)] { [] }
    var children: [ICalendarComponent] { [] }

    var propertiesForEncoding: [(String, String?)] {
        [("BEGIN", component)] + properties + children.flatMap(\.propertiesForEncoding) + [("END", component)]
    }

    var iCalendarEncoded: String {
        propertiesForEncoding
            .compactMap { (key, value) in value.map { "\(key): \($0)\r\n" } }
            .joined()
    }
}
