
import UIKit

class BadgedButton: UIButton {
    
    var badgeText: String = "" {
        didSet {
            badgeView.isHidden = badgeText.isEmpty
            badgeLabel.text = badgeText
        }
    }
    
    private lazy var badgeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var badgeView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.masksToBounds = true
        view.addSubview(self.badgeLabel)
        view.isUserInteractionEnabled = false
        
        let insets = UIEdgeInsets(top: 0,
                                  left: CGFloat.constants.badgeInsets,
                                  bottom: 0,
                                  right: CGFloat.constants.badgeInsets)
        self.badgeLabel.layoutInFullSizeOnSuper(insets: insets)
        
        self.addSubview(view)
        self.setupConstraints(with: view)
        
        return view
    }()
    
    private func setupConstraints(with badgeView: UIView) {
        badgeView.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = NSLayoutConstraint(item: badgeView,
                                                   attribute: .leading,
                                                   relatedBy: .equal,
                                                   toItem: self,
                                                   attribute: .centerX,
                                                   multiplier: 1.0,
                                                   constant: 0.0)
        let topConstraint = NSLayoutConstraint(item: badgeView,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: self,
                                               attribute: .top,
                                               multiplier: 1.0,
                                               constant: 0.0)
        let minWidthConstraint = NSLayoutConstraint(item: badgeView,
                                                    attribute: .width,
                                                    relatedBy: .greaterThanOrEqual,
                                                    toItem: badgeView,
                                                    attribute: .height,
                                                    multiplier: 1.0,
                                                    constant: 0.0)
        addConstraints([leadingConstraint, topConstraint, minWidthConstraint])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.badgeView.layer.cornerRadius = floor(badgeView.frame.height / 2)
    }
    
}
