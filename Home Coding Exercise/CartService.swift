
import Foundation

protocol CartService {
    
    func increase(_ product: Product)
    func decrease(_ product: Product)
    func quantity(of product: Product) -> Int
    func totalQuantity() -> Int
    
    /**
    *   Total cart price in USD
    */
    func totalPrice() -> Double
    
}
