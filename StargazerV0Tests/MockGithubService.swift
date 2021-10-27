import XCTest

class MockGitHubService: GithubService {
    private var stargazersOwner: String?
    private var stargazersRepo: String?
    private var stargazersPerPage: Int?
    private var stargazersPage: Int?
    private var stargazersResult: Result<[Stargazer], GithubServiceError>?
    
    func assertStargazersWith(owner: String, repo: String, perPage: Int, page: Int) {
        XCTAssertEqual(self.stargazersOwner, owner)
        XCTAssertEqual(self.stargazersRepo, repo)
        XCTAssertEqual(self.stargazersPerPage, perPage)
        XCTAssertEqual(self.stargazersPage, page)
    }
    
    func whenStargazerReturn(list: Result<[Stargazer], GithubServiceError>) {
        self.stargazersResult = list
    }
    
    func stargazers(owner: String, repo: String, perPage: Int, page: Int, completion: @escaping (Result<[Stargazer], GithubServiceError>) -> Void) {
        self.stargazersOwner = owner
        self.stargazersRepo = repo
        self.stargazersPerPage = perPage
        self.stargazersPage = page
        
        if let result = stargazersResult {
            completion(result)
        }
    }

}
