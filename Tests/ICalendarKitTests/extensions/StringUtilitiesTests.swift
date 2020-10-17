import XCTest
import Foundation
@testable import ICalendarKit

final class StringUtilitiesTests: XCTestCase {
    static var allTests = [
        ("testChunks", testChunks)
    ]

    func testChunks() throws {
        XCTAssertEqual("".chunks(ofLength: 1), [""])
        XCTAssertEqual("test".chunks(ofLength: 1), "test".map { String($0) })
        XCTAssertEqual("test".chunks(ofLength: 2), ["te", "st"])
        XCTAssertEqual("test".chunks(ofLength: 3), ["tes", "t"])
        XCTAssertEqual("test".chunks(ofLength: 4), ["test"])
        XCTAssertEqual("test".chunks(ofLength: 5), ["test"])
    }
}
