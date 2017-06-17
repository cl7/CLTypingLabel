import UIKit
import XCTest
import CLTypingLabel

class CLTypingLabelUnitTests: XCTestCase {
    var typingLabel: CLTypingLabel!
    
    override func setUp() {
        super.setUp()
        typingLabel = CLTypingLabel()
        
    }
    
    override func tearDown() {
        typingLabel = nil
        super.tearDown()
    }
    
    func testInterval() {
        XCTAssertEqual(typingLabel.charInterval, 0.1)
        typingLabel.charInterval = 1.0
        XCTAssertEqual(typingLabel.charInterval, 1.0)
    }
    
    func testCenterText() {
        XCTAssertTrue(typingLabel.centerText)
        typingLabel.centerText = false
        XCTAssertFalse(typingLabel.centerText)
    }
    
    func testSetText() {
        XCTAssertNil(typingLabel.text)
        typingLabel.text = "test"
        XCTAssertEqual(typingLabel.text!, "test")
    }
    
}
