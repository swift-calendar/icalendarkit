import VComponentKit

/// Specifies information related to the global position for
/// the activity specified by a calendar component.
///
/// See https://tools.ietf.org/html/rfc5545#section-3.8.1.6
public struct ICalendarGeographicPosition: VPropertyEncodable {
    public let latitude: Double
    public let longitude: Double

    public var vEncoded: String {
        "\(latitude);\(longitude)"
    }

    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
