
import UIKit

protocol ProductCellDelegate: class {
    
    func productCellDidIncreaseQuantity(_ cell: ProductCell)
    func productCellDidDecreaseQuantity(_ cell: ProductCell)
    
}

class ProductCell: UITableViewCell {
    
    static let identifier = "productCell"
    
    weak var delegate: ProductCellDelegate?
    
    @IBOutlet private (set) var nameLabel: UILabel!
    @IBOutlet private (set) var priceLabel: UILabel!
    @IBOutlet private var quantityAdjustmentView: QuantityAdjustmentView!
    
    var quantityInBasket: Int = 0 {
        didSet {
            quantityAdjustmentView.isHidden = quantityInBasket == 0
            addToBasketButton.isHidden = quantityInBasket != 0
            
            let title = String(quantityInBasket)
            quantityAdjustmentView.countLabel.text = title
        }
    }
    
    @IBOutlet private var addToBasketButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupActions()
        localize()
    }
    
    private func setupActions() {
        quantityAdjustmentView.decreaseButton.addTarget(self, action: #selector(decreaseQuantity), for: .touchUpInside)
        quantityAdjustmentView.increaseButton.addTarget(self, action: #selector(increaseQuantity), for: .touchUpInside)
    }
    
    private func localize() {
        addToBasketButton.setTitle("addToCart".localized, for: .normal)
    }
    
    @objc private func increaseQuantity() {
        quantityInBasket += 1
        
        delegate?.productCellDidIncreaseQuantity(self)
    }
    
    @objc private func decreaseQuantity() {
        quantityInBasket -= 1
        
        delegate?.productCellDidDecreaseQuantity(self)
    }
    
    @IBAction private func addToCart(_ button: UIButton) {
        increaseQuantity()
    }
    
}
