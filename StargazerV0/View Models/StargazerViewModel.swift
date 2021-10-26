import Combine
import SwiftUI

class StargazerViewModel: ObservableObject {
    private let service: GithubService
    
    @Published private(set) var state = State.loading
    
    init(service: GithubService) {
        self.service = service
    }
    
    func loadStargazers(owner: String, repo: String) {
        service.stargazers(owner: owner, repo: repo) { [weak self] list in
            guard let self = self else { return }
            
            guard let list = list else {
                self.state = .error("Si è verificato un errore...")
                return
            }
            
            self.state = .loaded(list)
        }
    }
    
}

extension StargazerViewModel {
    enum State {
        case loading
        case loaded([Stargazer])
        case error(String)
    }
}
