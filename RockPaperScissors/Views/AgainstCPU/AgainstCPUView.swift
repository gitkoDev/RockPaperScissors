//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Gitko Denis on 16.02.2023.
//

import SwiftUI
import WrappingStack

struct AgainstCPUView: View {
	@AppStorage("isToggleOn") private var isToggleOn: Bool = false
	@StateObject var viewsSettings = ViewsSettings()
	@State private var gameMode: ViewsSettings.GameModes = .againstCPU
	
    var body: some View {
			ZStack() {
				BackgroundColor(viewsSettings: viewsSettings)
				
				VStack(spacing: 20) {
					
					Spacer().frame(height: 35)
					HStack {
						DismissButton()
						Spacer()
					}
					.padding(30)
		// MARK: Battleboard
					
					Spacer().frame(height: 15)
					
					Battleboard(viewsSettings: viewsSettings, gameMode: $gameMode)
					
					Spacer().frame(height: 20)
					
					// MARK: User score
					Text("score: \(viewsSettings.userScore)")
						.font(.custom("JosefinSansRoman-Light", size: 60).weight(.light))
						.foregroundColor(Color(red: 0.25, green: 0.25, blue: 0.25))
						.offset(y: viewsSettings.scoreBounceOffset)

					Spacer()
					
					//	MARK: User choice buttons
					
					ObjectsStack(viewsSettings: viewsSettings, gameMode: $gameMode)
					
					Spacer()
				}
				
			}
			.ignoresSafeArea()
    }
	
//	init() {
//		for fontFamily in UIFont.familyNames {
//			print(fontFamily)
//			for fontName in UIFont.fontNames(forFamilyName: fontFamily) {
//				print("-- \(fontName)")
//			}
//		}
//	}
	
	
//	MARK: Properties and methods
	
//	func chooseAnObject(userObj: ChoiceOption, computerObj: ChoiceOption) {
//		print("user chose \(userObj)")
////		usersChoice = userObj.rawValue
////		computersChoice = computerObj.rawValue
//
//		viewModel.leftSideChoice = userObj.rawValue
//		viewModel.rightSideChoice = computerObj.rawValue
//
//		DispatchQueue.main.asyncAfter(deadline: .now() + viewModel.timerDelay) {
//			viewModel.areChoiceButtonsDisabled = false
//		}
//		viewModel.areChoiceButtonsDisabled = true
//
//		if userObj == computerObj {
//			finishedInADraw()
//		} else if userObj == .Rock {
//			if computerObj == .Lizard || computerObj == .Scissors {
//				userWins()
//			} else {
//				computerWins()
//			}
//		} else if userObj == .Paper {
//			if computerObj == .Paper || computerObj == .Spock {
//				userWins()
//			} else {
//				computerWins()
//			}
//		} else if userObj == .Scissors {
//			if computerObj == .Paper || computerObj == .Lizard {
//				userWins()
//			} else {
//				computerWins()
//			}
//		} else if userObj == .Lizard {
//			if computerObj == .Spock || computerObj == .Paper {
//				userWins()
//			} else {
//				computerWins()
//			}
//		} else if userObj == .Spock {
//			if computerObj == .Scissors || computerObj == .Rock {
//				userWins()
//			} else {
//				computerWins()
//			}
//		}
//
//
//		DispatchQueue.main.asyncAfter(deadline: .now() + viewModel.timerDelay) {
//			viewModel.leftSideChoice = ""
//			viewModel.rightSideChoice = ""
//		}
//	}
		
//	func userWins() {
//		viewModel.outcome = .LeftSideWins
//		viewModel.userScore += 1
////		animateRound()
//	}
//
//	func computerWins() {
//		viewModel.outcome = .RightSideWins
//		viewModel.userScore -= 1
////		animateRound()
//	}
//
//	func finishedInADraw() {
//		viewModel.outcome = .Draw
////		animateRound()
//	}
	
//	func battleboardAnimation(outcome: RoundOutcomes) {
//		withAnimation(.easeOut(duration: 1)) {
//			switch outcome {
//			case .LeftSideWins:
//				viewModel.battleboardBG = .victoryBackround
//			case .RightSideWins:
//				viewModel.battleboardBG = .defeatBackground
//			case .Draw:
//				viewModel.battleboardBG = .drawBackground
//			default:
//				viewModel.battleboardBG = .white.opacity(0)
//			}
//
//			viewModel.leftObjectOffset = 0
//			viewModel.rightObjectOffset = 0
//
//
//		}
//	}
	
//	func scoreAnimation() {
//		withAnimation(.spring(response: 1, dampingFraction: 1, blendDuration: 0)) {
//			viewModel.scoreBounceOffset = -20
//		}
//
//		DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
//			withAnimation(.spring()) {
//				viewModel.scoreBounceOffset = 0
//			}
//		}
//	}
	
//	func animateRound() {
//		battleboardAnimation(outcome: viewModel.outcome)
//		scoreAnimation()
//
//		DispatchQueue.main.asyncAfter(deadline: .now() + viewModel.timerDelay) {
//			viewModel.outcome = .NotStarted
//
//			battleboardAnimation(outcome: viewModel.outcome)
//
//			viewModel.leftObjectOffset = -130
//			viewModel.rightObjectOffset = 130
//
//		}
//	}
	
	}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
			AgainstCPUView()
    }
}

