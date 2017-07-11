
import Foundation

class ProductsServiceDefault: ProductsService {

    let products: [Product]
    
    init(products: [Product]) {
        self.products = products
    }
    
}
