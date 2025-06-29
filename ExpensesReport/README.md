# 📋 Refactorización - ExpenseReport Kata

## 🎯 Objetivo

Este proyecto muestra la refactorización completa de una kata de ExpenseReport, eliminando todos los code smells identificados para mejorar la legibilidad, mantenibilidad y calidad del código. Posteriormente se implementó la nueva funcionalidad de Lunch usando TDD (Test-Driven Development) y se organizó siguiendo principios de arquitectura hexagonal.

## 🔧 Code Smells Identificados y Solucionados

### 1. Magic Numbers ❌ → ✅

**Problema:** Valores hardcodeados sin significado

```swift
// ANTES
expense.amount > 5000 || expense.amount > 1000

// DESPUÉS
let BREAKFAST_EXPENSE_LIMIT = 1000
let DINNER_EXPENSE_LIMIT = 5000
let LUNCH_EXPENSE_LIMIT = 2000
```

### 2. Switch Statement ❌ → ✅

**Problema:** Switch redundante para mapear enum a string

```swift
// ANTES
switch expense.type {
case .breakfast: expenseName = "Breakfast"
case .dinner: expenseName = "Dinner"
case .carRental: expenseName = "Car Rental"
}

// DESPUÉS
enum ExpenseType: String {
    case breakfast, dinner, lunch, carRental
    var displayName: String { rawValue.capitalized }
}
```

### 3. Método Muy Largo ❌ → ✅

**Problema:** Un método hacía demasiadas cosas

```swift
// ANTES
func printReport(expenses: [Expense]) {
    // 30+ líneas de código mezclando lógica
}

// DESPUÉS
func printReport(expenses: [Expense]) throws {
    printHeader()
    for expense in expenses { printExpense(expense) }
    printTotalExpenses(expenses)
}
```

### 4. Código Duplicado ❌ → ✅

**Problema:** Switch statement duplicado

```swift
// ANTES
// Switch en enum + switch en método

// DESPUÉS
// Solo computed properties en el enum
```

### 5. Lógica Compleja ❌ → ✅

**Problema:** Condiciones complejas en una línea

```swift
// ANTES
let marker = expense.type == .dinner && expense.amount > 5000 ||
             expense.type == .breakfast && expense.amount > 1000 ? "X" : " "

// DESPUÉS
var isExceeded: Bool { amount > type.limit ?? 0 }
let marker = expense.isExceeded ? "X" : " "
```

### 6. Lógica de Negocio Mezclada ❌ → ✅

**Problema:** Lógica de "¿qué es una comida?" hardcodeada

```swift
// ANTES
if expense.type == .dinner || expense.type == .breakfast

// DESPUÉS
var isMeal: Bool { [.breakfast, .dinner, .lunch].contains(self) }
if expense.type.isMeal
```

## 🚀 Mejoras Adicionales Implementadas

### 7. Optimización de Enum

```swift
// Diccionario para límites (más eficiente)
private static let limits: [ExpenseType: Int] = [
    .breakfast: BREAKFAST_EXPENSE_LIMIT,
    .dinner: DINNER_EXPENSE_LIMIT,
    .lunch: LUNCH_EXPENSE_LIMIT
]
```

### 8. Validaciones

```swift
init(type: ExpenseType, amount: Int) throws {
    guard amount >= 0 else { throw ExpenseError.negativeAmount }
    // ...
}
```

### 9. Separación de Responsabilidades

```swift
// Nueva clase para cálculos
struct ExpenseCalculator {
    func calculateTotals(expenses: [Expense]) -> (total: Int, meals: Int)
    func getExceededExpenses(expenses: [Expense]) -> [Expense]
    func getMealExpenses(expenses: [Expense]) -> [Expense]
}
```

### 10. Conversión a Value Types

```swift
// Todas las clases convertidas a structs
struct ExpenseCalculator { ... }
struct ExpenseReport { ... }
struct Expense { ... }
```

### 11. Arquitectura Hexagonal

```swift
Sources/
  ExpenseReport/
    ├── Domain/
    │   ├── Expense.swift
    │   ├── ExpenseType.swift
    │   ├── ExpenseCalculator.swift
    │   └── ExpenseError.swift
    └── Application/
        └── ExpenseReport.swift
```

## 🧪 Implementación de Lunch usando TDD

### **Proceso TDD seguido:**

#### **1. Red (Red) - Escribir tests que fallen**

```swift
func testLunchExpense() throws {
    let lunchExpense = try Expense(type: .lunch, amount: 1000)
    XCTAssertTrue(lunchExpense.type.isMeal, "Lunch should be considered a meal")
    XCTAssertEqual(lunchExpense.type.limit, 2000, "Lunch should have limit of 2000")
    XCTAssertFalse(lunchExpense.isExceeded, "Lunch under limit should not be exceeded")
}
```

#### **2. Green (Green) - Implementar funcionalidad mínima**

- Agregar `.lunch` al enum `ExpenseType`
- Agregar `LUNCH_EXPENSE_LIMIT = 2000`
- Incluir lunch en `isMeal` y en el diccionario de límites

#### **3. Refactor (Refactor) - Mejorar el código**

- Separar tests en archivos específicos
- Convertir clases a structs
- Crear `ExpenseCalculator` para separar responsabilidades
- Organizar tests siguiendo arquitectura hexagonal

### **Nueva funcionalidad implementada:**

- ✅ **Lunch** con límite de 2000
- ✅ **Tests específicos** para cada tipo de gasto
- ✅ **Arquitectura modular** con separación de responsabilidades
- ✅ **Value types** para mejor rendimiento

## 🏗️ Arquitectura del Proyecto

### **Estructura de Código Fuente:**

```
Sources/
  ExpenseReport/
    ├── Domain/
    │   ├── Expense.swift              (Entidad principal)
    │   ├── ExpenseType.swift          (Enum del dominio)
    │   ├── ExpenseCalculator.swift    (Servicio de dominio)
    │   └── ExpenseError.swift         (Errores del dominio)
    └── Application/
        └── ExpenseReport.swift        (Caso de uso)
```

### **Estructura de Tests:**

```
Tests/
  ExpenseReportTests/
    └── Domain/
        ├── ExpenseTests.swift           (Tests generales de la entidad)
        ├── ExpenseTypeTests.swift       (Tests del enum)
        ├── ExpenseCalculatorTests.swift (Tests de cálculos)
        ├── BreakfastTests.swift         (Tests específicos de Breakfast)
        ├── DinnerTests.swift            (Tests específicos de Dinner)
        ├── LunchTests.swift             (Tests específicos de Lunch)
        └── CarRentalTests.swift         (Tests específicos de CarRental)
```

### **Principios de Arquitectura Aplicados:**

#### **Domain Layer (Dominio)**

- **Entidades puras** - `Expense`, `ExpenseType`
- **Servicios de dominio** - `ExpenseCalculator`
- **Lógica de negocio** - Límites, validaciones, cálculos
- **Sin dependencias externas** - Independiente de frameworks

#### **Application Layer (Aplicación)**

- **Casos de uso** - `ExpenseReport`
- **Orquestación** - Coordina la lógica de dominio
- **Interfaz de usuario** - Generación de reportes

#### **Value Types**

- **Structs en lugar de clases** - Mejor rendimiento y seguridad
- **Inmutabilidad** - Sin efectos secundarios
- **Thread safety** - Seguro para concurrencia

## 📊 Métricas de Mejora

| Aspecto                 | Antes      | Después    |
| ----------------------- | ---------- | ---------- |
| **Líneas de código**    | 58         | 87         |
| **Métodos**             | 1          | 4          |
| **Computed properties** | 0          | 6          |
| **Constantes**          | 0          | 3          |
| **Manejo de errores**   | ❌         | ✅         |
| **Tests organizados**   | 1 archivo  | 7 archivos |
| **Value types**         | 0%         | 100%       |
| **Arquitectura**        | Monolítica | Hexagonal  |
| **Legibilidad**         | ⭐⭐       | ⭐⭐⭐⭐⭐ |
| **Mantenibilidad**      | ⭐⭐       | ⭐⭐⭐⭐⭐ |

## 🎉 Resultado Final

El código transformado es:

- ✅ **Limpio** y fácil de leer
- ✅ **Mantenible** y escalable
- ✅ **Eficiente** y optimizado
- ✅ **Profesional** con manejo de errores
- ✅ **Siguiendo Clean Code** y mejores prácticas de Swift
- ✅ **Testeado completamente** con TDD
- ✅ **Arquitectura modular** con separación de responsabilidades
- ✅ **Value types** para mejor rendimiento y seguridad
- ✅ **Organización hexagonal** siguiendo principios de arquitectura

---

## 📝 Código Final Refactorizado

### **Domain/ExpenseType.swift**

```swift
import Foundation

let BREAKFAST_EXPENSE_LIMIT = 1000
let DINNER_EXPENSE_LIMIT = 5000
let LUNCH_EXPENSE_LIMIT = 2000

enum ExpenseError: Error {
    case negativeAmount
}

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
```

### **Domain/Expense.swift**

```swift
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
```

### **Domain/ExpenseCalculator.swift**

```swift
struct ExpenseCalculator {
    func calculateTotals(expenses: [Expense]) -> (total: Int, meals: Int) {
        let total = expenses.reduce(0) { $0 + $1.amount }
        let meals = expenses.filter { $0.type.isMeal }
                           .reduce(0) { $0 + $1.amount }
        return (total, meals)
    }

    func getExceededExpenses(expenses: [Expense]) -> [Expense] {
        return expenses.filter { $0.isExceeded }
    }

    func getMealExpenses(expenses: [Expense]) -> [Expense] {
        return expenses.filter { $0.type.isMeal }
    }
}
```

### **Application/ExpenseReport.swift**

```swift
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
```

---

## 🚀 Cómo Usar

```swift
let report = ExpenseReport()
let expenses = [
    try Expense(type: .breakfast, amount: 1200),
    try Expense(type: .lunch, amount: 1500),
    try Expense(type: .dinner, amount: 6000),
    try Expense(type: .carRental, amount: 3000)
]

try report.printReport(expenses: expenses)
```

**Salida esperada:**

```
Expense Report Jan 15, 2024
Breakfast: 1200	❌
Lunch: 1500
Dinner: 6000	❌
Car Rental: 3000
Meal Expenses: 8700
Total Expenses: 11700
```

---

## 🎯 Lecciones Aprendidas

1. **TDD es poderoso** - Escribir tests primero ayuda a diseñar mejor la API
2. **Value types son mejores** - Structs proporcionan mejor rendimiento y seguridad
3. **Separación de responsabilidades** - Cada clase/struct debe tener una responsabilidad clara
4. **Tests organizados** - Separar tests por funcionalidad mejora la mantenibilidad
5. **Refactorización incremental** - Los cambios pequeños y graduales son más seguros
6. **Arquitectura hexagonal** - Separar dominio de aplicación mejora la testabilidad
7. **Organización de tests** - Reflejar la estructura del código fuente facilita la navegación
