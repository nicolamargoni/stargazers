import XCTest

class StargazerViewModelTests: XCTestCase {
    private var service: MockGitHubService!
    private var viewModel: StargazerViewModel!
    
    override func setUp() {
        service = MockGitHubService()
    }
    
    private func initViewModel(with state: StargazerViewModel.State) {
        viewModel = StargazerViewModel(service: service, state: state)
    }

    func testDidFormSubmit_success_allDataLoaded() {
        let expectedList = subList(from: 0, to: 1)
        initViewModel(with: StargazerViewModel.State())
        service.whenStargazerReturn(list: .success(expectedList))
        
        viewModel.didFormSubmit(owner: "anyOwner", repo: "anyRepo")
        
        service.assertStargazersWith(owner: "anyOwner", repo: "anyRepo", perPage: 10, page: 1)
        XCTAssertEqual("anyOwner", viewModel.state.owner)
        XCTAssertEqual("anyRepo", viewModel.state.repo)
        XCTAssertEqual(expectedList, viewModel.state.list)
        XCTAssertTrue(viewModel.state.allDataLoaded)
        XCTAssertFalse(viewModel.state.isLoading)
        XCTAssertNil(viewModel.state.error)
    }
    
    func testDidFormSubmit_success_partialDataLoaded() {
        let expectedList = subList(from: 0, to: 9)
        initViewModel(with: StargazerViewModel.State())
        service.whenStargazerReturn(list: .success(expectedList))
        
        viewModel.didFormSubmit(owner: "anyOwner", repo: "anyRepo")
        
        service.assertStargazersWith(owner: "anyOwner", repo: "anyRepo", perPage: 10, page: 1)
        XCTAssertEqual("anyOwner", viewModel.state.owner)
        XCTAssertEqual("anyRepo", viewModel.state.repo)
        XCTAssertEqual(expectedList, viewModel.state.list)
        XCTAssertFalse(viewModel.state.allDataLoaded)
        XCTAssertFalse(viewModel.state.isLoading)
        XCTAssertNil(viewModel.state.error)
    }
    
    func testLoadingWhenFormDidSubmit() {
        initViewModel(with: StargazerViewModel.State())
        
        viewModel.didFormSubmit(owner: "anyOwner", repo: "anyRepo")
        
        XCTAssertTrue(viewModel.state.isLoading)
    }

    func testDidFormSubmit_error() {
        initViewModel(with: StargazerViewModel.State())
        service.whenStargazerReturn(list: .failure(.genericError))
        
        viewModel.didFormSubmit(owner: "anyOwner", repo: "anyRepo")
        
        service.assertStargazersWith(owner: "anyOwner", repo: "anyRepo", perPage: 10, page: 1)
        XCTAssertEqual("anyOwner", viewModel.state.owner)
        XCTAssertEqual("anyRepo", viewModel.state.repo)
        XCTAssertNil(viewModel.state.list)
        XCTAssertFalse(viewModel.state.isLoading)
        XCTAssertEqual(GithubServiceError.genericError.errorDescription, viewModel.state.error)
    }
    
    func testLoadMore_success_allDataLoaded() {
        let alreadyLoadedList = subList(from: 0, to: 9)
        let expectedList = subList(from: 10, to: 11)
        let state = StargazerViewModel.State(owner: "anyOwner", repo: "anyRepo", allDataLoaded: false, list: alreadyLoadedList)
        initViewModel(with: state)
        service.whenStargazerReturn(list: .success(expectedList))
        
        viewModel.loadMore()
        
        service.assertStargazersWith(owner: "anyOwner", repo: "anyRepo", perPage: 10, page: 2)
        XCTAssertEqual("anyOwner", viewModel.state.owner)
        XCTAssertEqual("anyRepo", viewModel.state.repo)
        XCTAssertEqual(alreadyLoadedList + expectedList, viewModel.state.list)
        XCTAssertTrue(viewModel.state.allDataLoaded)
        XCTAssertNil(viewModel.state.error)
    }
    
    func testLoadMore_success_partialDataLoaded() {
        let alreadyLoadedList: [Stargazer] = subList(from: 0, to: 9)
        let expectedList: [Stargazer] =  subList(from: 10, to: 11)
        let state = StargazerViewModel.State(owner: "anyOwner", repo: "anyRepo", allDataLoaded: false, list: alreadyLoadedList)
        initViewModel(with: state)
        service.whenStargazerReturn(list: .success(expectedList))
        
        viewModel.loadMore()
        
        service.assertStargazersWith(owner: "anyOwner", repo: "anyRepo", perPage: 10, page: 2)
        XCTAssertEqual("anyOwner", viewModel.state.owner)
        XCTAssertEqual("anyRepo", viewModel.state.repo)
        XCTAssertEqual(alreadyLoadedList + expectedList, viewModel.state.list)
        XCTAssertTrue(viewModel.state.allDataLoaded)
        XCTAssertNil(viewModel.state.error)
    }
    
    func testReset() {
        let alreadyLoadedList: [Stargazer] = subList(from: 0, to: 9)
        let state = StargazerViewModel.State(owner: "anyOwner", repo: "anyRepo", allDataLoaded: true, list: alreadyLoadedList)
        initViewModel(with: state)
        
        viewModel.reset()
        
        XCTAssertTrue(viewModel.state.owner.isEmpty)
        XCTAssertTrue(viewModel.state.repo.isEmpty)
        XCTAssertNil(viewModel.state.list)
        XCTAssertFalse(viewModel.state.allDataLoaded)
        XCTAssertNil(viewModel.state.error)
    }
    
    private func subList(from: Int, to: Int) -> [Stargazer] {
        Array(fullList[from...to])
    }
    
    private let fullList = [
        Stargazer(id: 0, name: "a", avatarUrl: "url"),
        Stargazer(id: 1, name: "b" , avatarUrl: "url"),
        Stargazer(id: 2, name: "c" , avatarUrl: "url"),
        Stargazer(id: 3, name: "d" , avatarUrl: "url"),
        Stargazer(id: 4, name: "e" , avatarUrl: "url"),
        Stargazer(id: 5, name: "f" , avatarUrl: "url"),
        Stargazer(id: 6, name: "g" , avatarUrl: "url"),
        Stargazer(id: 7, name: "h" , avatarUrl: "url"),
        Stargazer(id: 8, name: "i" , avatarUrl: "url"),
        Stargazer(id: 9, name: "l" , avatarUrl: "url"),
        Stargazer(id: 10, name: "m" , avatarUrl: "url"),
        Stargazer(id: 11, name: "n" , avatarUrl: "url"),
        Stargazer(id: 12, name: "o" , avatarUrl: "url"),
        Stargazer(id: 13, name: "p" , avatarUrl: "url"),
        Stargazer(id: 14, name: "q" , avatarUrl: "url"),
        Stargazer(id: 15, name: "r" , avatarUrl: "url"),
        Stargazer(id: 16, name: "s" , avatarUrl: "url"),
        Stargazer(id: 17, name: "t" , avatarUrl: "url"),
        Stargazer(id: 18, name: "u" , avatarUrl: "url"),
        Stargazer(id: 19, name: "v" , avatarUrl: "url")
    ]
    
}
