import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ICalendarTests.allTests),
        testCase(ICalendarRecurrenceRuleTests.allTests),
        testCase(ICalendarDurationTests.allTests)
    ]
}
#endif
