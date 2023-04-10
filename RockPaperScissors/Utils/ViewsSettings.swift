//
//  GeneralProperties.swift
//  RockPaperScissors
//
//  Created by Gitko Denis on 13.03.2023.
//

import SwiftUI

class ViewsSettings: ObservableObject {
	enum GameModes: String {
		case againstCPU = "CPU"
		case againstPlayer = "Player"
	}
	
	@AppStorage("isToggleOn") var isToggleOn: Bool = false

	@Published var leftSideChoice: String = ""
	@Published var rightSideChoice: String = ""

	@Published var outcome: RoundOutcomes = .Draw

	@Published var userScore = 0

	@Published var areChoiceButtonsDisabled = false

	@Published var battleboardBG: Color = .white.opacity(0)
	@Published var leftObjectOffset: CGFloat = -120
	@Published var rightObjectOffset: CGFloat = 120
	@Published var scoreBounceOffset: CGFloat = 0
	
	@Published var chosenObjectScale: CGSize = CGSize(width: 1, height: 1)
	
	let timerDelay: Double = 2

	func chooseAnObject(userObj: ChoiceOptions, computerObj: ChoiceOptions) {
//		Change battleboard images style if the toggle has been switched
		if !isToggleOn {
			leftSideChoice = userObj.rawValue
			rightSideChoice = computerObj.rawValue
		} else {
			leftSideChoice = userObj.rawValue + "Alt"
			rightSideChoice = computerObj.rawValue + "Alt"
		}
	

		DispatchQueue.main.asyncAfter(deadline: .now() + timerDelay) {
			self.areChoiceButtonsDisabled = false
		}
		areChoiceButtonsDisabled = true
		

		if userObj == computerObj {
			finishedInADraw()
		} else if userObj == .Rock {
			if computerObj == .Lizard || computerObj == .Scissors {
				userWins()
			} else {
				computerWins()
			}
		} else if userObj == .Paper {
			if computerObj == .Paper || computerObj == .Spock {
				userWins()
			} else {
				computerWins()
			}
		} else if userObj == .Scissors {
			if computerObj == .Paper || computerObj == .Lizard {
				userWins()
			} else {
				computerWins()
			}
		} else if userObj == .Lizard {
			if computerObj == .Spock || computerObj == .Paper {
				userWins()
			} else {
				computerWins()
			}
		} else if userObj == .Spock {
			if computerObj == .Scissors || computerObj == .Rock {
				userWins()
			} else {
				computerWins()
			}
		}

		DispatchQueue.main.asyncAfter(deadline: .now() + timerDelay) {
			self.leftSideChoice = ""
			self.rightSideChoice = ""
		}
	}

	func userWins() {
		outcome = .LeftSideWins
		userScore += 1
		animateRound()
	}

	func computerWins() {
		outcome = .RightSideWins
		userScore -= 1
		animateRound()
	}

	func finishedInADraw() {
		outcome = .Draw
		animateRound()
	}

	func animateRound() {
		battleboardAnimation(outcome: outcome)
		scoreAnimation()

		DispatchQueue.main.asyncAfter(deadline: .now() + timerDelay) {
			self.outcome = .NotStarted
			self.battleboardAnimation(outcome: self.outcome)
			self.leftObjectOffset = -130
			self.rightObjectOffset = 130
			
			withAnimation(.easeOut(duration: 0.2)) {
				self.chosenObjectScale = CGSize(width: 1, height: 1)
			}
		}
	}

	func battleboardAnimation(outcome: RoundOutcomes) {
		withAnimation(.easeIn(duration: 0.2)) {
			chosenObjectScale = CGSize(width: 0.85, height: 0.85)
		}
		
		withAnimation(.easeOut(duration: 1)) {
			
			switch outcome {
			case .LeftSideWins:
				battleboardBG = .victoryBackround
				print(leftObjectOffset)
			case .RightSideWins:
				battleboardBG = .defeatBackground
				print("you lose")
			case .Draw:
				battleboardBG = .drawBackground
				print("battleboardBG")
			default:
				battleboardBG = .white.opacity(0)
				print("default")
			}
			
			leftObjectOffset = 0
			rightObjectOffset = 0
		}
	}

	func scoreAnimation() {
		withAnimation(.spring(response: 1, dampingFraction: 1, blendDuration: 0)) {
			scoreBounceOffset = -30
		}

		DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
			withAnimation(.spring()) {
				self.scoreBounceOffset = 0
			}
		}
	}
}



