
import XCTest
@testable import Home_Coding_Exercise

class ProductTests: XCTestCase {
    
    func testEqualProductsAreEqual() {
        let name = "Peas"
        let unit = Unit.bag
        let unitPrice: Double = 1.0
        
        let product = Product(name: name,
                        unit: unit,
                        unitPrice: unitPrice)
        
        XCTAssertEqual(product, product)
    }
    
    func testDifferentNamesMakesProductsNotEqual() {
        let name = "Peas"
        let differentName = name + "random text"
        let unit = Unit.bag
        let unitPrice: Double = 1.0
        
        let product = Product(name: name,
                        unit: unit,
                        unitPrice: unitPrice)
        let productWithDifferentName = Product(name: differentName,
                                         unit: unit,
                                         unitPrice: unitPrice)
        
        XCTAssertNotEqual(product, productWithDifferentName)
    }
    
    func testDifferentUnitsMakesProductsNotEqual() {
        let name = "Peas"
        let unit = Unit.bag
        let differentUnit = Unit.dozen
        let unitPrice: Double = 1.0
        
        let product = Product(name: name,
                        unit: unit,
                        unitPrice: unitPrice)
        let productWithDifferentUnit = Product(name: name,
                                         unit: differentUnit,
                                         unitPrice: unitPrice)
        
        XCTAssertNotEqual(product, productWithDifferentUnit)
    }
    
    func testDifferentUnitPricesMakesProductsNotEqual() {
        let name = "Peas"
        let unit = Unit.bag
        let unitPrice: Double = 1.0
        let differentUnitPrice: Double = 1.1
        
        let product = Product(name: name,
                        unit: unit,
                        unitPrice: unitPrice)
        let productWithDifferentUnit = Product(name: name,
                                         unit: unit,
                                         unitPrice: differentUnitPrice)
        
        XCTAssertNotEqual(product, productWithDifferentUnit)
    }
    
}
