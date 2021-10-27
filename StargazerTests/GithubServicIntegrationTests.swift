import XCTest
import Moya

class GithubServicIntegrationTests: XCTestCase {

    func disabled_testHappyPath() {
        let client = GithubClient(provider: MoyaProvider<Github>())
        let testExpectation = expectation(description: "real http request")
        
        client.stargazers(owner: "Moya", repo: "Moya", perPage: 1, page: 1) { result in
            XCTAssertNotNil(try? result.get())
            testExpectation.fulfill()
        }
        
        wait(for: [testExpectation], timeout: 5.0)
    }

}
