import Foundation

/// Provides a grouping of component properties that
/// describes an event.
///
/// See https://tools.ietf.org/html/rfc5545#section-3.6.1
public struct ICalendarEvent: ICalendarComponent {
    public let component: String = "VEVENT"

    /// In the case of an iCalendar object that specifies a
    /// "METHOD" property, this property specifies the date and time that
    /// the instance of the iCalendar object was created.  In the case of
    /// an iCalendar object that doesn't specify a "METHOD" property, this
    /// property specifies the date and time that the information
    /// associated with the calendar component was last revised in the
    /// calendar store.
    ///
    /// See https://tools.ietf.org/html/rfc5545#section-3.8.7.2
    public var dtstamp: Date
    /// This property defines the persistent, globally unique
    /// identifier for the calendar component.
    ///
    /// See https://tools.ietf.org/html/rfc5545#section-3.8.4.7
    public var uid: String

    /// This property defines the access classification for a
    /// calendar component.
    ///
    /// See https://tools.ietf.org/html/rfc5545#section-3.8.1.3
    public var classification: String?
    /// This property specifies the date and time that the calendar
    /// information was created by the calendar user agent in the calendar
    /// store.
    /// 
    /// Note: This is analogous to the creation date and time for a
    /// file in the file system.
    ///
    /// See https://tools.ietf.org/html/rfc5545#section-3.8.7.1
    public var created: Date?
    /// This property specifies when the calendar component begins.
    ///
    /// See https://tools.ietf.org/html/rfc5545#section-3.8.2.4
    public var description: String?
    /// This property specifies when the calendar component begins.
    ///
    /// See https://tools.ietf.org/html/rfc5545#section-3.8.2.4
    public var dtstart: ICalendarDate?
    /// This property specifi9es information related to the global
    /// position for the activity specified by a calendar component.
    ///
    /// See https://tools.ietf.org/html/rfc5545#section-3.8.1.6
    public var geo: ICalendarGeographicPosition?
    /// This property specifies the date and time that the
    /// information associated with the calendar component was last
    /// revised in the calendar store.
    ///
    /// Note: This is analogous to the modification date and time for a
    /// file in the file system.
    ///
    /// See https://tools.ietf.org/html/rfc5545#section-3.8.7.3
    public var lastModified: Date?
    /// This property defines the intended venue for the activity
    /// for the activity.
    ///
    /// See https://tools.ietf.org/html/rfc5545#section-3.8.1.7
    public var location: String?
    /// This property defines the organizer for a calendar component.
    ///
    /// See https://tools.ietf.org/html/rfc5545#section-3.8.4.3
    public var organizer: String? // TODO: Add more structure
    /// This property defines the relative priority for a calendar component.
    ///
    /// See https://tools.ietf.org/html/rfc5545#section-3.8.1.9
    public var priority: Int?
    /// This property defines the revision sequence number of the
    /// calendar component within a sequence of revisions.
    ///
    /// See https://tools.ietf.org/html/rfc5545#section-3.8.7.4
    public var seq: Int?
    /// This property defines the overall status or confirmation
    /// for the calendar component.
    ///
    /// See https://tools.ietf.org/html/rfc5545#section-3.8.1.11
    public var status: String?
    /// This property defines a short summary or subject for the
    /// calendar component.
    ///
    /// See https://tools.ietf.org/html/rfc5545#section-3.8.1.12
    public var summary: String?
    /// This property defines whether or not an event is
    /// transparent to busy time searches.
    ///
    /// See https://tools.ietf.org/html/rfc5545#section-3.8.2.7
    public var transp: String?
    /// This property defines a Uniform Resource Locator (URL)
    /// associated with the iCalendar object.
    ///
    /// See https://tools.ietf.org/html/rfc5545#section-3.8.4.6
    public var url: URL?
    /// This property is used in conjunction with the "UID" and
    /// "SEQUENCE" properties to identify a specific instance of a
    /// recurring "VEVENT", "VTODO", or "VJOURNAL" calendar component.
    /// The property value is the original value of the "DTSTART" property
    /// of the recurrence instance.
    ///
    /// See https://tools.ietf.org/html/rfc5545#section-3.8.4.4
    public var recurrenceId: Date?
    /// This property defines a rule or repeating pattern for
    /// recurring events, to-dos, journal entries, or time zone
    /// definitions.
    ///
    /// See https://tools.ietf.org/html/rfc5545#section-3.8.5.3
    public var rrule: String? // TODO: Add more structure

    // Mutually exclusive specifications of end date

    /// This property specifies the date and time that a calendar
    /// component ends.
    ///
    /// Must have the same 'ignoreTime'-value as tstart.
    /// Mutually exclusive to 'due'.
    ///
    /// See https://tools.ietf.org/html/rfc5545#section-3.8.2.2
    public var dtend: ICalendarDate? {
        willSet { duration = nil }
    }
    /// This property specifies a positive duration of time.
    ///
    /// Mutually exclusive to 'due'.
    ///
    /// See https://tools.ietf.org/html/rfc5545#section-3.8.2.5
    public var duration: ICalendarDuration? {
        willSet { dtend = nil }
    }

    // TODO: Define properties that can be specified multiple times:
    // public var attachments
    // public var attendees
    // public var categories
    // public var comments
    // public var contacts
    // public var exdates
    // public var rstatus
    // public var related
    // public var rdates

    public var alarms: [ICalendarAlarm]
    public var children: [ICalendarComponent] { alarms }

    public var properties: [ICalendarContentLine?] {
        [
            .line("DTSTAMP", dtstamp),
            .line("UID", uid),
            .line("CLASS", classification),
            .line("CREATED", created),
            .line("DESCRIPTION", description),
            .line("DTSTART", dtstart),
            .line("GEO", geo),
            .line("LAST-MODIFIED", lastModified),
            .line("LOCATION", location),
            .line("ORGANIZER", organizer),
            .line("PRIORITY", priority),
            .line("SEQ", seq),
            .line("STATUS", status),
            .line("SUMMARY", summary),
            .line("TRANSP", transp),
            .line("URL", url),
            .line("RECURRENCE-ID", recurrenceId),
            .line("RRULE", rrule),
            .line("DTEND", dtend),
            .line("DURATION", duration)
        ]
    }

    public init(
        dtstamp: Date = Date(),
        uid: String = UUID().uuidString,
        classification: String? = nil,
        created: Date? = Date(),
        description: String? = nil,
        dtstart: ICalendarDate? = nil,
        geo: ICalendarGeographicPosition? = nil,
        lastModified: Date? = Date(),
        location: String? = nil,
        organizer: String? = nil,
        priority: Int? = nil,
        seq: Int? = nil,
        status: String? = nil,
        summary: String? = nil,
        transp: String? = nil,
        url: URL? = nil,
        recurrenceId: Date? = nil,
        rrule: String? = nil,
        dtend: ICalendarDate? = nil,
        duration: ICalendarDuration? = nil,
        alarms: [ICalendarAlarm] = []
    ) {
        self.dtstamp = dtstamp
        self.uid = uid
        self.classification = classification
        self.created = created
        self.description = description
        self.dtstart = dtstart
        self.geo = geo
        self.lastModified = lastModified
        self.location = location
        self.organizer = organizer
        self.priority = priority
        self.seq = seq
        self.status = status
        self.summary = summary
        self.transp = transp
        self.url = url
        self.recurrenceId = recurrenceId
        self.rrule = rrule
        self.dtend = dtend
        self.duration = duration
        self.alarms = alarms

        assert(dtend == nil || duration == nil, "End date/time and duration must not be specified together!")
    }
}
