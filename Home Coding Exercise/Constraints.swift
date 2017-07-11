
import UIKit

class Constraint: NSLayoutConstraint {

    private (set) var size: CGFloat = 0
    
    override var constant: CGFloat {
        set {}
        get { return self.size }
    }

}

class DefaultVerticalSpacingConstraint: Constraint {
    
    override var size: CGFloat {
        return CGFloat.constants.defaultVerticalSpacing
    }
    
}

class DefaultHorizontalSpacingConstraint: Constraint {
    
    override var size: CGFloat {
        return CGFloat.constants.defaultHorizontalSpacing
    }
    
}
