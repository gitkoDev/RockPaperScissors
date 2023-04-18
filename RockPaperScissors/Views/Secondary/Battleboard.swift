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
	
	enum Sides {
		case leftPlayer, rightPlayer
	}

	@State private var timerStarted: Bool = false
	@State private var timer: Timer?
	@State private var secondsLeft = 3
	
	
    var body: some View {
//			MARK: againstCPU view design
			if gameMode == .againstCPU {
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
							.frame(width: 350, height: 220)
							.background(.ultraThinMaterial.opacity(1))
							.background(viewsSettings.battleboardBG)
							.clipShape(RoundedRectangle(cornerRadius: 10))
						.shadow(radius: 5)
					
					Text("score: \(viewsSettings.userScore)")
			.font(.custom("JosefinSansRoman-Light", size: 35).weight(.medium))
							.foregroundColor(.white)
							.padding()
							.background(
								RoundedRectangle(cornerRadius: 10).fill(Color(red: 0.6, green: 0.6, blue: 0.6))
							)
							.offset(y: -75)
				}
			}
			
//			MARK: againstPlayer view design
			if gameMode == .againstPlayer {
							ZStack {
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
											.frame(width: gameMode == .againstPlayer ? 350 : 350)
											.frame(height: gameMode == .againstPlayer ? 250 : 220)
											.background(.ultraThinMaterial.opacity(1))
											.background(viewsSettings.battleboardBG)
											.clipShape(RoundedRectangle(cornerRadius: 10))
										.shadow(radius: 5)
								}
	
//	MARK: Timer for againstPlayer view
								if gameMode == .againstPlayer {

									if !timerStarted {
										Button {
											self.timerStarted = true
											viewsSettings.areChoiceButtonsDisabled = true
											
											print(viewsSettings.leftSideChoice, viewsSettings.rightSideChoice)
											
											timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
												viewsSettings.againstPlayerTimerSecondsLeft -= 1
												ViewsSettings.againstPlayerTimerSecondsLeftStatic -= 1
												
//												The buttons become active when the timer is at 0 and then become disabled after some time elapses
												
												if viewsSettings.againstPlayerTimerSecondsLeft == 0 {
													viewsSettings.areChoiceButtonsDisabled = false
												}
												
												if viewsSettings.againstPlayerTimerSecondsLeft <= -2 {
													timer?.invalidate()
													viewsSettings.areChoiceButtonsDisabled = true
													viewsSettings.againstPlayerTimerSecondsLeft = 3
													timerStarted = false
												}
												
											})
										} label: {
											Text("Start timer")
												.buttonsModifier()
										}
									} else if timerStarted && viewsSettings.againstPlayerTimerSecondsLeft <= 0 && viewsSettings.againstPlayerTimerSecondsLeft >= -2 {
											Text("Go!")
												.modifier(settingsTitleModifier())
									}
									else {
										Text("\(viewsSettings.againstPlayerTimerSecondsLeft)")
											.modifier(settingsTitleModifier())
									}
							}
					}
			}

    }
}

struct Battleboard_Previews: PreviewProvider {
    static var previews: some View {
			Battleboard(viewsSettings: ViewsSettings(), gameMode: .constant(ViewsSettings.GameModes.againstPlayer))
    }
}
