import SwiftUI

struct StargazerList: View {
    @ObservedObject var viewModel: StargazerViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.state.isLoading {
                    ProgressView()
                }
                List {
                    ForEach(viewModel.state.list) { stargazer in
                        StargazerRow(stargazer: stargazer)
                    }
                    HStack {
                        Spacer()
                        ProgressView().onAppear {
                            viewModel.loadMore()
                        }
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("Stargazers")
            .onAppear {
                viewModel.didFormSubmit(owner: "Moya", repo: "Moya")
            }
        }
    }
    
}

struct StargazerList_Previews: PreviewProvider {
    
    static var previews: some View {
        StargazerList(viewModel: StargazerViewModel(service: GithubClient()))
    }
}
