import VComponentKit

/*
 BEGIN:VTIMEZONE
     TZID:America/Mexico_City

     BEGIN:DAYLIGHT
         TZOFFSETFROM:-0600
         RRULE:FREQ=YEARLY;BYMONTH=4;BYDAY=1SU
         DTSTART:20020407T020000
         TZNAME:CDT
         TZOFFSETTO:-0500
     END:DAYLIGHT

     BEGIN:STANDARD
         TZOFFSETFROM:-0500
         RRULE:FREQ=YEARLY;BYMONTH=10;BYDAY=-1SU
         DTSTART:20021027T020000
         TZNAME:CST
         TZOFFSETTO:-0600
     END:STANDARD
 END:VTIMEZONE
 */


public struct ICalendarTimeZone: VComponent {
    public let component: String = "VTIMEZONE"

    /*public var tzid: String
    
    public var properties: [VContentLine?] {
        [
            .line("TZID", tzid),
        ]
    }
    
    public init(
        tzid: String
    ) {
        self.tzid = tzid
    }*/
}
