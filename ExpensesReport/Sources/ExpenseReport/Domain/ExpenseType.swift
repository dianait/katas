let BREAKFAST_EXPENSE_LIMIT = 1000
let DINNER_EXPENSE_LIMIT = 5000
let LUNCH_EXPENSE_LIMIT = 2000

enum ExpenseType: String {
    case breakfast
    case dinner
    case lunch
    case carRental

    private static let limits: [ExpenseType: Int] = [
        .breakfast: BREAKFAST_EXPENSE_LIMIT,
        .dinner: DINNER_EXPENSE_LIMIT,
        .lunch: LUNCH_EXPENSE_LIMIT,
    ]

    var limit: Int? {
        return Self.limits[self]
    }

    var displayName: String {
        switch self {
        case .carRental: return "Car Rental"
        default: return rawValue.capitalized
        }
    }

    var isMeal: Bool {
        [.breakfast, .dinner, .lunch].contains(self)
    }
}
