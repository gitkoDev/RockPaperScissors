//
//  AgainstPlayerView.swift
//  RockPaperScissors
//
//  Created by Gitko Denis on 27.02.2023.
//

import SwiftUI
import WrappingStack

struct MultiplayerView: View {
	@StateObject var viewsSettings = ViewsSettings()
	@State private var gameMode: ViewsSettings.GameModes = .multiplayer

    var body: some View {
			ZStack {
				BackgroundColor(viewsSettings: viewsSettings)

				VStack(spacing: 0) {

					HStack {
						Spacer()
						
//						MARK: Players' score
						HStack {
							Text("\(viewsSettings.leftSideScoreMultiplayer)")
								.modifier(ScoreModifier(backgroundColor: viewsSettings.leftSideScoreMultiplayerBackground))
								
							Text(":")
								.font(.custom("JosefinSansRoman-Light", size: 35).weight(.medium))
																.foregroundColor(.white)
																.background(
																	RoundedRectangle(cornerRadius: 15).fill(Color(red: 0.7, green: 0.7, blue: 0.7))
																)
							Text("\(viewsSettings.rightSideScoreMultiplayer)")
								.modifier(ScoreModifier(backgroundColor: viewsSettings.rightSideScoreMultiplayerBackground))
						}
						.background(
							RoundedRectangle(cornerRadius: 15).fill(Color(red: 0.7, green: 0.7, blue: 0.7))
						)
						
						

						Spacer()
						DismissButton()
					}
					.padding(.horizontal, 50)
					.padding(.top, 20)
					
					Spacer()
					
//					MARK: Battleboard itself
					
					HStack {
						ObjectsStack(viewsSettings: viewsSettings, gameMode: $gameMode, playerSide: .constant(.left))
						
						Battleboard(viewsSettings: viewsSettings, gameMode: $gameMode)
						
						ObjectsStack(viewsSettings: viewsSettings, gameMode: $gameMode, playerSide: .constant(.right))
					}
					.padding(.horizontal, 50)

				Spacer()
					
				}
			}
			.ignoresSafeArea()
    }
}

struct AgainstPlayerView_Previews: PreviewProvider {
    static var previews: some View {
			MultiplayerView()
    }
}

struct ScoreModifier: ViewModifier {
	var backgroundColor: Color
	
	func body(content: Content) -> some View {
		content
		.font(.custom("JosefinSansRoman-Light", size: 35).weight(.medium))
		.foregroundColor(.white)
									.padding()
									.padding(.horizontal)
									.background(
										RoundedRectangle(cornerRadius: 15)
											.fill(backgroundColor)
									)
	}
}
