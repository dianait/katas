struct Expense {
    var type: ExpenseType
    var amount: Int

    init(type: ExpenseType, amount: Int) throws {
        guard amount >= 0 else {
            throw ExpenseError.negativeAmount
        }
        self.type = type
        self.amount = amount
    }

    var isExceeded: Bool {
        type.limit.map { amount > $0 } ?? false
    }

    var description: String {
        return "\(type.displayName): \(amount)"
    }
}
