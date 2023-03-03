//
//  Extensions.swift
//  RockPaperScissors
//
//  Created by Gitko Denis on 01.03.2023.
//

import SwiftUI

extension Color {
	static let background = LinearGradient(colors: [Color("Background 1"), Color("Background 2")], startPoint: .topLeading, endPoint: .bottomTrailing)
	static let victoryBackround = Color("Victory background")
	static let defeatBackground = Color("Defeat background")
}

extension View {
	func buttonsModifier() -> some View {
		modifier(MenuButtons())
	}
	func battleboardModifier(outcome: RoundOutcomes) -> some View {
		modifier(BattleboardModifier(outcome: outcome))
	}
	func countdownModifier() -> some View {
		modifier(Countdown())
	}
}

