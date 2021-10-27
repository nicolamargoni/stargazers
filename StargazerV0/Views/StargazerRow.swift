import SwiftUI
import Kingfisher

struct StargazerRow: View {
    var stargazer: Stargazer
    
    var body: some View {
        HStack(spacing: 20) {
            KFImage(URL(string: stargazer.avatarUrl))
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            Text(stargazer.name)
            Spacer()
        }
        .padding(10)
    }
}

struct StargazerRow_Previews: PreviewProvider {
    static var previews: some View {
        StargazerRow(stargazer: Stargazer(id:1, name: "nicolamargoni", avatarUrl:"https://avatars.githubusercontent.com/u/32678657?s=40&u=2f73e02cd649af5ee9293d047d95d6a4132647d2&v=4"))
    }
}
