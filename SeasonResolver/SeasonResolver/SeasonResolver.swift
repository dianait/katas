import Foundation

enum Season: String {
    case spring, summer, autumn, winter
}

enum SeasonError: Error {
    case notFound
}

struct SeasonData {
    let season: Season
    let startMonth: Int
    let startDay: Int
    let endMonth: Int
    let endDay: Int

    var startValue: Int { startMonth * 100 + startDay }
    var endValue: Int { endMonth * 100 + endDay }

    func contains(monthDay: Int) -> Bool {
        if season == .winter {
            // Invierno cruza el año: dic-mar
            return monthDay >= startValue || monthDay <= endValue
        } else {
            return monthDay >= startValue && monthDay <= endValue
        }
    }
}

struct SeasonResolver {

    private let seasons: [SeasonData] = [
        SeasonData(season: .spring, startMonth: 3, startDay: 21, endMonth: 6, endDay: 20),
        SeasonData(season: .summer, startMonth: 6, startDay: 21, endMonth: 9, endDay: 20),
        SeasonData(season: .autumn, startMonth: 9, startDay: 21, endMonth: 12, endDay: 20),
        SeasonData(season: .winter, startMonth: 12, startDay: 21, endMonth: 3, endDay: 20)
    ]

    func getSeason(from date: Date) throws -> Season {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month, .day], from: date)
        guard let month = components.month, let day = components.day else {
            throw SeasonError.notFound
        }

        let monthDay = month * 100 + day

        for seasonData in seasons {
            if seasonData.contains(monthDay: monthDay) {
                return seasonData.season
            }
        }

        throw SeasonError.notFound
    }
}
