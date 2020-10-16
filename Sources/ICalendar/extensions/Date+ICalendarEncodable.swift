import Foundation

extension Date: ICalendarEncodable {
    public var iCalendarEncoded: String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyyMMdd'T'HHmmss"
        return formatter.string(from: self)
    }
}
