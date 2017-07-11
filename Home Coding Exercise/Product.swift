
import Foundation

struct Product: Equatable {

    let name: String
    let unit: Unit
    
    /**
        * Price in US dollars.
    */
    let unitPrice: Double
    
}

func ==(lhs: Product, rhs: Product) -> Bool {
    return lhs.name == rhs.name
        && lhs.unit == rhs.unit
        && lhs.unitPrice.isEqual(to: rhs.unitPrice)
}
