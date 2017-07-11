
import Foundation

private class CartItem {
    
    var quantity: Int
    var product: Product
    
    init(quantity: Int, product: Product) {
        self.quantity = quantity
        self.product = product
    }
    
}

class CartServiceDefault: CartService {
    
    private var items: [CartItem] = []
    
    func increase(_ product: Product) {
        guard let item: CartItem = items.filter({ $0.product == product }).first else {
            let newItem = CartItem(quantity: 1, product: product)
            items.append(newItem)
            return
        }
        
        item.quantity += 1
    }

    func decrease(_ product: Product) {
        guard let item = items.filter({ $0.product == product }).first else {
            return
        }
        
        item.quantity -= 1
        
        guard item.quantity == 0 else {
            return
        }
        
        if let index = items.index(where: { $0.product == product }) {
            items.remove(at: index)
        }
    }
    
    func quantity(of product: Product) -> Int {
        guard let item = items.filter({ $0.product == product }).first else {
            return 0
        }
        
        return item.quantity
    }
    
    func totalQuantity() -> Int {
        var quantity = 0
        
        items.forEach({ quantity += $0.quantity })
        
        return quantity
    }
    
    func totalPrice() -> Double {
        var price: Double = 0
        
        items.forEach({ price += Double($0.quantity) * $0.product.unitPrice })
        
        return price
    }
    
}
