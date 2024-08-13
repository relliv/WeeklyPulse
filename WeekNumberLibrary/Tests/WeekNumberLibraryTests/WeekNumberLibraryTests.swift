import XCTest
@testable import WeekNumberLibrary

final class WeekNumberTests: XCTestCase {
    func testWeekNumber() {
        let calculator = WeekNumberCalculator()
        let date = Date()
        let weekNumber = calculator.getWeekNumber(of: date)
        
        XCTAssertTrue(weekNumber > 0 && weekNumber <= 53, "Week number should be between 1 and 53")
    }
}
