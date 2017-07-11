
import UIKit

class ProductsViewController: UIViewController {

    static func create() -> ProductsViewController {
        let storyboard = UIStoryboard(name: "Products", bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! ProductsViewController
        
        controller.productsService = SharedServices.shared.productsService
        controller.cartService = SharedServices.shared.cartService
        
        return controller
    }
    
    private var productsService: ProductsService!
    fileprivate var cartService: CartService!
    
    fileprivate lazy var products: [Product] = {
        return self.productsService.products
    }()
    
    private lazy var cartButton: BadgedButton = {
        let button = BadgedButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        button.setImage(UIImage(named: "Cart"), for: .normal)
        button.addTarget(self, action: #selector(openCheckout), for: .touchUpInside)
        
        return button
    }()
    
    @IBOutlet fileprivate var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItem()
        updateCartButton()
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "products".localized
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cartButton)
    }
    
    fileprivate func updateCartButton() {
        cartButton.isEnabled = cartService.totalQuantity() > 0
        
        updateCartBadge()
    }
    
    fileprivate func updateCartBadge() {
        let badgeCount = cartService.totalQuantity()
        cartButton.badgeText = badgeCount > 0 ? String(badgeCount) : ""
    }
    
    @objc private func openCheckout() {
        let checkoutController = CheckoutViewController.create()
        
        navigationController?.pushViewController(checkoutController, animated: true)
    }

}

extension ProductsViewController: UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier) as! ProductCell
        
        setup(cell, for: indexPath.row)
        
        return cell
    }
    
    private func setup(_ cell: ProductCell, for index: Int) {
        let product = products[index]
        cell.nameLabel.text = product.name
        cell.priceLabel.text = product.unitPrice.formattedPrice() + " / " + product.unit.localizedName
        cell.quantityInBasket = self.cartService.quantity(of: product)
        cell.delegate = self
    }
    
}

extension ProductsViewController: ProductCellDelegate {
    
    func productCellDidIncreaseQuantity(_ cell: ProductCell) {
        guard let product = product(with: cell) else {
            return
        }
        
        cartService.increase(product)
        updateCartButton()
    }
    
    func productCellDidDecreaseQuantity(_ cell: ProductCell) {
        guard let product = product(with: cell) else {
            return
        }
        
        cartService.decrease(product)
        updateCartButton()
    }
    
    private func product(with cell: ProductCell) -> Product? {
        guard let index = tableView.indexPath(for: cell)?.row else {
            return nil
        }
        
        return products[index]
    }
    
}
