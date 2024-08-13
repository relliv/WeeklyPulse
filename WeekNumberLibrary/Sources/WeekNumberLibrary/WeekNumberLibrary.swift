import Foundation

public struct WeekNumberCalculator {
    public init() {}

    public func getWeekNumber(of date: Date) -> Int {
        let calendar = Calendar.current
        let weekOfYear = calendar.component(.weekOfYear, from: date)

        return weekOfYear
    }
}
