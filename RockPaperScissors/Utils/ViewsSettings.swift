//
//  GeneralProperties.swift
//  RockPaperScissors
//
//  Created by Gitko Denis on 13.03.2023.
//

import SwiftUI

class ViewsSettings: ObservableObject {
	enum GameModes: String {
		case singleplayer
		case multiplayer
	}
	
	enum PlayerSides {
		case left
		case right
	}
	
	@AppStorage("isToggleOn") var isToggleOn: Bool = false
	
//	MARK: Singleplayer specific properties
	@Published var userScore = 0
	@Published var areChoiceButtonsDisabledSingleplayer = false
	
	
//	MARK: Multiplayer specific properties
	@Published var leftSideScore = 0
	@Published var righSideScore = 0
	
	enum ChoiceButtonsBackgroundVariants: String {
		case enabled = "Background1"
		case disabled = "Background2"
	}
	
	@Published var leftSideChoiceButtonsBackground: ChoiceButtonsBackgroundVariants = .disabled
	@Published var rightSideChoiceButtonsBackground: ChoiceButtonsBackgroundVariants = .disabled
	
	@Published var areLeftChoiceButtonsDisabledMultiplayer = true {
		didSet {
			if self.areLeftChoiceButtonsDisabledMultiplayer == true {
				self.leftSideChoiceButtonsBackground = .disabled
			} else {
				self.leftSideChoiceButtonsBackground = .enabled
			}
		}
	}
	
	@Published var areRightChoiceButtonsDisabledMultiplayer = true {
		didSet {
			if self.areRightChoiceButtonsDisabledMultiplayer == true {
				self.rightSideChoiceButtonsBackground = .disabled
			} else {
				self.rightSideChoiceButtonsBackground = .enabled
			}
		}
	}
	
	@Published var areAllChoiceButtonsDisabledMultiplayer = true
	
//	MARK: General properties
	
	@Published var leftSideChoice: String = ""
	@Published var rightSideChoice: String = ""
	
	@Published var outcome: RoundOutcomes = .Draw
	
	@Published var battleboardBG: Color = .white.opacity(0)
	@Published var leftObjectOffset: CGFloat = -130
	@Published var rightObjectOffset: CGFloat = 130
	@Published var buttonsShadow: CGFloat = 5
	@Published var chosenObjectScale: CGSize = CGSize(width: 1, height: 1)
	
	@Published var multiplayerTimerSecondsLeft: Int = 3
	static var multiplayerTimerSecondsLeftStatic = 3
	
	let animationTimerDelay: Double = 2
	
	
	
	
	//	MARK: Singleplayer related methods
	
	func chooseAnObjectSingleplayer(leftObj: ChoiceOptions, rightObj: ChoiceOptions) {
		//		Change battleboard images style if the toggle has been switched
		if !isToggleOn {
			leftSideChoice = leftObj.rawValue
			rightSideChoice = rightObj.rawValue
		} else {
			leftSideChoice = leftObj.rawValue + "Alt"
			rightSideChoice = rightObj.rawValue + "Alt"
		}
		
		//		Player cannot choose more than one object at a time
		areChoiceButtonsDisabledSingleplayer = true
		
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
			
			self.areChoiceButtonsDisabledSingleplayer = false
		}
	}
	
	func decideOutcome() {
		print("decided")
	}
	
	func animateRoundSingleplayer() {
		battleboardAnimation(outcome: outcome)
		
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
	
	
	
	
	//	MARK: Multiplayer related methods
	
	func chooseObjectsMultiplayer(playerSide: PlayerSides, chosenObject: ChoiceOptions) {
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
		
//		Player cannot choose more than one object at a time
		if playerSide == .left {
			print("left chosen")
			areLeftChoiceButtonsDisabledMultiplayer = true
		} else if playerSide == .right {
			areRightChoiceButtonsDisabledMultiplayer = true
		}
		
		DispatchQueue.main.asyncAfter(deadline: .now() + animationTimerDelay) {
			self.leftSideChoice = ""
			self.rightSideChoice = ""
			
//			self.areChoiceButtonsDisabled = false
		}
		
		animateRoundMultiplayer(playerSide: playerSide)
	}
	
	func animateRoundMultiplayer(playerSide: PlayerSides) {
		withAnimation(.easeOut(duration: 1)) {
			if playerSide == .left {
				leftObjectOffset = 0
			} else {
				rightObjectOffset = 0
			}


		}
		
		withAnimation(.easeIn(duration: 0.2)) {
			chosenObjectScale = CGSize(width: 0.85, height: 0.85)
			self.buttonsShadow = 0
		}
		
		DispatchQueue.main.asyncAfter(deadline: .now() + animationTimerDelay) {
			self.leftObjectOffset = -130
			self.rightObjectOffset = 130
			
			withAnimation(.easeOut(duration: 0.2)) {
				self.chosenObjectScale = CGSize(width: 1, height: 1)
				self.buttonsShadow = 4
			}
		}
	}
	
	func userWins() {
		outcome = .LeftSideWins
		userScore += 1
		animateRoundSingleplayer()
	}
	
	func computerWins() {
		outcome = .RightSideWins
		userScore -= 1
		animateRoundSingleplayer()
	}
	
	func finishedInADraw() {
		outcome = .Draw
		animateRoundSingleplayer()
	}
	
	func battleboardAnimationMultiplayer() {
		leftObjectOffset = -100
		rightObjectOffset = -100
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
	
}



