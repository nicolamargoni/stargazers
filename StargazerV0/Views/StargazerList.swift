import SwiftUI

struct StargazerList: View {
    @ObservedObject var viewModel: StargazerViewModel
    
    @State private var owner: String = ""
    @State private var repo: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                form()
                list()
                Spacer()
            }.navigationBarTitle("Stargazers")
        }
    }
    
    fileprivate func form() -> some View {
        VStack {
            textField(title: "owner", value: $owner)
            textField(title: "repo", value: $repo)
            
            VStack(alignment: .center, spacing: 10) {
                HStack(alignment: .center, spacing: 20) {
                    if (viewModel.state.isLoading) {
                        ProgressView()
                    } else {
                        button(title: "Search") {
                            viewModel.didFormSubmit(owner: owner, repo: repo)
                        }
                    }
                }.frame(height: 40)

                if let error = viewModel.state.error {
                    Text(error)
                        .foregroundColor(.red)
                }
            }
        }
    }
    
    fileprivate func list() -> some View {
        List {
            if let list = viewModel.state.list {
                ForEach(list) { stargazer in
                    StargazerRow(stargazer: stargazer)
                }
                
                if !viewModel.state.allDataLoaded {
                    HStack {
                        Spacer()
                        ProgressView()
                            .onAppear {
                                viewModel.loadMore()
                            }
                        Spacer()
                    }
                }
            }
        }
    }
    
    private func button(title: String, action: @escaping () -> Void) -> some View {
        Button(title) {
            hideKeyboard()
            action()
        }
        .padding()
        .clipShape(Capsule())
    }
    
    private func textField(title: String, value: Binding<String>) -> some View {
        TextField(title, text: value)
            .textFieldStyle(.roundedBorder)
            .disableAutocorrection(true)
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
    }
}

struct StargazerList_Previews: PreviewProvider {
    
    static var previews: some View {
        StargazerList(viewModel: StargazerViewModel(service: GithubClient()))
    }
}
