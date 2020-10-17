import Foundation

extension Date: ICalendarPropertyEncodable {
    public var iCalendarEncoded: String {
        ICalendarDate(date: self).iCalendarEncoded
    }
}
