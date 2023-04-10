//
//  Battleboard.swift
//  RockPaperScissors
//
//  Created by Gitko Denis on 20.03.2023.
//

import SwiftUI

struct Battleboard: View {
	@ObservedObject var viewsSettings: ViewsSettings
	@Binding var gameMode: ViewsSettings.GameModes
	
    var body: some View {
			VStack {
				HStack(alignment: .bottom) {
							Image(viewsSettings.leftSideChoice)
								.resizable()
								.frame(width: 80, height: 80)
								.offset(x: viewsSettings.leftObjectOffset)
								.offset(y: -20)
							Spacer().frame(width: 100)
						
						
							Image(viewsSettings.rightSideChoice)
								.resizable()
								.frame(width: 80, height: 80)
								.offset(x: viewsSettings.rightObjectOffset)
								.offset(y: -20)
						}
						.frame(width: gameMode == .againstPlayer ? 300 : 350)
						.frame(height: gameMode == .againstPlayer ? 220 : 220)
						.background(.ultraThinMaterial.opacity(1))
						.background(viewsSettings.battleboardBG)
						.clipShape(RoundedRectangle(cornerRadius: 10))
					.shadow(radius: 5)
			}
			
			if gameMode == .againstCPU {
							Text("score: \(viewsSettings.userScore)")
					.font(.custom("JosefinSansRoman-Light", size: 35).weight(.medium))
									.foregroundColor(.white)
									.padding()
									.background(
										RoundedRectangle(cornerRadius: 10).fill(Color(red: 0.6, green: 0.6, blue: 0.6))
									)
									.offset(y: -86.5)
			}
    }
}

struct Battleboard_Previews: PreviewProvider {
    static var previews: some View {
			Battleboard(viewsSettings: ViewsSettings(), gameMode: .constant(ViewsSettings.GameModes.againstPlayer))
    }
}
