import XCTest

@testable import ExpenseReport

final class LunchTests: XCTestCase {

    func testLunchExpense() throws {
        // Given
        let lunchExpense = try Expense(type: .lunch, amount: 1000)

        // When & Then
        XCTAssertTrue(lunchExpense.type.isMeal, "Lunch should be considered a meal")
        XCTAssertEqual(lunchExpense.type.limit, 2000, "Lunch should have limit of 2000")
        XCTAssertFalse(lunchExpense.isExceeded, "Lunch under limit should not be exceeded")
    }

    func testLunchExpenseExceeded() throws {
        // Given
        let lunchExpense = try Expense(type: .lunch, amount: 2500)

        // When & Then
        XCTAssertTrue(lunchExpense.isExceeded, "Lunch over 2000 should be exceeded")
    }
}
