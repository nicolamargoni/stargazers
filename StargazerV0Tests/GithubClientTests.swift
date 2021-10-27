import XCTest
import Moya

class GithubClientTests: XCTestCase {

    func testRepositoryNotFound() {
        let stubProvider = stubGithubProvider(response: .networkResponse(404, "".data(using: .utf8)!))
        let client = GithubClient(provider: stubProvider)
        let testExpectation = expectation(description: "404")
        
        client.stargazers(owner: "Any", repo: "Any", perPage: 1, page: 1) { result in
            XCTAssertEqual(Result.failure(GithubServiceError.repositoryNotFound), result)
            testExpectation.fulfill()
        }
        
        wait(for: [testExpectation], timeout: 5.0)
    }

    func testGenericErrorWhenStatusCodeNotHandled() {
        let stubProvider = stubGithubProvider(response: .networkResponse(500, "".data(using: .utf8)!))
        let client = GithubClient(provider: stubProvider)
        let testExpectation = expectation(description: "404")
        
        client.stargazers(owner: "Any", repo: "Any", perPage: 1, page: 1) { result in
            XCTAssertEqual(Result.failure(GithubServiceError.genericError), result)
            testExpectation.fulfill()
        }
        
        wait(for: [testExpectation], timeout: 5.0)
    }
    
    func testHappyPath() {
        let stubProvider = stubGithubProvider(response: .networkResponse(200, self.validJsonResponse.data(using: .utf8)!))
        let client = GithubClient(provider: stubProvider)
        let testExpectation = expectation(description: "200")
        let expectedStargazerList = [Stargazer(id: 1, name: "octocat", avatarUrl: "https://github.com/images/error/octocat_happy.gif")]
        
        client.stargazers(owner: "Any", repo: "Any", perPage: 1, page: 1) { result in
            XCTAssertEqual(Result.success(expectedStargazerList), result)
            testExpectation.fulfill()
        }
        
        wait(for: [testExpectation], timeout: 5.0)
    }
    
    private func stubGithubProvider(response: EndpointSampleResponse) -> MoyaProvider<Github> {
        MoyaProvider<Github>(endpointClosure: customEndpointClosure(response: response), stubClosure: MoyaProvider.immediatelyStub)
    }
    
    private func customEndpointClosure(response: EndpointSampleResponse) -> ((Github) -> Endpoint) {
        { (target: Github) -> Endpoint in
            return Endpoint(url: URL(target: target).absoluteString,
                            sampleResponseClosure: { response },
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
        }
    }

    private let validJsonResponse = """
        [
          {
            "login": "octocat",
            "id": 1,
            "node_id": "MDQ6VXNlcjE=",
            "avatar_url": "https://github.com/images/error/octocat_happy.gif",
            "gravatar_id": "",
            "url": "https://api.github.com/users/octocat",
            "html_url": "https://github.com/octocat",
            "followers_url": "https://api.github.com/users/octocat/followers",
            "following_url": "https://api.github.com/users/octocat/following{/other_user}",
            "gists_url": "https://api.github.com/users/octocat/gists{/gist_id}",
            "starred_url": "https://api.github.com/users/octocat/starred{/owner}{/repo}",
            "subscriptions_url": "https://api.github.com/users/octocat/subscriptions",
            "organizations_url": "https://api.github.com/users/octocat/orgs",
            "repos_url": "https://api.github.com/users/octocat/repos",
            "events_url": "https://api.github.com/users/octocat/events{/privacy}",
            "received_events_url": "https://api.github.com/users/octocat/received_events",
            "type": "User",
            "site_admin": false
          }
        ]
    """
}
