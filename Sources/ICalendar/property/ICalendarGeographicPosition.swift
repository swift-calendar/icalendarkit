public struct ICalendarGeographicPosition: ICalendarEncodable {
    public let latitude: Double
    public let longitude: Double

    public var iCalendarEncoded: String {
        "\(latitude);\(longitude)"
    }
}
