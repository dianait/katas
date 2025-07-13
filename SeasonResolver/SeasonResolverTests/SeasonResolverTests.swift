import Foundation
@testable import SeasonResolver
import XCTest

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

    func testRandomSpringDates() {
        for _ in 1 ... 5 {
            let randomDate = RandomDateGenerator.randomSpringDate()
            XCTAssertEqual(try resolver.getSeason(from: randomDate), .spring)
        }
    }

    func testRandomSummerDates() {
        for _ in 1 ... 5 {
            let randomDate = RandomDateGenerator.randomSummerDate()
            XCTAssertEqual(try resolver.getSeason(from: randomDate), .summer)
        }
    }

    func testRandomAutumnDates() {
        for _ in 1 ... 5 {
            let randomDate = RandomDateGenerator.randomAutumnDate()
            XCTAssertEqual(try resolver.getSeason(from: randomDate), .autumn)
        }
    }

    func testRandomWinterDates() {
        for _ in 1 ... 5 {
            let randomDate = RandomDateGenerator.randomWinterDate()
            XCTAssertEqual(try resolver.getSeason(from: randomDate), .winter)
        }
    }

    private func createTestDate(month: Int, day: Int, year: Int = 2024) -> Date {
         var components = DateComponents()
         components.year = year
         components.month = month
         components.day = day
         return Calendar.current.date(from: components) ?? Date()
     }

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

}
