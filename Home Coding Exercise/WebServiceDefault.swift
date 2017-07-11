
import Foundation

enum WebServiceError: Error {
    
    case unknown
    case invalidJSON
    
}

class WebServiceDefault: WebService {

    init(baseURL: URL, accessKey: String) {
        self.baseURL = baseURL
        self.accessKey = accessKey
    }
    
    private let baseURL: URL
    private let accessKey: String
    private lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringCacheData
        
        let session = URLSession(configuration: config)
        return session
    }()
    
    func currenciesJSON(onSuccess: @escaping (JSON) -> Void,
                        onFailure: @escaping (Error) -> Void) {
        let path = "list"
        let properties = [URLQueryItem(name: "access_key", value: accessKey)]
        
        request(path: path,
                properties: properties,
                onSuccess: onSuccess,
                onFailure: onFailure)
    }
    
    func rateJSON(_ currencyId: String,
                  onSuccess: @escaping (JSON) -> Void,
                  onFailure: @escaping (Error) -> Void) {
        let path = "live"
        let properties = [
            URLQueryItem(name: "access_key", value: accessKey),
            URLQueryItem(name: "currencies", value: currencyId)
        ]
        
        request(path: path,
                properties: properties,
                onSuccess: onSuccess,
                onFailure: onFailure)
    }
    
    private func request(path: String,
                         properties: [URLQueryItem],
                         onSuccess: @escaping (JSON) -> Void,
                         onFailure: @escaping (Error) -> Void) {
        let urlWithoutProperties = baseURL.appendingPathComponent(path, isDirectory: false)
        
        var urlComps = URLComponents(url: urlWithoutProperties, resolvingAgainstBaseURL: false)!
        urlComps.queryItems = properties
        
        let url = urlComps.url!
        
        session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard error == nil else {
                    onFailure(error!)
                    return
                }
                
                guard data != nil else {
                    onFailure(WebServiceError.unknown)
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!,
                                                                options: JSONSerialization.ReadingOptions(rawValue: 0))
                    guard json as? JSON != nil else {
                        onFailure(WebServiceError.invalidJSON)
                        return
                    }
                    
                    onSuccess(json as! JSON)
                } catch {
                    onFailure(WebServiceError.invalidJSON)
                }
            }
        }.resume()
    }
}
