import XCTest

@testable import ExpenseReport

final class DinnerTests: XCTestCase {

    func testDinnerExpense() throws {
        // Given
        let dinnerExpense = try Expense(type: .dinner, amount: 4000)

        // When & Then
        XCTAssertTrue(dinnerExpense.type.isMeal, "Dinner should be considered a meal")
        XCTAssertEqual(dinnerExpense.type.limit, 5000, "Dinner should have limit of 5000")
        XCTAssertFalse(dinnerExpense.isExceeded, "Dinner under limit should not be exceeded")
    }

    func testDinnerExpenseExceeded() throws {
        // Given
        let dinnerExpense = try Expense(type: .dinner, amount: 6000)

        // When & Then
        XCTAssertTrue(dinnerExpense.isExceeded, "Dinner over 5000 should be exceeded")
    }

    func testDinnerExpenseAtLimit() throws {
        // Given
        let dinnerExpense = try Expense(type: .dinner, amount: 5000)

        // When & Then
        XCTAssertFalse(dinnerExpense.isExceeded, "Dinner at limit should not be exceeded")
    }
}
