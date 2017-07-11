
import Foundation

class JSONToConversionRate {
    
    static func map(_ json: JSON, currency: Currency) throws -> Double {
        guard let ratesJSON = json["quotes"] as? [String : Double] else {
            throw CurrencyServiceError.unknown
        }
        
        let rateKey = "USD" + currency.id
        guard let conversionRate = ratesJSON[rateKey] else {
            throw CurrencyServiceError.unknown
        }
        
        return conversionRate
    }
    
}
