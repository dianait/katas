# 🏰 Refactorización - Gilded Rose Kata

## 🎯 Objetivo

Este proyecto muestra la refactorización completa de la kata Gilded Rose, implementando el patrón Strategy para eliminar el código duplicado y mejorar la mantenibilidad. La solución utiliza estrategias específicas para cada tipo de item, siguiendo principios de Clean Code y patrones de diseño.

## 🔧 Problema Original

La kata Gilded Rose presenta un sistema de gestión de inventario donde diferentes tipos de items tienen reglas específicas para actualizar su calidad y fecha de venta. El código original tenía múltiples condicionales anidados que hacían difícil la lectura y mantenimiento.

## 🚀 Solución Implementada: Patrón Strategy

### **Arquitectura del Sistema**

```
Sources/
  GildedRose/
    ├── GildedRose.swift           (Cliente del patrón Strategy)
    ├── Item.swift                 (Modelo de datos)
    └── ItemUpdateStrategy.swift   (Interfaz y estrategias)
```

### **Componentes Principales**

#### **1. GildedRose (Cliente)**

```swift
public class GildedRose {
    enum Types: String, CaseIterable {
        case aged = "Aged Brie"
        case conjured = "Conjured"
        case sulfuras = "Sulfuras, Hand of Ragnaros"
        case backStage = "Backstage passes to a TAFKAL80ETC concert"
    }

    private lazy var strategies: [String: ItemUpdateStrategy] = [
        Types.aged.rawValue: AgedStrategy(),
        Types.backStage.rawValue: BackstageStrategy(),
        Types.conjured.rawValue: ConjuredStrategy(),
        Types.sulfuras.rawValue: SulfurasStrategy()
    ]

    public func updateQuality() {
        for item in items {
            let strategy = strategyFor(item.name)
            strategy.update(item)
        }
    }
}
```

#### **2. ItemUpdateStrategy (Interfaz)**

```swift
protocol ItemUpdateStrategy {
    func update(_ item: Item)
}
```

#### **3. Estrategias Específicas**

**AgedStrategy** - Para "Aged Brie":

```swift
class AgedStrategy: ItemUpdateStrategy {
    func update(_ item: Item) {
        item.sellIn = item.sellIn - 1
        QualityBounds.increaseQuality(item)

        if item.sellIn < 0 {
            QualityBounds.increaseQuality(item)
        }
    }
}
```

**BackstageStrategy** - Para entradas de concierto:

```swift
class BackstageStrategy: ItemUpdateStrategy {
    func update(_ item: Item) {
        item.sellIn = item.sellIn - 1
        QualityBounds.increaseQuality(item)

        if item.sellIn < 11 {
            QualityBounds.increaseQuality(item)
        }
        if item.sellIn < 6 {
            QualityBounds.increaseQuality(item)
        }
        if item.sellIn < 0 {
            item.quality = 0
        }
    }
}
```

**ConjuredStrategy** - Para items encantados:

```swift
class ConjuredStrategy: ItemUpdateStrategy {
    func update(_ item: Item) {
        item.sellIn = item.sellIn - 1
        QualityBounds.decreaseQuality(item, by: 2)

        if item.sellIn < 0 {
            QualityBounds.decreaseQuality(item, by: 2)
        }
    }
}
```

**SulfurasStrategy** - Para items legendarios:

```swift
class SulfurasStrategy: ItemUpdateStrategy {
    func update(_: Item) {}
}
```

**DefaultStrategy** - Para items normales:

```swift
class DefaultStrategy: ItemUpdateStrategy {
    func update(_ item: Item) {
        item.sellIn = item.sellIn - 1
        QualityBounds.decreaseQuality(item)

        if item.sellIn < 0 {
            QualityBounds.decreaseQuality(item)
        }
    }
}
```

## 🛡️ QualityBounds - Gestión de Límites

```swift
enum QualityBounds {
    static let MAX_QUALITY = 50
    static let MIN_QUALITY = 0

    static func increaseQuality(_ item: Item, by amount: Int = 1) {
        if item.quality < QualityBounds.MAX_QUALITY {
            let maxIncrease = QualityBounds.MAX_QUALITY - item.quality
            let increase = min(amount, maxIncrease)
            item.quality = item.quality + increase
        }
    }

    static func decreaseQuality(_ item: Item, by amount: Int = 1) {
        if item.quality > QualityBounds.MIN_QUALITY {
            let maxIncrease = item.quality - QualityBounds.MIN_QUALITY
            let decrease = min(amount, maxIncrease)
            item.quality = item.quality - decrease
        }
    }
}
```

## 📋 Reglas de Negocio Implementadas

### **Items Normales**

- ✅ Calidad disminuye en 1 cada día
- ✅ Calidad disminuye en 2 después de la fecha de venta
- ✅ Calidad nunca es menor a 0

### **Aged Brie**

- ✅ Calidad aumenta en 1 cada día
- ✅ Calidad aumenta en 2 después de la fecha de venta
- ✅ Calidad nunca excede 50

### **Sulfuras, Hand of Ragnaros**

- ✅ Calidad y sellIn nunca cambian
- ✅ Calidad siempre es 80

### **Backstage Passes**

- ✅ Calidad aumenta en 1 cuando sellIn > 10
- ✅ Calidad aumenta en 2 cuando 6 ≤ sellIn ≤ 10
- ✅ Calidad aumenta en 3 cuando sellIn ≤ 5
- ✅ Calidad se convierte en 0 después de la fecha de venta

### **Conjured Items**

- ✅ Calidad disminuye en 2 cada día
- ✅ Calidad disminuye en 4 después de la fecha de venta
- ✅ Calidad nunca es menor a 0

## 🧪 Tests Implementados

### **Cobertura de Tests**

```
Tests/
  GildedRoseTests/
    └── GildedRoseTests.swift
        ├── Normal Items (4 tests)
        ├── Aged Brie (3 tests)
        ├── Sulfuras (1 test)
        ├── Backstage (3 tests)
        └── Conjured (2 tests)
```

### **Ejemplos de Tests**

```swift
// Test para items normales
func testUpdateQuality_shouldDecreseQualityAndSellIn_forNormalItems() throws {
    let items = [Item(name: "Normal Item", sellIn: 5, quality: 10)]
    let app = GildedRose(items: items)
    app.updateQuality()

    XCTAssertEqual(app.items[0].quality, 9)
    XCTAssertEqual(app.items[0].sellIn, 4)
}

// Test para Aged Brie
func testUpdateQuality_shouldIncreaseQuality_forAgedBrieItems() throws {
    let items = [Item(name: "Aged Brie", sellIn: 5, quality: 10)]
    let app = GildedRose(items: items)
    app.updateQuality()

    XCTAssertEqual(app.items[0].quality, 11)
    XCTAssertEqual(app.items[0].sellIn, 4)
}
```

## 🎮 Aplicación de Demostración

### **main.swift**

```swift
let items = [
    Item(name: "+5 Dexterity Vest", sellIn: 10, quality: 20),
    Item(name: "Aged Brie", sellIn: 2, quality: 0),
    Item(name: "Elixir of the Mongoose", sellIn: 5, quality: 7),
    Item(name: "Sulfuras, Hand of Ragnaros", sellIn: 0, quality: 80),
    Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 15, quality: 20),
    Item(name: "Conjured Mana Cake", sellIn: 3, quality: 6),
]

let app = GildedRose(items: items)
app.updateQuality()
```

### **Salida de Ejemplo**

```
-------- day 0 --------
name, sellIn, quality
+5 Dexterity Vest, 10, 20
Aged Brie, 2, 0
Elixir of the Mongoose, 5, 7
Sulfuras, Hand of Ragnaros, 0, 80
Backstage passes to a TAFKAL80ETC concert, 15, 20
Conjured Mana Cake, 3, 6

-------- day 1 --------
name, sellIn, quality
+5 Dexterity Vest, 9, 19
Aged Brie, 1, 1
Elixir of the Mongoose, 4, 6
Sulfuras, Hand of Ragnaros, 0, 80
Backstage passes to a TAFKAL80ETC concert, 14, 21
Conjured Mana Cake, 2, 4
```

## 🏗️ Ventajas del Patrón Strategy

### **Antes (Código Original)**

```swift
// Múltiples condicionales anidados
if (item.name != "Aged Brie" && item.name != "Backstage passes to a TAFKAL80ETC concert") {
    if (item.quality > 0) {
        if (item.name != "Sulfuras, Hand of Ragnaros") {
            item.quality = item.quality - 1
        }
    }
} else {
    if (item.quality < 50) {
        item.quality = item.quality + 1
        if (item.name == "Backstage passes to a TAFKAL80ETC concert") {
            if (item.sellIn < 11) {
                if (item.quality < 50) {
                    item.quality = item.quality + 1
                }
            }
            // ... más condicionales
        }
    }
}
```

### **Después (Patrón Strategy)**

```swift
// Código limpio y extensible
public func updateQuality() {
    for item in items {
        let strategy = strategyFor(item.name)
        strategy.update(item)
    }
}
```

## 📊 Beneficios Obtenidos

| Aspecto                   | Antes      | Después    |
| ------------------------- | ---------- | ---------- |
| **Líneas de código**      | 50+        | 80+        |
| **Complejidad**           | ⭐⭐⭐⭐⭐ | ⭐⭐       |
| **Legibilidad**           | ⭐⭐       | ⭐⭐⭐⭐⭐ |
| **Mantenibilidad**        | ⭐⭐       | ⭐⭐⭐⭐⭐ |
| **Extensibilidad**        | ⭐⭐       | ⭐⭐⭐⭐⭐ |
| **Testabilidad**          | ⭐⭐       | ⭐⭐⭐⭐⭐ |
| **Principio Open/Closed** | ❌         | ✅         |

## 🎯 Principios SOLID Aplicados

### **Single Responsibility Principle (SRP)**

- Cada estrategia tiene una única responsabilidad
- `QualityBounds` maneja solo los límites de calidad

### **Open/Closed Principle (OCP)**

- Abierto para extensión (nuevas estrategias)
- Cerrado para modificación (no tocar código existente)

### **Dependency Inversion Principle (DIP)**

- `GildedRose` depende de abstracciones (`ItemUpdateStrategy`)
- No depende de implementaciones concretas

## 🚀 Cómo Usar

### **Compilar y Ejecutar Tests**

```bash
# Desde la línea de comandos
swift test

# Ejecutar la aplicación
swift run GildedRoseApp
```

### **Agregar Nuevo Tipo de Item**

1. Crear nueva estrategia implementando `ItemUpdateStrategy`
2. Agregar el tipo al enum `Types`
3. Registrar la estrategia en el diccionario `strategies`

```swift
// Ejemplo: Agregar "Legendary Sword"
class LegendarySwordStrategy: ItemUpdateStrategy {
    func update(_ item: Item) {
        // Lógica específica para espadas legendarias
    }
}

// En GildedRose
enum Types: String, CaseIterable {
    // ... tipos existentes
    case legendarySword = "Legendary Sword"
}

private lazy var strategies: [String: ItemUpdateStrategy] = [
    // ... estrategias existentes
    Types.legendarySword.rawValue: LegendarySwordStrategy()
]
```

## 🎉 Resultado Final

La refactorización logra:

- ✅ **Código limpio** y fácil de leer
- ✅ **Fácil mantenimiento** y extensión
- ✅ **Tests completos** para todas las funcionalidades
- ✅ **Patrón Strategy** bien implementado
- ✅ **Principios SOLID** aplicados correctamente
- ✅ **Separación de responsabilidades** clara
- ✅ **Gestión de límites** centralizada
- ✅ **Extensibilidad** para nuevos tipos de items

---

## 📝 Lecciones Aprendidas

1. **Patrón Strategy es poderoso** - Elimina condicionales complejos
2. **Separación de responsabilidades** - Cada clase tiene un propósito claro
3. **Tests específicos** - Validan cada regla de negocio por separado
4. **Gestión de límites** - Centralizar lógica de validación mejora la mantenibilidad
5. **Extensibilidad** - Agregar nuevos tipos es trivial
6. **Clean Code** - Código legible y autodocumentado
7. **Principios SOLID** - Aplicados correctamente mejoran la arquitectura

---

## 🔗 Referencias

- [Gilded Rose Kata](https://github.com/emilybache/GildedRose-Refactoring-Kata)
- [Patrón Strategy](https://refactoring.guru/design-patterns/strategy)
- [Principios SOLID](https://en.wikipedia.org/wiki/SOLID)
