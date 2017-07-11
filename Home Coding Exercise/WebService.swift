
import Foundation

typealias JSON = [String : Any]

protocol WebService {
    
    func currenciesJSON(onSuccess: @escaping (JSON) -> Void,
                        onFailure: @escaping (Error) -> Void)
    
    func rateJSON(_ currencyId: String,
                  onSuccess: @escaping (JSON) -> Void,
                  onFailure: @escaping (Error) -> Void)
    
}
