//
//  Lab4SwiftUiApp.swift
//  Lab4SwiftUi
//
//  Created by Juan jose Morales on 3/6/24.
//

import SwiftUI

@main
struct Lab4SwiftUiApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: UserViewModel(userRepository: UserRepositoryImpl()))
        }
    }
}
