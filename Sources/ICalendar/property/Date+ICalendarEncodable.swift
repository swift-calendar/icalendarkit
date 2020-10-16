import Foundation

public extension Date: ICalendarEncodable {
    var iCalendarEncoded: String {
        let formatter = DateFormatter()
        formatter.format = "yyyyMMdd'T'HHmmss'Z'"
        formatter.string(from: self)
    }
}
