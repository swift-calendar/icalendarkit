import VComponentKit

public struct ICalendarTimeZone: VComponent {
    public let component: String = "VTIMEZONE"

    public var tzid: String
    
    public var daylight: DaylightComponent

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
