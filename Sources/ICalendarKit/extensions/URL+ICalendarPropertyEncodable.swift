import Foundation

extension URL: ICalendarPropertyEncodable {
    public var iCalendarEncoded: String {
        absoluteString
    }
}
