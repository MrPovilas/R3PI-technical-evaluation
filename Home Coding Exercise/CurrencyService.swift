
import Foundation

protocol CurrencyService {
    
    func currencies(onSuccess: @escaping ([Currency]) -> Void,
                    onFailure: @escaping (Error) -> Void)
    
    func rate(_ currency: Currency,
              onSuccess: @escaping (Double) -> Void,
              onFailure: @escaping (Error) -> Void)
    
}
