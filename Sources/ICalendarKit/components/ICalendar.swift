import VComponentKit

/// A collection of calendaring and scheduling information.
///
/// See https://tools.ietf.org/html/rfc5545#section-3.4
public struct ICalendar: VComponent {
    public let component = "VCALENDAR"

    /// The identifier corresponding to the highest version number
    /// or the minimum and maximum range of the iCalendar specification
    /// that is required in order to interpret the iCalendar object.
    ///
    /// See https://tools.ietf.org/html/rfc5545#section-3.7.4
    public let version = "2.0"

    /// The identifier for the product that created the iCalendar
    /// object.
    ///
    /// See https://tools.ietf.org/html/rfc5545#section-3.7.3
    public var prodid: ICalendarProductIdentifier

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

    public var children: [VComponent] {
        [events, toDos, journals, freeBusies, timeZones, alarms].flatMap { $0 as! [VComponent] }
    }

    public var properties: [VContentLine?] {
        [
            .line("VERSION", version),
            .line("PRODID", prodid),
            .line("CALSCALE", calscale),
            .line("METHOD", method)
        ]
    }

    public init(
        prodid: ICalendarProductIdentifier = ICalendarProductIdentifier(),
        calscale: String? = "GREGORIAN",
        method: String? = nil,
        events: [ICalendarEvent] = [],
        toDos: [ICalendarToDo] = [],
        freeBusies: [ICalendarFreeBusy] = [],
        journals: [ICalendarJournal] = [],
        timeZones: [ICalendarTimeZone] = [],
        alarms: [ICalendarAlarm] = []
    ) {
        self.prodid = prodid
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
