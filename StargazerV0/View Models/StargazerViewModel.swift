import Combine
import SwiftUI

class StargazerViewModel: ObservableObject {
    private let service: GithubService
    
    @Published private(set) var state: State
    
    init(service: GithubService, state: State = State()) {
        self.service = service
        self.state = state
    }
    
    func didFormSubmit(owner: String, repo: String) {
        state.owner = owner
        state.repo = repo
        state.allDataLoaded = false
        state.list = nil
        state.error = nil
        
        state.isLoading = true
        fetchStargazers {
            self.state.isLoading = false
        }
    }
    
    func loadMore() {
        fetchStargazers {}
    }

    private func fetchStargazers(completion: @escaping () -> Void) {
        service.stargazers(owner: state.owner, repo: state.repo, perPage: RESULTS_PER_PAGE, page: nextPage()) { [weak self] result in
            guard let self = self else { return }
            
            defer {
                completion()
            }
            
            switch result {
            case .success(let stargazers):
                if self.state.list == nil {
                    self.state.list = []
                }
                
                if stargazers.count < self.RESULTS_PER_PAGE {
                    self.state.allDataLoaded = true
                }
                
                self.state.list! += stargazers
            case .failure(let error):
                self.state.error = error.errorDescription
            }
        }
    }
    
    private func nextPage() -> Int {
        guard let count =  state.list?.count else {
            return 1
        }
        
        return (count / RESULTS_PER_PAGE) + 1
    }
    
    private let RESULTS_PER_PAGE = 10
}

extension StargazerViewModel {
    struct State {
        var owner = ""
        var repo = ""
        var allDataLoaded = false
        var list: [Stargazer]?
        var error: String?
        var isLoading = false
    }
}
