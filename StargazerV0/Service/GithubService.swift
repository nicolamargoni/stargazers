import Moya

protocol GithubService {
    func stargazers(owner: String, repo: String, completion: @escaping ([Stargazer]?) -> Void)
}

class GithubClient: GithubService {
    
    func stargazers(owner: String, repo: String, completion: @escaping ([Stargazer]?) -> Void) {
        MoyaProvider<Github>().request(.stargazers(owner: owner, repo: repo)) { result in
            switch result {
            case .success(let response):
                completion(try? response.map([Stargazer].self))
            case .failure:
                completion(nil)
            }
        }
    }
    
}
