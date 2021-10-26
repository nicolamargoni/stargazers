import Moya

enum Github {
    case stargazers(owner: String, repo: String)
}

extension Github: TargetType {
    var baseURL: URL { URL(string: "https://api.github.com")! }
    
    var path: String {
        switch self {
        case .stargazers(let owner, let repo):
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
        case .stargazers:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        ["Content-type": "application/json"]
    }
    
}
