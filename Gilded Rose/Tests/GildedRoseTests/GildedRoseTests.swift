@testable import GildedRose
import XCTest

class GildedRoseTests: XCTestCase {

    // MARK: Normal Items

    func testUpdateQuality_shouldDecreseQualityAndSellIn_forNormalItems() throws {
        let items = [Item(name: "Normal Item", sellIn: 5, quality: 10)]
        let app = GildedRose(items: items)
        app.updateQuality()

        XCTAssertEqual(app.items[0].quality, 9)
        XCTAssertEqual(app.items[0].sellIn, 4)
    }

    func testUpdateQuality_shouldDecreseQualityTwice_afterSellDate_forNormalItems() throws {
        let items = [Item(name: "Normal Item", sellIn: 0, quality: 10)]
        let app = GildedRose(items: items)
        app.updateQuality()

        XCTAssertEqual(app.items[0].quality, 8)
        XCTAssertEqual(app.items[0].sellIn, -1)
    }


    func testNormalItem_qualityNeverGoesNegative() throws {
        let items = [Item(name: "normal item", sellIn: 5, quality: 0)]
        let app = GildedRose(items: items)
        app.updateQuality()

        XCTAssertEqual(app.items[0].quality, 0)
        XCTAssertEqual(app.items[0].sellIn, 4)
    }

    func testNormalItem_veryNegativeSellIn() throws {
        let items = [Item(name: "foo", sellIn: -10, quality: 10)]
        let app = GildedRose(items: items)
        app.updateQuality()

        XCTAssertEqual(app.items[0].quality, 8)
        XCTAssertEqual(app.items[0].sellIn, -11)
    }

    // MARK: Aged Brie

    func testUpdateQuality_shouldIncreaseQuality_forAgedBrieItems() throws {
        let items = [Item(name: "Aged Brie", sellIn: 5, quality: 10)]
        let app = GildedRose(items: items)
        app.updateQuality()

        XCTAssertEqual(app.items[0].quality, 11)
        XCTAssertEqual(app.items[0].sellIn, 4)
    }

    func testUpdateQuality_shouldDecreseQualityTwice_afterSellDate_forAgedBrieItems() throws {
        let items = [Item(name: "Aged Brie", sellIn: 0, quality: 10)]
        let app = GildedRose(items: items)
        app.updateQuality()

        XCTAssertEqual(app.items[0].quality, 12)
        XCTAssertEqual(app.items[0].sellIn, -1)
    }

    func testAgedBrie_qualityNeverExceeds50() throws {
        let items = [Item(name: "Aged Brie", sellIn: 5, quality: 50)]
        let app = GildedRose(items: items)
        app.updateQuality()

        XCTAssertEqual(app.items[0].quality, 50)
        XCTAssertEqual(app.items[0].sellIn, 4)
    }

    // MARK: Sulfuras

    func testUpdateQuality_shouldNotChangeQualityAndSellIn_forSulfurasItems() throws {
        let items = [Item(name: "Sulfuras, Hand of Ragnaros", sellIn: 5, quality: 10)]
        let app = GildedRose(items: items)
        app.updateQuality()

        XCTAssertEqual(app.items[0].quality, 10)
        XCTAssertEqual(app.items[0].sellIn, 5)
    }

    // MARK: Backstage

    func testUpdateQuality_shouldDecreseQuality_withMoreThan10ForSellDate_forBackstageItems() throws {
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 11, quality: 10)]
        let app = GildedRose(items: items)
        app.updateQuality()

        XCTAssertEqual(app.items[0].quality, 12)
        XCTAssertEqual(app.items[0].sellIn, 10)
    }

    func testUpdateQuality_shouldDecreseQualityThreeTimes_withMoreThan5ForSellDate_forBackstageItems() throws {
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 4, quality: 10)]
        let app = GildedRose(items: items)
        app.updateQuality()

        XCTAssertEqual(app.items[0].quality, 13)
        XCTAssertEqual(app.items[0].sellIn, 3)
    }

    func testUpdateQuality_shouldDecreseQualityToZero_afterSellDate_forBackstageItems() throws {
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: -1, quality: 50)]
        let app = GildedRose(items: items)
        app.updateQuality()

        XCTAssertEqual(app.items[0].quality, 0)
        XCTAssertEqual(app.items[0].sellIn, -2)
    }

    // MARK: Conjured

    func testUpdateQuality_shouldDecreseQualityTwice_forConjuredItems() throws {
        let items = [Item(name: "Conjured", sellIn: 10, quality: 50)]
        let app = GildedRose(items: items)
        app.updateQuality()

        XCTAssertEqual(app.items[0].quality, 48)
        XCTAssertEqual(app.items[0].sellIn, 9)
    }

    func testConjuredItem_withQuality1_shouldNotGoNegative() throws {
        let items = [Item(name: "Conjured", sellIn: 5, quality: 1)]
        let app = GildedRose(items: items)
        app.updateQuality()

        XCTAssertEqual(app.items[0].quality, 0)
        XCTAssertEqual(app.items[0].sellIn, 4)
    }
}
