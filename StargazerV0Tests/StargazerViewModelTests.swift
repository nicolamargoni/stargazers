import XCTest

class StargazerViewModelTests: XCTestCase {

    func testDidFormSubmit_success() {
        let expectedList = [Stargazer(id: 1, name: "mario", avatarUrl: "marioAvatarUrl")]
        let state = StargazerViewModel.State()
        let service: MockGitHubService = MockGitHubService()
        let viewModel = StargazerViewModel(service: service, state: state)
        service.whenStargazerReturn(list: .success(expectedList))
        
        viewModel.didFormSubmit(owner: "anyOwner", repo: "anyRepo")
        
        service.assertStargazersWith(owner: "anyOwner", repo: "anyRepo", perPage: 10, page: 1)
        XCTAssertEqual("anyOwner", viewModel.state.owner)
        XCTAssertEqual("anyRepo", viewModel.state.repo)
        XCTAssertEqual(expectedList, viewModel.state.list)
        XCTAssertNil(viewModel.state.error)
    }


    func testDidFormSubmit_error() {
        let state = StargazerViewModel.State()
        let service: MockGitHubService = MockGitHubService()
        let viewModel = StargazerViewModel(service: service, state: state)
        service.whenStargazerReturn(list: .failure(.genericError))
        
        viewModel.didFormSubmit(owner: "anyOwner", repo: "anyRepo")
        
        service.assertStargazersWith(owner: "anyOwner", repo: "anyRepo", perPage: 10, page: 1)
        XCTAssertEqual("anyOwner", viewModel.state.owner)
        XCTAssertEqual("anyRepo", viewModel.state.repo)
        XCTAssertNil(viewModel.state.list)
        XCTAssertEqual(GithubServiceError.genericError.errorDescription, viewModel.state.error)
    }

}

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
