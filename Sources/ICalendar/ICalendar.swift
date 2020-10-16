/// A collection of calendaring and scheduling information.
///
/// See https://tools.ietf.org/html/rfc5545#section-3.4
public struct ICalendar: ICalendarEncodable {
    private static let component = "VCALENDAR"

    /// The identifier corresponding to the highest version number
    /// or the minimum and maximum range of the iCalendar specification
    /// that is required in order to interpret the iCalendar object.
    ///
    /// See https://tools.ietf.org/html/rfc5545#section-3.7.4
    private static let version = "2.0"

    /// The identifier for the product that created the iCalendar
    /// object.
    ///
    /// See https://tools.ietf.org/html/rfc5545#section-3.7.3
    private static let prodid = "-//swift-icalendar"

    /// The calendar scale for the calendar information specified
    /// in this iCalendar object.
    ///
    /// See https://tools.ietf.org/html/rfc5545#section-3.7.1
    public var calscale: String?

    /// The iCalendar object method associated with the calendar
    /// object.
    ///
    /// See https://tools.ietf.org/html/rfc5545#section-3.7.2
    public var method: String?

    public var events: [ICalendarEvent]
    public var toDos: [ICalendarToDo]
    public var freeBusies: [ICalendarFreeBusy]
    public var journals: [ICalendarJournal]
    public var timeZones: [ICalendarTimeZone]
    public var alarms: [ICalendarAlarm]

    public var components: [ICalendarComponent] {
        [events, toDos, journals, freeBusies, timeZones, alarms].flatMap { $0 as! [ICalendarComponent] }
    }

    public var iCalendarEncoded: String {
        [
            "BEGIN:\(Self.component)\r\n",
            "VERSION:\(Self.version)\r\n",
            "PRODID:\(Self.prodid)\r\n",
            calscale.map { "CALSCALE:\($0)\r\n" },
            method.map { "METHOD:\($0)\r\n" },
            "END:\(Self.component)\r\n"
        ].compactMap { $0 }.joined()
    }

    public init(
        calscale: String? = "GREGORIAN",
        method: String? = nil,
        events: [ICalendarEvent] = [],
        toDos: [ICalendarToDo] = [],
        freeBusies: [ICalendarFreeBusy] = [],
        journals: [ICalendarJournal] = [],
        timeZones: [ICalendarTimeZone] = [],
        alarms: [ICalendarAlarm] = []
    ) {
        self.calscale = calscale
        self.method = method
        self.events = events
        self.toDos = toDos
        self.freeBusies = freeBusies
        self.journals = journals
        self.timeZones = timeZones
        self.alarms = alarms
    }
}
