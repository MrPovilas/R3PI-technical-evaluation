
import XCTest
@testable import Home_Coding_Exercise

class DoublePriceFormatTests: XCTestCase {
    
    func testValueWithoutResidual() {
        let value = Double(3)
        let expectedResult = "3.00"
        XCTAssertEqual(value.formattedPrice(), expectedResult)
    }
    
    func testValueWithOneResidualSymbol() {
        let value = Double(3.4)
        let expectedResult = "3.40"
        XCTAssertEqual(value.formattedPrice(), expectedResult)
    }
    
    func testValueWithTwoResidualSymbols() {
        let value = Double(3.45)
        let expectedResult = "3.45"
        XCTAssertEqual(value.formattedPrice(), expectedResult)
    }
    
    func testValueWithThreeResidualSymbolsLowerSide() {
        let value = Double(3.444)
        let expectedResult = "3.44"
        XCTAssertEqual(value.formattedPrice(), expectedResult)
    }
    
    func testValueWithThreeResidualSymbolsHigherSide() {
        let value = Double(3.446)
        let expectedResult = "3.45"
        XCTAssertEqual(value.formattedPrice(), expectedResult)
    }
    
}
