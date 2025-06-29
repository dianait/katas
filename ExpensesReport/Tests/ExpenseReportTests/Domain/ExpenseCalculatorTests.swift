import XCTest

@testable import ExpenseReport

final class ExpenseCalculatorTests: XCTestCase {

    func testExpenseCalculatorWithLunch() throws {
        // Given
        let calculator = ExpenseCalculator()
        let expenses = [
            try Expense(type: .lunch, amount: 1500),
            try Expense(type: .lunch, amount: 2500),
            try Expense(type: .carRental, amount: 1000),
        ]

        // When
        let (total, meals) = calculator.calculateTotals(expenses: expenses)

        // Then
        XCTAssertEqual(meals, 4000, "Lunch expenses should be included in meal total")
        XCTAssertEqual(total, 5000, "Total should include all expenses")
    }

    func testExpenseCalculatorGetExceededExpenses() throws {
        // Given
        let calculator = ExpenseCalculator()
        let expenses = [
            try Expense(type: .lunch, amount: 2500),  // Excedido
            try Expense(type: .lunch, amount: 1500),  // No excedido
            try Expense(type: .breakfast, amount: 1200),  // Excedido
        ]

        // When
        let exceededExpenses = calculator.getExceededExpenses(expenses: expenses)

        // Then
        XCTAssertEqual(exceededExpenses.count, 2, "Should have 2 exceeded expenses")
        XCTAssertTrue(exceededExpenses.contains { $0.type == .lunch && $0.amount == 2500 })
        XCTAssertTrue(exceededExpenses.contains { $0.type == .breakfast && $0.amount == 1200 })
    }

    func testExpenseCalculatorGetMealExpenses() throws {
        // Given
        let calculator = ExpenseCalculator()
        let expenses = [
            try Expense(type: .lunch, amount: 1500),
            try Expense(type: .breakfast, amount: 800),
            try Expense(type: .carRental, amount: 1000),
        ]

        // When
        let mealExpenses = calculator.getMealExpenses(expenses: expenses)

        // Then
        XCTAssertEqual(mealExpenses.count, 2, "Should have 2 meal expenses")
        XCTAssertTrue(mealExpenses.contains { $0.type == .lunch })
        XCTAssertTrue(mealExpenses.contains { $0.type == .breakfast })
        XCTAssertFalse(mealExpenses.contains { $0.type == .carRental })
    }

    func testExpenseCalculatorEmptyExpenses() throws {
        // Given
        let calculator = ExpenseCalculator()
        let expenses: [Expense] = []

        // When
        let (total, meals) = calculator.calculateTotals(expenses: expenses)
        let exceededExpenses = calculator.getExceededExpenses(expenses: expenses)
        let mealExpenses = calculator.getMealExpenses(expenses: expenses)

        // Then
        XCTAssertEqual(total, 0, "Total should be 0 for empty expenses")
        XCTAssertEqual(meals, 0, "Meals should be 0 for empty expenses")
        XCTAssertTrue(exceededExpenses.isEmpty, "Exceeded expenses should be empty")
        XCTAssertTrue(mealExpenses.isEmpty, "Meal expenses should be empty")
    }
}
