
import Foundation

class SharedServices {

    let productsService: ProductsService
    let cartService: CartService
    let currencyService: CurrencyService
    
    static var shared: SharedServices = SharedServices()
    
    private init() {
        let baseURL = URL(string: "http://apilayer.net/api")!
        let accessKey = "2b5addba56e28679504922730dfa35a4"
        let webService = WebServiceDefault(baseURL: baseURL, accessKey: accessKey)
        
        self.currencyService = CurrencyServiceDefault(webService: webService)
        self.productsService = ProductsServiceDefault(products: products)
        self.cartService = CartServiceDefault()
    }
    
    private var products: [Product] = {
        guard ProcessInfo.processInfo.environment["UITestingEnvironment"] != "Standard" else {
            let peasProduct = Product(name: "peas".localized,
                                unit: .bag,
                                unitPrice: 1.0)
            let eggsProduct = Product(name: "eggs".localized,
                                unit: .dozen,
                                unitPrice: 3.5)
            
            return [peasProduct, eggsProduct]
        }
        
        let peasProduct = Product(name: "peas".localized,
                            unit: .bag,
                            unitPrice: 0.95)
        let eggsProduct = Product(name: "eggs".localized,
                            unit: .dozen,
                            unitPrice: 2.1)
        let milkProduct = Product(name: "milk".localized,
                            unit: .bottle,
                            unitPrice: 1.3)
        let beansProduct = Product(name: "beans".localized,
                             unit: .can,
                             unitPrice: 0.73)
        
        return [peasProduct, eggsProduct, milkProduct, beansProduct]
    }()
    
}
