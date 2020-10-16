/// A component of an iCalendar.
public protocol ICalendarComponent: ICalendarEncodable {
    /// The component's 'type' that is used in the BEGIN/END
    /// declaration.
    var component: String { get }

    /// The component's properties.
    var properties: [ICalendarContentLine?] { get }

    /// The component's children.
    var children: [ICalendarComponent] { get }
}

public extension ICalendarComponent {
    var properties: [ICalendarContentLine?] { [] }
    var children: [ICalendarComponent] { [] }

    var contentLines: [ICalendarContentLine?] {
        [.line("BEGIN", component)] + properties + children.flatMap(\.contentLines) + [.line("END", component)]
    }

    var iCalendarEncoded: String {
        contentLines
            .compactMap { $0?.iCalendarEncoded }
            .joined()
    }
}
