import Foundation

public struct WeekNumberCalculator {
    public init() {}

    public func getWeekNumber(of date: Date) -> Int {
        let calendar = Calendar.current
        let weekOfYear = calendar.component(.weekOfYear, from: date)

        return weekOfYear
    }

    public func getYearProgress() -> Double {
        let now = Date()
        let calendar = Calendar.current
        let startOfYear = calendar.date(from: calendar.dateComponents([.year], from: now))!
        let endOfYear = calendar.date(byAdding: .year, value: 1, to: startOfYear)!
        let totalSeconds = endOfYear.timeIntervalSince(startOfYear)
        let elapsedSeconds = now.timeIntervalSince(startOfYear)

        return elapsedSeconds / totalSeconds
    }
}
