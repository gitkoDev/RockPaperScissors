//
//  Extensions.swift
//  RockPaperScissors
//
//  Created by Gitko Denis on 01.03.2023.
//

import SwiftUI

extension Color {
	static let background = RadialGradient(colors: [Color("Background1"), Color("Background2")], center: .leading, startRadius: 300, endRadius: 600)
	static let backgroundAlt = RadialGradient(colors: [.blue, .mint], center: .leading, startRadius: 300, endRadius: 600)
	static let toggleButtonBackground = LinearGradient(colors: [Color("Background1"), Color("Background2")], startPoint: .topLeading, endPoint: .bottomTrailing)
	static let victoryBackround = Color("Victory background")
	static let defeatBackground = Color("Defeat background")
	static let drawBackground = Color("Draw background")
}

extension View {
	func buttonsModifier() -> some View {
		modifier(MenuButtons())
	}
}

