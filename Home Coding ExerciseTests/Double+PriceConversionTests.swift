
import XCTest
@testable import Home_Coding_Exercise

class DoublePriceConversionTests: XCTestCase {
    
    func test1To1ConversionRateHasNoImpact() {
        let value = Double(3.45)
        let conversionRate = Double(1.0)
        let result = value.convertedPrice(with: conversionRate)
        XCTAssert(result.isEqual(to: value))
    }
    
    func test1To1AndHalfConversionRate() {
        let value = Double(3.45)
        let conversionRate = Double(1.5)
        let result = value.convertedPrice(with: conversionRate)
        XCTAssert(result.isEqual(to: value * conversionRate))
    }
    
    func test1To2ConversionRate() {
        let value = Double(3.45)
        let conversionRate = Double(2.0)
        let result = value.convertedPrice(with: conversionRate)
        XCTAssert(result.isEqual(to: value * conversionRate))
    }
    
}
