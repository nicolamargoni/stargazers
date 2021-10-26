import Moya

enum Github {
    case stargazers(owner: String, repo: String, page: Int)
}

extension Github: TargetType {
    var baseURL: URL { URL(string: "https://api.github.com")! }
    
    var path: String {
        switch self {
        case .stargazers(let owner, let repo, _):
            return "/repos/\(owner)/\(repo)/stargazers"
        }
    }
    
    var method: Method {
        switch self {
        case .stargazers:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .stargazers(_,_, let page):
            return .requestParameters(parameters: ["page":page], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        ["Content-type": "application/json"]
    }
    
}
