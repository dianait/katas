import Foundation

struct RandomDateGenerator {

    /// Genera una fecha aleatoria de primavera (21 marzo - 20 junio)
    static func randomSpringDate() -> Date {
        let month = Int.random(in: 3...6)
        let day: Int

        switch month {
        case 3: day = Int.random(in: 21...31)
        case 4, 5: day = Int.random(in: 1...30)
        case 6: day = Int.random(in: 1...20)
        default: day = 15
        }

        return createDate(month: month, day: day)
    }

    /// Genera una fecha aleatoria de verano (21 junio - 20 septiembre)
    static func randomSummerDate() -> Date {
        let month = Int.random(in: 6...9)
        let day: Int

        switch month {
        case 6: day = Int.random(in: 21...30)
        case 7, 8: day = Int.random(in: 1...31)
        case 9: day = Int.random(in: 1...20)
        default: day = 15
        }

        return createDate(month: month, day: day)
    }

    /// Genera una fecha aleatoria de otoño (21 septiembre - 20 diciembre)
    static func randomAutumnDate() -> Date {
        let month = Int.random(in: 9...12)
        let day: Int

        switch month {
        case 9: day = Int.random(in: 21...30)
        case 10, 11: day = Int.random(in: 1...30)
        case 12: day = Int.random(in: 1...20)
        default: day = 15
        }

        return createDate(month: month, day: day)
    }

    /// Genera una fecha aleatoria de invierno (21 diciembre - 20 marzo)
    static func randomWinterDate() -> Date {
        let winterMonths = [12, 1, 2, 3]
        let month = winterMonths.randomElement()!
        let day: Int

        switch month {
        case 12: day = Int.random(in: 21...31)
        case 1, 2: day = Int.random(in: 1...28)
        case 3: day = Int.random(in: 1...20)
        default: day = 15
        }

        return createDate(month: month, day: day)
    }

    // MARK: - Private

    private static func createDate(month: Int, day: Int, year: Int = 2024) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        return Calendar.current.date(from: components) ?? Date()
    }
}
