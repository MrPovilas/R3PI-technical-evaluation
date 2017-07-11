
import XCTest
@testable import Home_Coding_Exercise

class ProductsServiceDefaultTests: XCTestCase {
    
    func testInitializedProductsReturnedTroughVariable() {
        let peasProduct = Product(name: "Peas",
                            unit: Unit.bag,
                            unitPrice: 0.95)
        let eggsProduct = Product(name: "Eggs",
                            unit: Unit.dozen,
                            unitPrice: 2.1)
        let products = [peasProduct, eggsProduct]
        let productsService: ProductsService = ProductsServiceDefault(products: products)
        
        XCTAssertEqual(productsService.products, products)
    }
    
}
