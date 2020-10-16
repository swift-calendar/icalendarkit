/// Specifies information related to the global position for
/// the activity specified by a calendar component.
///
/// See https://tools.ietf.org/html/rfc5545#section-3.8.1.6
public struct ICalendarGeographicPosition: ICalendarPropertyEncodable {
    public let latitude: Double
    public let longitude: Double

    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }

    public var iCalendarEncoded: String {
        "\(latitude);\(longitude)"
    }
}
