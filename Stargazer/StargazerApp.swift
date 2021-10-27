import SwiftUI
import Moya

@main
struct StargazerApp: App {
    var body: some Scene {
        WindowGroup {
            StargazerList(viewModel: StargazerViewModel(service: GithubClient(provider: MoyaProvider<Github>())))
        }
    }
}
