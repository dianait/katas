import XCTest
import Foundation
@testable import SeasonResolver

class SeasonResolverTests: XCTestCase {
    var sut: SeasonResolver!

    override func setUp() {
        super.setUp()
        sut = SeasonResolver()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testRandomSpringDates() {
        for _ in 1 ... 5 {
            let randomDate = RandomDateGenerator.randomSpringDate()
            XCTAssertEqual(try sut.getSeason(from: randomDate), .spring)
        }
    }

    func testRandomSummerDates() {
        for _ in 1 ... 5 {
            let randomDate = RandomDateGenerator.randomSummerDate()
            XCTAssertEqual(try sut.getSeason(from: randomDate), .summer)
        }
    }

    func testRandomAutumnDates() {
        for _ in 1 ... 5 {
            let randomDate = RandomDateGenerator.randomAutumnDate()
            XCTAssertEqual(try sut.getSeason(from: randomDate), .autumn)
        }
    }

    func testRandomWinterDates() {
        for _ in 1 ... 5 {
            let randomDate = RandomDateGenerator.randomWinterDate()
            XCTAssertEqual(try sut.getSeason(from: randomDate), .winter)
        }
    }
}
