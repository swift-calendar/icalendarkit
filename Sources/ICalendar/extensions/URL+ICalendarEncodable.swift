import Foundation

extension URL: ICalendarEncodable {
    public var iCalendarEncoded: String {
        absoluteString
    }
}
