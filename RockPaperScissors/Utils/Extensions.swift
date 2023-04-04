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
	
	static let victoryBackround = Color("Victory background")
	static let defeatBackground = Color("Defeat background")
	static let drawBackground = Color("Draw background")
	
	static let toggleButtonsBackground = LinearGradient(colors: [Color("Background1"), Color("Background2")], startPoint: .topLeading, endPoint: .bottomTrailing)
	static let buttonsBackground = LinearGradient(colors: [.mint, .blue], startPoint: .top, endPoint: .bottom)
	static let buttonsBackgroundAlt = LinearGradient(colors: [.white, .orange, .red], startPoint: .top, endPoint: .bottom)
	
	static let accentPrimary = LinearGradient(colors: [.cyan, .purple], startPoint: .top, endPoint: .bottom)
	
	static let textDarkPrimary = Color(red: 0.2, green: 0.2, blue: 0.2)
	static let textLightPrimary = Color(red: 0.3, green: 0.3, blue: 0.3)
}

extension View {
	func buttonsModifier() -> some View {
		modifier(MenuButtons())
	}
}

