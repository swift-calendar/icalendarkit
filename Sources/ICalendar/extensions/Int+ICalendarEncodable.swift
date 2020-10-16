extension Int: ICalendarEncodable {
    public var iCalendarEncoded: String {
        String(self)
    }
}
