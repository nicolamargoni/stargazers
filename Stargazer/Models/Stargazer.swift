struct Stargazer: Identifiable, Equatable {
    let id: Int
    let name: String
    let avatarUrl: String
}

extension Stargazer: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "login"
        case avatarUrl = "avatar_url"
    }
    
}
