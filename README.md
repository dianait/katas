# 🚀 Katas de Refactorización - Swift

## 📋 Descripción General

Este repositorio contiene una colección de katas de refactorización implementadas en Swift, siguiendo principios de Clean Code, patrones de diseño y mejores prácticas de desarrollo. Cada kata ha sido completamente refactorizada para eliminar code smells y mejorar la calidad del código.

## 📁 Estructura del Proyecto

```
katas/
├── README.md                    (Este archivo)
├── ExpensesReport/              (Kata de Reporte de Gastos)
└── Gilded Rose/                 (Kata de Gestión de Inventario)
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

## 📊 Métricas del Proyecto

| Kata           | Líneas de Código | Tests      | Code Smells Eliminados | Patrones Aplicados     |
| -------------- | ---------------- | ---------- | ---------------------- | ---------------------- |
| ExpensesReport | 87               | 7 archivos | 6                      | Arquitectura Hexagonal |
| Gilded Rose    | 80+              | 13 tests   | 5+                     | Strategy Pattern       |

## 📝 Licencia

Este proyecto está bajo la licencia MIT. Ver el archivo [LICENSE](LICENSE) para más detalles.

---

**¡Disfruta explorando las katas y aprendiendo técnicas de refactorización efectivas! 🚀**
