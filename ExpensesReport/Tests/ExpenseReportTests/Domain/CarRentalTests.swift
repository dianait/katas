import XCTest

@testable import ExpenseReport

final class CarRentalTests: XCTestCase {

    func testCarRentalExpense() throws {
        // Given
        let carRentalExpense = try Expense(type: .carRental, amount: 3000)

        // When & Then
        XCTAssertFalse(carRentalExpense.type.isMeal, "Car rental should not be considered a meal")
        XCTAssertNil(carRentalExpense.type.limit, "Car rental should not have a limit")
        XCTAssertFalse(
            carRentalExpense.isExceeded, "Car rental should never be exceeded (no limit)")
    }

    func testCarRentalExpenseHighAmount() throws {
        // Given
        let carRentalExpense = try Expense(type: .carRental, amount: 10000)

        // When & Then
        XCTAssertFalse(
            carRentalExpense.isExceeded, "Car rental with high amount should not be exceeded")
        XCTAssertEqual(carRentalExpense.amount, 10000, "Amount should be preserved")
    }

    func testCarRentalExpenseDisplayName() throws {
        // Given
        let carRentalExpense = try Expense(type: .carRental, amount: 1000)

        // When & Then
        XCTAssertEqual(
            carRentalExpense.type.displayName, "Car Rental", "Display name should be 'Car Rental'")
        XCTAssertEqual(
            carRentalExpense.description, "Car Rental: 1000",
            "Description should be formatted correctly")
    }
}
