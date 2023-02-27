//
//  RockPaperScissorsApp.swift
//  RockPaperScissors
//
//  Created by Gitko Denis on 16.02.2023.
//

import SwiftUI

@main
struct RockPaperScissorsApp: App {
	@AppStorage("isOnboarding") var isOnboarding = true
	
    var body: some Scene {
        WindowGroup {
						MainView()
        }
    }
}
