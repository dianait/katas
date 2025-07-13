# 🚀 Katas de Refactorización - Swift

## 📋 Descripción General
Este repositorio contiene una colección de katas de refactorización implementadas en Swift, siguiendo principios de Clean Code, patrones de diseño y mejores prácticas de desarrollo. Cada kata ha sido completamente refactorizada para eliminar code smells y mejorar la calidad del código.

## 📁 Estructura del Proyecto
```
katas/
├── README.md                    (Este archivo)
├── ExpensesReport/              (Kata de Reporte de Gastos)
├── Gilded Rose/                 (Kata de Gestión de Inventario)
└── SeasonDetector/              (Kata de Detección de Estaciones)
```

## 🎪 Katas Implementadas

### 1. 📋 [Expenses Report](ExpensesReport/README.md)
**Kata Original:** [christianhujer/expensereport](https://github.com/christianhujer/expensereport)

**Problema:** Sistema de reportes de gastos con múltiples code smells

**Solución:** Refactorización completa aplicando:
- ✅ **Eliminación de Magic Numbers**
- ✅ **Refactorización de Switch Statements**
- ✅ **Separación de responsabilidades**
- ✅ **Implementación de Value Types**
- ✅ **Arquitectura Hexagonal**
- ✅ **TDD para nueva funcionalidad (Lunch)**

**Tecnologías:** Swift, TDD, Arquitectura Hexagonal

**Estado:** ✅ Completado

---

### 2. 🏰 [Gilded Rose](Gilded%20Rose/README.md)
**Kata Original:** [emilybache/GildedRose-Refactoring-Kata](https://github.com/emilybache/GildedRose-Refactoring-Kata)

**Problema:** Sistema de gestión de inventario con condicionales complejos

**Solución:** Implementación del patrón Strategy:
- ✅ **Patrón Strategy** para diferentes tipos de items
- ✅ **Eliminación de condicionales anidados**
- ✅ **Separación de lógica de negocio**
- ✅ **Gestión centralizada de límites**
- ✅ **Tests completos** para cada estrategia

**Tecnologías:** Swift, Patrón Strategy, Principios SOLID

**Estado:** ✅ Completado

---

### 3. 🌸 [Season Detector](SeasonDetector/README.md)
**Kata Inspirada en:** [Testing: Introduction and Best Practices](https://codely.com/en/courses/testing-introduction-and-best-practices-o9me) de Codely

**Problema:** Crear un detector de estaciones que determine a qué estación pertenece una fecha dada

**Solución:** Implementación con enfoque en testing y refactoring progresivo:
- ✅ **Eliminación de números mágicos**
- ✅ **Algoritmo eficiente** de conversión numérica (mes*100+día)
- ✅ **Manejo especial del invierno** (cruza años)
- ✅ **Tests con fechas fijas y aleatorias**
- ✅ **Generador de fechas extraído** a archivo separado
- ✅ **Arquitectura simple y mantenible**

**Tecnologías:** Swift, XCTest, Librería Estática

**Estado:** ✅ Completado

---

## 📊 Métricas del Proyecto

| Kata           | Líneas de Código | Tests        | Code Smells Eliminados | Patrones Aplicados       |
| -------------- | ---------------- | ------------ | ---------------------- | ------------------------ |
| ExpensesReport | 87               | 7 archivos   | 6                      | Arquitectura Hexagonal   |
| Gilded Rose    | 80+              | 13 tests     | 5+                     | Strategy Pattern         |
| Season Detector| 60+              | 5 test files | 3                      | Extracción de Generadores|

## 📝 Licencia
Este proyecto está bajo la licencia MIT. Ver el archivo [LICENSE](LICENSE) para más detalles.
