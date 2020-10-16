extension Int: ICalendarPropertyEncodable {
    public var iCalendarEncoded: String {
        String(self)
    }
}
