//
//  StargazerV0App.swift
//  StargazerV0
//
//  Created by Nicola Margoni on 25/10/21.
//

import SwiftUI
import Moya

@main
struct StargazerV0App: App {
    var body: some Scene {
        WindowGroup {
            StargazerList(viewModel: StargazerViewModel(service: GithubClient(provider: MoyaProvider<Github>())))
        }
    }
}
