struct ExpenseCalculator {
    func calculateTotals(expenses: [Expense]) -> (total: Int, meals: Int) {
        let total = expenses.reduce(0) { $0 + $1.amount }
        let meals = expenses.filter { $0.type.isMeal }
            .reduce(0) { $0 + $1.amount }
        return (total, meals)
    }
}
