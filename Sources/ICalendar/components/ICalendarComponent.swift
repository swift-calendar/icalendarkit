/// A component of an iCalendar.
public protocol ICalendarComponent {
    /// The component's 'type' that is used in the BEGIN/END
    /// declaration.
    var component: String { get }
}
