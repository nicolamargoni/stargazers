import SwiftUI
import Kingfisher

struct StargazerRow: View {
    var stargazer: Stargazer
    
    var body: some View {
        HStack(spacing: 20) {
            KFImage(URL(string: stargazer.avatarUrl))
                .resizable()
                .frame(width: 50, height: 50)
            Text(stargazer.name)
            Spacer()
        }
        .padding(20)
       
    }
}

struct StargazerRow_Previews: PreviewProvider {
    static var previews: some View {
        StargazerRow(stargazer: Stargazer(id:1, name: "carlossless", avatarUrl:"https://avatars.githubusercontent.com/u/498906?v=4"))
    }
}
