import XCTest

@testable import ExpenseReport

final class ExpenseTests: XCTestCase {

    // MARK: - Breakfast Tests

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

    // MARK: - Dinner Tests

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

    // MARK: - Lunch Tests

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

    // MARK: - CarRental Tests

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

    // MARK: - General Expense Tests

    func testExpenseWithNegativeAmount() throws {
        // Given & When & Then
        XCTAssertThrowsError(try Expense(type: .breakfast, amount: -100)) { error in
            XCTAssertEqual(error as? ExpenseError, .negativeAmount)
        }
    }

    func testExpenseDescription() throws {
        // Given
        let expense = try Expense(type: .breakfast, amount: 500)

        // When & Then
        XCTAssertEqual(
            expense.description, "Breakfast: 500", "Description should be formatted correctly")
    }

    func testExpenseWithZeroAmount() throws {
        // Given
        let expense = try Expense(type: .dinner, amount: 0)

        // When & Then
        XCTAssertEqual(expense.amount, 0, "Zero amount should be preserved")
        XCTAssertFalse(expense.isExceeded, "Zero amount should not be exceeded")
    }
}
