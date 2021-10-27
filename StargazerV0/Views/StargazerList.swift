import SwiftUI

struct StargazerList: View {
    @ObservedObject var viewModel: StargazerViewModel
    
    @State private var owner: String = ""
    @State private var repo: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                textField(title: "owner", value: $owner)
                textField(title: "repo", value: $repo)
                Button("Search") {
                    hideKeyboard()
                    viewModel.didFormSubmit(owner: owner, repo: repo)
                }
                .padding()
                .clipShape(Capsule())
                
                if let list = viewModel.state.list {
                    List {
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
                
                Spacer()
            }.navigationBarTitle("Stargazers")
        }
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

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
