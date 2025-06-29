import XCTest

@testable import ExpenseReport

final class ExpenseTypeTests: XCTestCase {

    func testExpenseTypeDisplayNames() throws {
        // When & Then
        XCTAssertEqual(ExpenseType.breakfast.displayName, "Breakfast")
        XCTAssertEqual(ExpenseType.dinner.displayName, "Dinner")
        XCTAssertEqual(ExpenseType.lunch.displayName, "Lunch")
        XCTAssertEqual(ExpenseType.carRental.displayName, "Car Rental")
    }

    func testExpenseTypeLimits() throws {
        // When & Then
        XCTAssertEqual(ExpenseType.breakfast.limit, 1000)
        XCTAssertEqual(ExpenseType.dinner.limit, 5000)
        XCTAssertEqual(ExpenseType.lunch.limit, 2000)
        XCTAssertNil(ExpenseType.carRental.limit)
    }

    func testExpenseTypeIsMeal() throws {
        // When & Then
        XCTAssertTrue(ExpenseType.breakfast.isMeal)
        XCTAssertTrue(ExpenseType.dinner.isMeal)
        XCTAssertTrue(ExpenseType.lunch.isMeal)
        XCTAssertFalse(ExpenseType.carRental.isMeal)
    }

    func testExpenseTypeRawValues() throws {
        // When & Then
        XCTAssertEqual(ExpenseType.breakfast.rawValue, "breakfast")
        XCTAssertEqual(ExpenseType.dinner.rawValue, "dinner")
        XCTAssertEqual(ExpenseType.lunch.rawValue, "lunch")
        XCTAssertEqual(ExpenseType.carRental.rawValue, "carRental")
    }
}
