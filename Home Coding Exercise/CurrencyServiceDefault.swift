
import Foundation

enum CurrencyServiceError: Error {
    
    case unknown
    case noCurrenciesFound
    
}

class CurrencyServiceDefault: CurrencyService {
    
    private let webService: WebService
    
    init(webService: WebService) {
        self.webService = webService
    }
    
    func currencies(onSuccess: @escaping ([Currency]) -> Void,
                    onFailure: @escaping (Error) -> Void) {
        webService.currenciesJSON(onSuccess: { (json) in
            do {
                let currencies = try JSONToCurrenciesMap.map(json)
                onSuccess(currencies)
            } catch {
                onFailure(error)
            }
        }, onFailure: onFailure)
    }
    
    func rate(_ currency: Currency,
              onSuccess: @escaping (Double) -> Void,
              onFailure: @escaping (Error) -> Void) {
        webService.rateJSON(
            currency.id,
            onSuccess: { (json) in
                do {
                    let rate = try JSONToConversionRate.map(json, currency: currency)
                    onSuccess(rate)
                } catch {
                    onFailure(error)
                }
            }, onFailure: onFailure)
    }
    
}
