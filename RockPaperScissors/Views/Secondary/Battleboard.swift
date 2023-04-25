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
			if gameMode == .singleplayer {
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
			if gameMode == .multiplayer {
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
											.frame(width: gameMode == .multiplayer ? 350 : 350)
											.frame(height: gameMode == .multiplayer ? 250 : 220)
											.background(.ultraThinMaterial.opacity(1))
											.background(viewsSettings.battleboardBG)
											.clipShape(RoundedRectangle(cornerRadius: 10))
										.shadow(radius: 5)
								}
	
//	MARK: Timer for againstPlayer view
								if gameMode == .multiplayer {

									if !timerStarted {
										Button {
											self.timerStarted = true
											
//											We need a published AND a static property (published one get the view updated, static one gets updated in the superclass so that we can observe the timer and invoke other methods when the time comes
											timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
												viewsSettings.multiplayerTimerSecondsLeft -= 1
												ViewsSettings.multiplayerTimerSecondsLeftStatic -= 1
												
//												The buttons become active when the timer is at 0 and then become disabled after some time elapses
												if viewsSettings.multiplayerTimerSecondsLeft == 0 {
													viewsSettings.areLeftChoiceButtonsDisabledMultiplayer = false
													viewsSettings.areRightChoiceButtonsDisabledMultiplayer = false
													viewsSettings.areAllChoiceButtonsDisabledMultiplayer = false
												}
												
//												One second before the timer ends the buttons get disabled to prevent last second choice and the image animating behind the timer
												
												if viewsSettings.multiplayerTimerSecondsLeft <= -2 {
													viewsSettings.areLeftChoiceButtonsDisabledMultiplayer = true
													viewsSettings.areRightChoiceButtonsDisabledMultiplayer = true
													viewsSettings.areAllChoiceButtonsDisabledMultiplayer = true
												}
												
												if viewsSettings.multiplayerTimerSecondsLeft <= -3 {
													timer?.invalidate()
													viewsSettings.areLeftChoiceButtonsDisabledMultiplayer = true
													viewsSettings.areRightChoiceButtonsDisabledMultiplayer = true
													viewsSettings.areAllChoiceButtonsDisabledMultiplayer = true
													viewsSettings.multiplayerTimerSecondsLeft = 3
													timerStarted = false
//													viewsSettings.decideOutcomeMultiplayer()
												}
												
											})
										} label: {
											Text("Start timer")
												.buttonsModifier()
										}
									} else if timerStarted && viewsSettings.multiplayerTimerSecondsLeft <= 0 && viewsSettings.multiplayerTimerSecondsLeft >= -3 {
											Text("Go!")
												.modifier(settingsTitleModifier())
												.offset(y: -70)
												.opacity(viewsSettings.multiplayerTimerSecondsLeft < 0 ? 0 : 1)
									}
									else {
										Text("\(viewsSettings.multiplayerTimerSecondsLeft)")
											.modifier(settingsTitleModifier())
									}
							}
					}
			}

    }
}

struct Battleboard_Previews: PreviewProvider {
    static var previews: some View {
			Battleboard(viewsSettings: ViewsSettings(), gameMode: .constant(ViewsSettings.GameModes.multiplayer))
    }
}
