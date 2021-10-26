import Moya

protocol GithubService {
    func stargazers(owner: String, repo: String, page: Int, completion: @escaping ([Stargazer]?) -> Void)
}

class GithubClient: GithubService {
    
    func stargazers(owner: String, repo: String, page: Int, completion: @escaping ([Stargazer]?) -> Void) {
        MoyaProvider<Github>().request(.stargazers(owner: owner, repo: repo, page: page)) { result in
            switch result {
            case .success(let response):
                completion(try? response.map([Stargazer].self))
            case .failure:
                completion(nil)
            }
        }
    }
    
}
