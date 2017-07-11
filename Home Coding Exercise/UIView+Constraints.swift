
import UIKit

extension UIView {
    
    func layoutInFullSizeOnSuper(insets: UIEdgeInsets = .zero) {
        guard let superview = self.superview else {
            return
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-left-[view]-right-|",
                                                                   options: .directionLeadingToTrailing,
                                                                   metrics: ["left" : insets.left, "right" : insets.right],
                                                                   views: ["view" : self])
        superview.addConstraints(horizontalConstraints)
        
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-top-[view]-bottom-|",
                                                                 options: .directionLeadingToTrailing,
                                                                 metrics: ["top" : insets.top, "bottom" : insets.bottom],
                                                                 views: ["view" : self])
        superview.addConstraints(verticalConstraints)
    }
    
    func centerOnSuper() {
        guard let superview = self.superview else {
            return
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let centerHorizontalyConstraint = NSLayoutConstraint(item: self,
                                                             attribute: .centerX,
                                                             relatedBy: .equal,
                                                             toItem: superview,
                                                             attribute: .centerX,
                                                             multiplier: 1.0,
                                                             constant: 0.0)
        superview.addConstraint(centerHorizontalyConstraint)
        
        let centerVerticallyConstraint = NSLayoutConstraint(item: self,
                                                            attribute: .centerY,
                                                            relatedBy: .equal,
                                                            toItem: superview,
                                                            attribute: .centerY,
                                                            multiplier: 1.0,
                                                            constant: 0.0)
        superview.addConstraint(centerVerticallyConstraint)
    }
    
}
