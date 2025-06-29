
public class GildedRose {
    enum Types: String, CaseIterable {
        case aged = "Aged Brie"
        case conjured = "Conjured"
        case sulfuras = "Sulfuras, Hand of Ragnaros"
        case backStage = "Backstage passes to a TAFKAL80ETC concert"
    }

    var items: [Item]

    private lazy var strategies: [String: ItemUpdateStrategy] = [
        Types.aged.rawValue: AgedStrategy(),
        Types.backStage.rawValue: BackstageStrategy(),
        Types.conjured.rawValue: ConjuredStrategy(),
        Types.sulfuras.rawValue: SulfurasStrategy()
    ]

    public init(items: [Item]) {
        self.items = items
    }

   public func updateQuality() {
        for item in items {
            let strategy = strategyFor(item.name)
            strategy.update(item)
        }
    }

    private func strategyFor(_ itemName: String) -> ItemUpdateStrategy {
        return strategies[itemName] ?? DefaultStrategy()
    }
}
