import XCTest

class StargazerListUITests: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    func testMoyaStargazerList() throws {
        submit(owner: "Moya", repo: "Moya")
        assertMoyaStargazerListIsDisplayed(app)
    }
    
    fileprivate func submit(owner: String, repo: String) {
        app.textFields["owner"].tap()
        app.type(text: owner)
        app.textFields["repo"].tap()
        app.type(text: repo)
        app.buttons["Search"].tap()
    }
    
    fileprivate func assertMoyaStargazerListIsDisplayed(_ app: XCUIApplication) {
        XCTAssertTrue(app.staticTexts["Moya/Moya"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["zwaldowski"].exists)
    }

}

extension XCUIApplication {
    
    func type(text: String) {
        text.forEach { character in
            self.keys[String(character)].tap()
        }
    }
    
}
