import Foundation

struct ExpenseReport {
    private let calculator = ExpenseCalculator()
    func printReport(expenses: [Expense]) throws {
        print("Expense Report \(Date())")
        for expense in expenses {
            printExpense(expense: expense)
        }
        printTotalExpenses(expenses: expenses)
    }

    private func printExpense(expense: Expense) {
        let isExededMark = expense.isExceeded ? "❌" : " "
        print("\(expense.description)\t\(isExededMark)")
    }

    private func printTotalExpenses(expenses: [Expense]) {
        let (total, meals) = calculator.calculateTotals(expenses: expenses)
        print("Meal Expenses: \(meals)")
        print("Total Expenses: \(total)")
    }
}
