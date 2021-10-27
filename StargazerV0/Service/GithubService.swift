import Moya

protocol GithubService {
    func stargazers(owner: String, repo: String, perPage: Int, page: Int, completion: @escaping (Result<[Stargazer], GithubServiceError>) -> Void)
}

class GithubClient: GithubService {
    
    func stargazers(owner: String, repo: String, perPage: Int, page: Int, completion: @escaping (Result<[Stargazer], GithubServiceError>) -> Void) {
        MoyaProvider<Github>().request(.stargazers(owner: owner, repo: repo, perPage: perPage, page: page)) { result in
            switch result {
            case .success(let response):
                switch response.statusCode {
                case 404:
                    completion(.failure(.repositoryNotFound))
                case 200:
                    guard let list: [Stargazer] = try? response.map([Stargazer].self) else {
                        completion(.failure(.genericError))
                        return
                    }
                    completion(.success(list))
                default: completion(.failure(.genericError))
                }
            case .failure:
                completion(.failure(.genericError))
            }
        }
    }
    
}

enum GithubServiceError: Error {
    case repositoryNotFound
    case genericError
    
    var errorDescription: String {
        get {
            switch self {
            case .genericError: return "An error occurred, retry later..."
            case .repositoryNotFound: return "Repository not found"
            }
        }
    }
}
