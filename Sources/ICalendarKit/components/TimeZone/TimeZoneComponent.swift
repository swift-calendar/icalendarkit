import VComponentKit

public struct ICalendarTimeZone: VComponent {
    public let component: String = "VTIMEZONE"

    /// This property defines the time zone, that
    /// will be use in the event.
    ///
    /// See https://tools.ietf.org/html/rfc5545#section-3.6.5
    public var tzid: String
    
    /// This property defines the value of the object `DaylightComponent`
    /// which is the standard time of the Time Zone.
    ///
    /// See https://tools.ietf.org/html/rfc5545#section-3.6.5
    public var daylight: DaylightComponent

    /// This property defines the value of the object `StandardComponent`
    /// which is the standard time of the Time Zone.
    ///
    /// See https://tools.ietf.org/html/rfc5545#section-3.6.5
    public var standard: StandardComponent

    public var properties: [VContentLine?] {
        [
            .line("TZID", tzid),
        ]
    }
    
    public var children: [VComponent] {
        [
            daylight,
            standard
        ]
    }
    
    public init(
        tzid: String,
        daylight: DaylightComponent,
        standard: StandardComponent
    ) {
        self.tzid = tzid
        self.daylight = daylight
        self.standard = standard
    }
}
