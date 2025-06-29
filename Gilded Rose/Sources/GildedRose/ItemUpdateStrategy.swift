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

protocol ItemUpdateStrategy {
    func update(_ item: Item)
}

class SulfurasStrategy: ItemUpdateStrategy {
    func update(_: Item) {}
}

class AgedStrategy: ItemUpdateStrategy {
    func update(_ item: Item) {
        item.sellIn = item.sellIn - 1
        QualityBounds.increaseQuality(item)

        if item.sellIn < 0 {
            QualityBounds.increaseQuality(item)
        }
    }
}

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

class ConjuredStrategy: ItemUpdateStrategy {
    func update(_ item: Item) {
        item.sellIn = item.sellIn - 1

        QualityBounds.decreaseQuality(item, by: 2)

        if item.sellIn < 0 {
            QualityBounds.decreaseQuality(item, by: 2)
        }
    }
}

class DefaultStrategy: ItemUpdateStrategy {
    func update(_ item: Item) {
        item.sellIn = item.sellIn - 1
        QualityBounds.decreaseQuality(item)

        if item.sellIn < 0 {
            QualityBounds.decreaseQuality(item)
        }
    }
}
