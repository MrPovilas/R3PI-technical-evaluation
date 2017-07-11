
import Foundation

class JSONToCurrenciesMap {
    
    static func map(_ json: JSON)  throws -> [Currency] {
        guard let currenciesJSON = json["currencies"] as? [String : String] else {
            throw CurrencyServiceError.noCurrenciesFound
        }
        
        guard currenciesJSON.count > 0 else {
            throw CurrencyServiceError.noCurrenciesFound
        }
        
        let sortedCurrenciesJSONArray = currenciesJSON.sorted(by: { (lhs, rhs) -> Bool in
            return lhs.key.compare(rhs.key) == .orderedAscending
        })
        
        return sortedCurrenciesJSONArray.map({ Currency(id: $0.key, name: $0.key + " (\($0.value))") })
    }
    
}
