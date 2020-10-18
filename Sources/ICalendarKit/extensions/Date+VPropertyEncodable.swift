import Foundation
import VComponentKit

extension Date: VPropertyEncodable {
    public var vEncoded: String {
        ICalendarDate(date: self).vEncoded
    }
}
