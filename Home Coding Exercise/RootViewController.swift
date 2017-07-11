
import UIKit

class RootViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupProductsViewController()
    }
    
    private func setupProductsViewController() {
        let productsViewController = ProductsViewController.create()
        let navigationController = UINavigationController(rootViewController: productsViewController)
        
        addChildViewController(navigationController)
        view.addSubview(navigationController.view)
    }
    
}
