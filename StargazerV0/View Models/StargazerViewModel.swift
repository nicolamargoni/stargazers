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
        state.list = []
        
        fetchStargazers()
    }
    
    func loadMore() {
        fetchStargazers()
    }

    private func fetchStargazers() {
        state.isLoading = true
        service.stargazers(owner: state.owner, repo: state.repo, page: nextPage()) { [weak self] list in
            guard let self = self else { return }
            
            guard let list = list else {
                self.state.error = "Si è verificato un errore..."
                return
            }
            
            self.state.list.append(contentsOf: list)
            self.state.isLoading = false
        }

    }
    
    private func nextPage() -> Int {
        (state.list.count / ITEMS_FOR_PAGE) + 1
    }
    
    private let ITEMS_FOR_PAGE = 20
}

extension StargazerViewModel {
    struct State {
        var owner = ""
        var repo = ""
        var isLoading = false
        var list = [Stargazer]()
        var error = ""
    }
}
