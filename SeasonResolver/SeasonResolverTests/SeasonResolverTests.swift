import XCTest
import Foundation
@testable import SeasonResolver

class SeasonResolverTests: XCTestCase {

    var resolver: SeasonResolver!

    override func setUp() {
        super.setUp()
        resolver = SeasonResolver()
    }

    override func tearDown() {
        resolver = nil
        super.tearDown()
    }

    // MARK: - Helper Methods

    private func createTestDate(month: Int, day: Int, year: Int = 2024) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        return Calendar.current.date(from: components) ?? Date()
    }

    // MARK: - Spring Tests

    func testSpringStartDate() {
        let date = createTestDate(month: 3, day: 21)
        XCTAssertNoThrow(try resolver.getSeason(from: date))
        XCTAssertEqual(try resolver.getSeason(from: date), .spring, "21 de marzo debería ser inicio de primavera")
    }

    func testSpringMiddleDate() {
        let date = createTestDate(month: 4, day: 15)
        XCTAssertNoThrow(try resolver.getSeason(from: date))
        XCTAssertEqual(try resolver.getSeason(from: date), .spring, "15 de abril debería ser primavera")
    }

    func testSpringEndDate() {
        let date = createTestDate(month: 6, day: 20)
        XCTAssertNoThrow(try resolver.getSeason(from: date))
        XCTAssertEqual(try resolver.getSeason(from: date), .spring, "20 de junio debería ser fin de primavera")
    }

    // MARK: - Summer Tests

    func testSummerStartDate() {
        let date = createTestDate(month: 6, day: 21)
        XCTAssertNoThrow(try resolver.getSeason(from: date))
        XCTAssertEqual(try resolver.getSeason(from: date), .summer, "21 de junio debería ser inicio de verano")
    }

    func testSummerMiddleDate() {
        let date = createTestDate(month: 7, day: 15)
        XCTAssertNoThrow(try resolver.getSeason(from: date))
        XCTAssertEqual(try resolver.getSeason(from: date), .summer, "15 de julio debería ser verano")
    }

    func testSummerEndDate() {
        let date = createTestDate(month: 9, day: 20)
        XCTAssertNoThrow(try resolver.getSeason(from: date))
        XCTAssertEqual(try resolver.getSeason(from: date), .summer, "20 de septiembre debería ser fin de verano")
    }

    // MARK: - Autumn Tests

    func testAutumnStartDate() {
        let date = createTestDate(month: 9, day: 21)
        XCTAssertNoThrow(try resolver.getSeason(from: date))
        XCTAssertEqual(try resolver.getSeason(from: date), .autumn, "21 de septiembre debería ser inicio de otoño")
    }

    func testAutumnMiddleDate() {
        let date = createTestDate(month: 10, day: 31)
        XCTAssertNoThrow(try resolver.getSeason(from: date))
        XCTAssertEqual(try resolver.getSeason(from: date), .autumn, "31 de octubre debería ser otoño")
    }

    func testAutumnEndDate() {
        let date = createTestDate(month: 12, day: 20)
        XCTAssertNoThrow(try resolver.getSeason(from: date))
        XCTAssertEqual(try resolver.getSeason(from: date), .autumn, "20 de diciembre debería ser fin de otoño")
    }

    // MARK: - Winter Tests

    func testWinterStartDate() {
        let date = createTestDate(month: 12, day: 21)
        XCTAssertNoThrow(try resolver.getSeason(from: date))
        XCTAssertEqual(try resolver.getSeason(from: date), .winter, "21 de diciembre debería ser inicio de invierno")
    }

    func testWinterMiddleDate() {
        let date = createTestDate(month: 1, day: 15)
        XCTAssertNoThrow(try resolver.getSeason(from: date))
        XCTAssertEqual(try resolver.getSeason(from: date), .winter, "15 de enero debería ser invierno")
    }

    func testWinterEndDate() {
        let date = createTestDate(month: 3, day: 20)
        XCTAssertNoThrow(try resolver.getSeason(from: date))
        XCTAssertEqual(try resolver.getSeason(from: date), .winter, "20 de marzo debería ser fin de invierno")
    }

    // MARK: - Edge Cases Tests

    func testAllSeasonsInSingleTest() {
        let testCases: [(Date, Season, String)] = [
            // Primavera
            (createTestDate(month: 3, day: 21), .spring, "21 marzo"),
            (createTestDate(month: 4, day: 15), .spring, "15 abril"),
            (createTestDate(month: 6, day: 20), .spring, "20 junio"),

            // Verano
            (createTestDate(month: 6, day: 21), .summer, "21 junio"),
            (createTestDate(month: 7, day: 15), .summer, "15 julio"),
            (createTestDate(month: 9, day: 20), .summer, "20 septiembre"),

            // Otoño
            (createTestDate(month: 9, day: 21), .autumn, "21 septiembre"),
            (createTestDate(month: 10, day: 31), .autumn, "31 octubre"),
            (createTestDate(month: 12, day: 20), .autumn, "20 diciembre"),

            // Invierno
            (createTestDate(month: 12, day: 21), .winter, "21 diciembre"),
            (createTestDate(month: 1, day: 15), .winter, "15 enero"),
            (createTestDate(month: 3, day: 20), .winter, "20 marzo")
        ]

        for (date, expectedSeason, description) in testCases {
            XCTAssertNoThrow(try resolver.getSeason(from: date), "No debería lanzar error para \(description)")
            XCTAssertEqual(try resolver.getSeason(from: date), expectedSeason, "Fecha \(description) debería ser \(expectedSeason.rawValue)")
        }
    }

    // MARK: - Performance Tests

    func testPerformanceOfSeasonDetection() {
        let testDate = createTestDate(month: 7, day: 15)

        measure {
            for _ in 0..<1000 {
                _ = try? resolver.getSeason(from: testDate)
            }
        }
    }
}
