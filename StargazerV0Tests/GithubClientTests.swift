import XCTest

class GithubClientTests: XCTestCase {

    func testRetrieveStargazerList() {
        let client = GithubClient()
        let testExpectation = expectation(description: "any")
        
        client.stargazers(owner: "Moya", repo: "Moya", page: 2) { list in
            testExpectation.fulfill()
            print(list)
        }
        
        wait(for: [testExpectation], timeout: 5.0)
    }

}
