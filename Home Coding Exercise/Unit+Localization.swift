
import Foundation

extension Unit {

    var localizedName: String {
        
        switch self {
            
        case .bag:
            return "bag".localized
        
        case .dozen:
            return "dozen".localized
            
        case .bottle:
            return "bottle".localized
            
        case .can:
            return "can".localized
        
        }
    }
    
}
