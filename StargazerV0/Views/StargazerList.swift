import SwiftUI

struct StargazerList: View {
    var stargazers: [Stargazer]
    
    var body: some View {
        List(stargazers) { stargazer in
            StargazerRow(stargazer: stargazer)
        }
    }
}

struct StargazerList_Previews: PreviewProvider {

    static var previews: some View {
        let stargazers = [
            Stargazer(id: 1, name: "mhilscher", avatarUrl: "https://avatars.githubusercontent.com/u/1460604?v=4"),
            Stargazer(id: 2, name: "kaishin", avatarUrl: "https://avatars.githubusercontent.com/u/519433?v=4"),
            Stargazer(id: 3, name: "ishanthukral", avatarUrl: "https://avatars.githubusercontent.com/u/3012375?v=4")
        ]
        
        StargazerList(stargazers: stargazers)
    }
}
