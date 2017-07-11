
import XCTest
@testable import Home_Coding_Exercise

class CartServiceDefaultTests: XCTestCase {
    
    func testIncreaseDecreaseCountUpdatesQuantity() {
        let product = Product(name: "Beans",
                        unit: .can,
                        unitPrice: 0.73)
        let cartService: CartService = CartServiceDefault()
        
        cartService.decrease(product)
        XCTAssertEqual(cartService.quantity(of: product), 0)
        
        cartService.increase(product)
        XCTAssertEqual(cartService.quantity(of: product), 1)
        
        cartService.increase(product)
        XCTAssertEqual(cartService.quantity(of: product), 2)
        
        cartService.decrease(product)
        XCTAssertEqual(cartService.quantity(of: product), 1)
        
        cartService.decrease(product)
        XCTAssertEqual(cartService.quantity(of: product), 0)
        
        cartService.decrease(product)
        XCTAssertEqual(cartService.quantity(of: product), 0)
    }
    
    func testTotalQuantityIncludesAllProducts() {
        let beansProduct = Product(name: "Beans",
                             unit: .can,
                             unitPrice: 0.73)
        let eggsProduct = Product(name: "Eggs",
                             unit: .dozen,
                             unitPrice: 2.1)
        
        let cartService: CartService = CartServiceDefault()

        cartService.increase(beansProduct)
        XCTAssertEqual(cartService.totalQuantity(), 1)
        
        cartService.increase(beansProduct)
        XCTAssertEqual(cartService.totalQuantity(), 2)
        
        cartService.increase(eggsProduct)
        XCTAssertEqual(cartService.totalQuantity(), 3)
    }
    
    func testTotalPriceIncludesAllProducts() {
        let beansPrice = Double(0.73)
        let beansProduct = Product(name: "Beans",
                             unit: .can,
                             unitPrice: beansPrice)
        
        let eggsPrice = Double(2.1)
        let eggsProduct = Product(name: "Eggs",
                            unit: .dozen,
                            unitPrice: eggsPrice)
        
        let cartService: CartService = CartServiceDefault()
        
        XCTAssertEqual(cartService.totalPrice(), 0)
        
        cartService.increase(beansProduct)
        XCTAssertEqual(cartService.totalPrice(), beansPrice)
        
        cartService.increase(beansProduct)
        XCTAssertEqual(cartService.totalPrice(), beansPrice * 2)
        
        cartService.increase(eggsProduct)
        XCTAssertEqual(cartService.totalPrice(), beansPrice * 2 + eggsPrice)
    }
    
    func testCurrenciesWithCorrectJSONDataCreated() {
        let json = ["currencies" : ["AED" : "United Arab Emirates Dirham",
                                    "AMD" : "Armenian Dram"]]
        do {
            let currencies = try JSONToCurrenciesMap.map(json)
            XCTAssertEqual(currencies.count, 2)
            XCTAssertEqual(currencies[0].id, "AED")
            XCTAssertEqual(currencies[0].name, "AED (United Arab Emirates Dirham)")
            XCTAssertEqual(currencies[1].id, "AMD")
            XCTAssertEqual(currencies[1].name, "AMD (Armenian Dram)")
        } catch {
            XCTFail()
        }
    }
    
    func testCurrenciesWithEmptyJSONDataFails() {
        let json = ["currencies" : [ : ]]
        do {
            _ = try JSONToCurrenciesMap.map(json)
            XCTFail()
        } catch {
            XCTAssert(error as? CurrencyServiceError == .noCurrenciesFound)
        }
    }
    
    func testCurrenciesWithoutJSONKeyFails() {
        let json: JSON = [ : ]
        do {
            _ = try JSONToCurrenciesMap.map(json)
            XCTFail()
        } catch {
            XCTAssert(error as? CurrencyServiceError == .noCurrenciesFound)
        }
    }
    
    func testJSONConversionRateWithCorrectJSONCreated() {
        let currency = Currency(id: "AED", name: "AED (United Arab Emirates Dirham)")
        let json = ["quotes" : ["USDAED" : 1.55]]
        
        do {
            let conversionRate = try JSONToConversionRate.map(json, currency: currency)
            XCTAssert(conversionRate.isEqual(to: 1.55))
        } catch {
            XCTFail()
        }
    }
    
    func testJSONConversionRateWithoutQuotesFails() {
        let currency = Currency(id: "AED", name: "AED (United Arab Emirates Dirham)")
        let json: JSON = [ : ]
        
        do {
            _ = try JSONToConversionRate.map(json, currency: currency)
            XCTFail()
        } catch {
            XCTAssert(error as? CurrencyServiceError == .unknown)
        }
    }
    
    func testJSONConversionRateWithoutMatchingRateFails() {
        let currency = Currency(id: "AED", name: "AED (United Arab Emirates Dirham)")
        let json = ["quotes" : [ : ]]
        
        do {
            _ = try JSONToConversionRate.map(json, currency: currency)
            XCTFail()
        } catch {
            XCTAssert(error as? CurrencyServiceError == .unknown)
        }
    }
    
}
