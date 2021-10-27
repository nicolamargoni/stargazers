import XCTest

class GithubClientTests: XCTestCase {

    func testRetrieveStargazerList() {
        let client = GithubClient()
        let testExpectation = expectation(description: "any")
        
        client.stargazers(owner: "Moya", repo: "Moya", perPage: 5, page: 2) { result in
            testExpectation.fulfill()
            print(result)
        }
        
        wait(for: [testExpectation], timeout: 5.0)
    }

}
