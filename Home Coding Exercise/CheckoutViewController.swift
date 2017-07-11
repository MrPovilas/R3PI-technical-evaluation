
import UIKit

class CheckoutViewController: UIViewController {
    
    static func create() -> CheckoutViewController {
        let storyboard = UIStoryboard(name: "Checkout", bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! CheckoutViewController
        
        controller.cartService = SharedServices.shared.cartService
        controller.currencyService = SharedServices.shared.currencyService
        
        return controller
    }
    
    @IBOutlet private var priceInUSDLabel: UILabel!
    @IBOutlet private var currencyChangeButton: UIButton!
    @IBOutlet fileprivate var currencySelectorTextField: UITextField!
    @IBOutlet private var convertedPriceLabel: UILabel!
    @IBOutlet private var priceConversionSpinner: UIActivityIndicatorView!
    
    fileprivate lazy var currencySelectorView: SelectorView = {
        let standardSelectorHeight: CGFloat = 217
        let selectorView = SelectorView(frame: CGRect(origin: .zero,
                                                      size: CGSize(width: self.view.bounds.width,
                                                                   height: standardSelectorHeight)))
        return selectorView
    }()
    
    fileprivate lazy var currencySpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .white)
        spinner.hidesWhenStopped = true
        
        return spinner
    }()
    
    private var cartService: CartService!
    private var currencyService: CurrencyService!
    private var currencies: [Currency] = [] {
        didSet {
            currencySelectorView.items = currencies.map({ SelectorItem(id: $0.id, title: $0.name) })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localize()
        updateUSDPriceText()
        setupCurrencySelector()
        setupCurrencySelectorSpinner()
        setupCurrencySelectorToolbar()
    }
    
    private func localize() {
        currencyChangeButton.setTitle("CheckPriceInDifferentCurrency".localized, for: .normal)
    }
    
    private func updateUSDPriceText() {
        priceInUSDLabel.text = "totalPriceInUSD".localized + " " + cartService.totalPrice().formattedPrice()
    }
    
    @IBAction private func changeCurrency(_ button: UIButton) {
        guard currencySelectorTextField.isFirstResponder == false else {
            hideCurrencySelector()
            return
        }
        
        currencySelectorTextField.becomeFirstResponder()
        guard currencies.count == 0 else {
            return
        }
        
        loadCurrencies()
    }
    
    private func loadCurrencies() {
        guard currencySpinner.isAnimating == false else {
            return
        }
        
        currencySpinner.startAnimating()
        
        let onCompletion = { [weak self] in
            self?.currencySpinner.stopAnimating()
        }
        
        currencyService.currencies(
            onSuccess: { [weak self] (currencies) in
                self?.currencies = currencies
                
                onCompletion()
            },
            onFailure: { [weak self] (error) in
                self?.show(error)
                
                onCompletion()
            })
    }
    
    @objc fileprivate func confirmSelectedCurrency() {
        hideCurrencySelector()
        
        guard let selectedCurrency = currencies.filter({ $0.id == currencySelectorView.selectedItem?.id }).first else {
            return
        }
    
        convertPrice(to: selectedCurrency)
    }
    
    @objc fileprivate func hideCurrencySelector() {
        currencySelectorTextField.resignFirstResponder()
    }
    
    private var conversionIndex: Int = 0
    private func convertPrice(to currency: Currency) {
        self.conversionIndex += 1
        let conversionIndex = self.conversionIndex
        
        convertedPriceLabel.text = "convertingPriceTo".localized + " " + currency.id
        convertedPriceLabel.isHidden = false
        priceConversionSpinner.startAnimating()
        
        currencyService.rate(
            currency,
            onSuccess: { [weak self] (conversionRate) in
                guard self?.conversionIndex == conversionIndex else {
                    return
                }
                
                let convertedPrice = self?.cartService.totalPrice().convertedPrice(with: conversionRate) ?? 0
                self?.convertedPriceLabel.text = "\("priceIn".localized) \(currency.id) \("is".localized) " + convertedPrice.formattedPrice()
                self?.priceConversionSpinner.stopAnimating()
            },
            onFailure: { [weak self] error in
                guard self?.conversionIndex == conversionIndex else {
                    return
                }
                
                self?.priceConversionSpinner.stopAnimating()
                self?.convertedPriceLabel.isHidden = true
                
                self?.show(error)
            })
    }
    
    private func show(_ error: Error) {
        hideCurrencySelector()
        
        let alertController = UIAlertController(title: "error".localized,
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "ok".localized,
                                         style: .cancel,
                                         handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
}

// MARK: - UI Setup
private extension CheckoutViewController {
    
    func setupNavigationItem() {
        navigationItem.title = "cart".localized
    }
    
    func setupCurrencySelector() {
        currencySelectorTextField.inputView = currencySelectorView
    }
    
    func setupCurrencySelectorToolbar() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(hideCurrencySelector))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(confirmSelectedCurrency))
        let flexibleSpaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 44))
        toolbar.items = [cancelButton, flexibleSpaceItem, doneButton]
        
        currencySelectorTextField.inputAccessoryView = toolbar
    }
    
    func setupCurrencySelectorSpinner() {
        currencySelectorView.addSubview(currencySpinner)
        currencySpinner.centerOnSuper()
    }
    
}
