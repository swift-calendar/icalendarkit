import Foundation

/// Provides a grouping of component properties that
/// describes an event.
///
/// See https://tools.ietf.org/html/rfc5545#section-3.6.1
public struct ICalendarEvent: ICalendarComponent {
    public let component: String = "VEVENT"

    public var dtstamp: Date
    public var uid: String

    public var eventClass: String?
    public var completed: Date?
    public var created: Date?
    public var description: String?
    public var dtstart: Date?
    public var geo: ICalendarGeographicPosition

    public var alarms: [ICalendarAlarm]
    public var children: [ICalendarComponent] { alarms }
}
