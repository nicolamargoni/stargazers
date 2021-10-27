import Moya

protocol GithubService {
    func stargazers(owner: String, repo: String, perPage: Int, page: Int, completion: @escaping ([Stargazer]?) -> Void)
}

class GithubClient: GithubService {
    
    func stargazers(owner: String, repo: String, perPage: Int, page: Int, completion: @escaping ([Stargazer]?) -> Void) {
        MoyaProvider<Github>().request(.stargazers(owner: owner, repo: repo, perPage: perPage, page: page)) { result in
            switch result {
            case .success(let response):
                completion(try? response.map([Stargazer].self))
            case .failure:
                completion(nil)
            }
        }
    }
    
}
