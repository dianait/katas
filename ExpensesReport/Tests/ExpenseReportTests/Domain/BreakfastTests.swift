import XCTest

@testable import ExpenseReport

final class BreakfastTests: XCTestCase {

    func testBreakfastExpense() throws {
        // Given
        let breakfastExpense = try Expense(type: .breakfast, amount: 800)

        // When & Then
        XCTAssertTrue(breakfastExpense.type.isMeal, "Breakfast should be considered a meal")
        XCTAssertEqual(breakfastExpense.type.limit, 1000, "Breakfast should have limit of 1000")
        XCTAssertFalse(breakfastExpense.isExceeded, "Breakfast under limit should not be exceeded")
    }

    func testBreakfastExpenseExceeded() throws {
        // Given
        let breakfastExpense = try Expense(type: .breakfast, amount: 1200)

        // When & Then
        XCTAssertTrue(breakfastExpense.isExceeded, "Breakfast over 1000 should be exceeded")
    }

    func testBreakfastExpenseAtLimit() throws {
        // Given
        let breakfastExpense = try Expense(type: .breakfast, amount: 1000)

        // When & Then
        XCTAssertFalse(breakfastExpense.isExceeded, "Breakfast at limit should not be exceeded")
    }
}
