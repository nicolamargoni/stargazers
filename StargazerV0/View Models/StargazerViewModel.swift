import Combine
import SwiftUI

class StargazerViewModel: ObservableObject {
    private let service: GithubService
    
    @Published private(set) var state = State()
    
    init(service: GithubService) {
        self.service = service
    }
    
    func didFormSubmit(owner: String, repo: String) {
        state.owner = owner
        state.repo = repo
        state.allDataLoaded = false
        state.list = nil
        
        fetchStargazers()
    }
    
    func loadMore() {
        fetchStargazers()
    }

    private func fetchStargazers() {
        service.stargazers(owner: state.owner, repo: state.repo, perPage: RESULTS_PER_PAGE, page: nextPage()) { [weak self] stargazers in
            guard let self = self else { return }
            
            guard let stargazers = stargazers else {
                //ERROR
                return
            }
            
            if self.state.list == nil {
                self.state.list = []
            }
            
            if stargazers.count < self.RESULTS_PER_PAGE {
                self.state.allDataLoaded = true
            }
            
            self.state.list?.append(contentsOf: stargazers)
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
    }
}
