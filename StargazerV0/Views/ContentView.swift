import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: StargazerViewModel
    
    var body: some View {
        NavigationView {
            content.navigationBarTitle("Stargazers")
            .onAppear {
                viewModel.loadStargazers(owner: "Moya", repo: "Moya")
            }
        }
    }
    
    private var content: some View {
        switch viewModel.state {
        case .loading:
            return ProgressView().eraseToAnyView()
        case .error(let error):
            return Text(error).eraseToAnyView()
        case .loaded(let stargazers):
            return StargazerList(stargazers: stargazers).eraseToAnyView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: StargazerViewModel(service: GithubClient()))
    }
}

extension View {
    func eraseToAnyView() -> AnyView { AnyView(self) }
}
