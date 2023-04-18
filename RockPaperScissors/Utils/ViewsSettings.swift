//
//  GeneralProperties.swift
//  RockPaperScissors
//
//  Created by Gitko Denis on 13.03.2023.
//

import SwiftUI

class ViewsSettings: ObservableObject {
	enum GameModes: String {
		case againstCPU 
		case againstPlayer
	}
	
	enum PlayerSides {
		case left
		case right
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
	@Published var buttonsShadow: CGFloat = 5
	@Published var chosenObjectScale: CGSize = CGSize(width: 1, height: 1)
	
	@Published var againstPlayerTimerSecondsLeft: Int = 3
	static var againstPlayerTimerSecondsLeftStatic = 3
	
	let animationTimerDelay: Double = 2

	func chooseAnObjectAgainstCPUMode(leftObj: ChoiceOptions, rightObj: ChoiceOptions) {
//		Change battleboard images style if the toggle has been switched
		if !isToggleOn {
			leftSideChoice = leftObj.rawValue
			rightSideChoice = rightObj.rawValue
		} else {
			leftSideChoice = leftObj.rawValue + "Alt"
			rightSideChoice = rightObj.rawValue + "Alt"
		}
	

		areChoiceButtonsDisabled = true

		if leftObj == rightObj {
			finishedInADraw()
		} else if leftObj == .Rock {
			if rightObj == .Lizard || rightObj == .Scissors {
				userWins()
			} else {
				computerWins()
			}
		} else if leftObj == .Paper {
			if rightObj == .Paper || rightObj == .Spock {
				userWins()
			} else {
				computerWins()
			}
		} else if leftObj == .Scissors {
			if rightObj == .Paper || rightObj == .Lizard {
				userWins()
			} else {
				computerWins()
			}
		} else if leftObj == .Lizard {
			if rightObj == .Spock || rightObj == .Paper {
				userWins()
			} else {
				computerWins()
			}
		} else if leftObj == .Spock {
			if rightObj == .Scissors || rightObj == .Rock {
				userWins()
			} else {
				computerWins()
			}
		}

		DispatchQueue.main.asyncAfter(deadline: .now() + animationTimerDelay) {
			self.leftSideChoice = ""
			self.rightSideChoice = ""
			
			self.areChoiceButtonsDisabled = false
		}
	}
	
	func chooseObjectsAgainstPlayerMode(playerSide: PlayerSides, chosenObject: ChoiceOptions) {
		//		Change battleboard images style if the toggle has been switched
		if !isToggleOn {
			if playerSide == .left {
				leftSideChoice = chosenObject.rawValue
			} else {
				rightSideChoice = chosenObject.rawValue
			}
		} else {
			if playerSide == .left {
				leftSideChoice = chosenObject.rawValue + "Alt"
			} else {
				rightSideChoice = chosenObject.rawValue + "Alt"
			}
		}
		
		DispatchQueue.main.asyncAfter(deadline: .now() + animationTimerDelay) {
			self.leftSideChoice = ""
			self.rightSideChoice = ""
		}
		
		animateRound()
	}
	
	func leftPlayerChooseAnObject() {
//		animateRound()
	}
	
	func rightPlayerChooseAnObject() {
		print("right chosen")
	}
	
	func playerChoseTooEarly() {
		print("too early!")
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

		DispatchQueue.main.asyncAfter(deadline: .now() + animationTimerDelay) {
			self.outcome = .NotStarted
			self.battleboardAnimation(outcome: self.outcome)
			self.leftObjectOffset = -130
			self.rightObjectOffset = 130
			
			withAnimation(.easeOut(duration: 0.2)) {
				self.chosenObjectScale = CGSize(width: 1, height: 1)
				self.buttonsShadow = 4
			}
		}
	}

	func battleboardAnimation(outcome: RoundOutcomes) {
		withAnimation(.easeIn(duration: 0.2)) {
			chosenObjectScale = CGSize(width: 0.85, height: 0.85)
			self.buttonsShadow = 0
		}
		
		withAnimation(.easeOut(duration: 1)) {
			
			switch outcome {
			case .LeftSideWins:
				battleboardBG = .victoryBackround
			case .RightSideWins:
				battleboardBG = .defeatBackground
			case .Draw:
				battleboardBG = .drawBackground
			default:
				battleboardBG = .white.opacity(0)
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



