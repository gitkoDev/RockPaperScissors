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
	
//	MARK: Singleplayer specific properties
	@Published var userScore = 0
	@Published var areChoiceButtonsDisabledSingleplayer = false
	@Published var chosenObjectScaleSingleplayer: CGSize = CGSize(width: 1, height: 1)
	
	
//	MARK: Multiplayer specific properties
	@Published var leftSideScoreMultiplayer = 0
	@Published var rightSideScoreMultiplayer = 0
	@Published var leftSideScoreMultiplayerBackground: Color = Color(red: 0.7, green: 0.7, blue: 0.7)
	@Published var rightSideScoreMultiplayerBackground: Color = Color(red: 0.7, green: 0.7, blue: 0.7)
	
	
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
	
	@Published var leftChosenObjectScaleMultiplayer: CGSize = CGSize(width: 1, height: 1)
	@Published var rightChosenObjectScaleMultiplayer: CGSize = CGSize(width: 1, height: 1)
	
//	MARK: General properties
	
	@Published var leftSideChoice: String = ""
	@Published var rightSideChoice: String = ""
	
	@Published var outcome: RoundOutcomes = .Draw
	
	@Published var battleboardBG: Color = .white.opacity(0)
	@Published var leftObjectOffset: CGFloat = -130
	@Published var rightObjectOffset: CGFloat = 130
	@Published var buttonsShadow: CGFloat = 5
	
	@Published var multiplayerTimerSecondsLeft: Int = 3
	static var multiplayerTimerSecondsLeftStatic = 3
	
	let animationTimerDelay: Double = 2
	
	
	
	
	//	MARK: Singleplayer related methods
	
	func chooseAnObjectSingleplayer(leftObj: ChoiceOptions, rightObj: ChoiceOptions) {
			leftSideChoice = leftObj.rawValue
			rightSideChoice = rightObj.rawValue
		
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
	
	func animateRoundSingleplayer() {
		battleboardAnimationSingleplayer(outcome: outcome)
		
		DispatchQueue.main.asyncAfter(deadline: .now() + animationTimerDelay) {
			self.outcome = .NotStarted
			self.battleboardAnimationSingleplayer(outcome: self.outcome)
			self.leftObjectOffset = -130
			self.rightObjectOffset = 130
			
			withAnimation(.easeOut(duration: 0.2)) {
				self.chosenObjectScaleSingleplayer = CGSize(width: 1, height: 1)
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
	
	func battleboardAnimationSingleplayer(outcome: RoundOutcomes) {
		withAnimation(.easeIn(duration: 0.2)) {
			chosenObjectScaleSingleplayer = CGSize(width: 0.85, height: 0.85)
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
	
	//	MARK: Multiplayer related methods
	
	func chooseObjectsMultiplayer(playerSide: PlayerSides, chosenObject: ChoiceOptions) {
//		Player cannot choose more than one object at a time
		if playerSide == .left {
			leftSideChoice = chosenObject.rawValue
			areLeftChoiceButtonsDisabledMultiplayer = true
		} else if playerSide == .right {
			rightSideChoice = chosenObject.rawValue
			areRightChoiceButtonsDisabledMultiplayer = true
		}
		
		DispatchQueue.main.asyncAfter(deadline: .now() + animationTimerDelay) {
			self.leftSideChoice = ""
			self.rightSideChoice = ""
		}
		
		battleboardAnimationsMultiplayer(playerSide: playerSide)
		
		if !leftSideChoice.isEmpty && !rightSideChoice.isEmpty {
			decideOutcomeMultiplayer(leftObj: leftSideChoice, rightObj: rightSideChoice)
		}
	}
	
	func decideOutcomeMultiplayer(leftObj: String, rightObj: String) {
		if leftObj == rightObj {
			finishedInAdrawMultiplayer()
		} else if leftObj == ChoiceOptions.Rock.rawValue {
			if rightObj == ChoiceOptions.Lizard.rawValue || rightObj == ChoiceOptions.Scissors.rawValue {
				leftSideWinsMultiplayer()
			} else {
				rightSideWinsMultiplayer()
			}
		} else if leftObj == ChoiceOptions.Paper.rawValue {
			if rightObj == ChoiceOptions.Rock.rawValue || rightObj == ChoiceOptions.Spock.rawValue {
				leftSideWinsMultiplayer()
			} else {
				rightSideWinsMultiplayer()
			}
		} else if leftObj == ChoiceOptions.Scissors.rawValue {
			if rightObj == ChoiceOptions.Paper.rawValue || rightObj == ChoiceOptions.Lizard.rawValue {
				leftSideWinsMultiplayer()
			} else {
				rightSideWinsMultiplayer()
			}
		} else if leftObj == ChoiceOptions.Lizard.rawValue {
			if rightObj == ChoiceOptions.Spock.rawValue || rightObj == ChoiceOptions.Paper.rawValue {
				leftSideWinsMultiplayer()
			} else {
				rightSideWinsMultiplayer()
			}
		} else if leftObj == ChoiceOptions.Spock.rawValue {
			if rightObj == ChoiceOptions.Scissors.rawValue || rightObj == ChoiceOptions.Rock.rawValue {
				leftSideWinsMultiplayer()
			} else {
				rightSideWinsMultiplayer()
			}
		}
	}
	
	func leftSideWinsMultiplayer() {
		leftSideScoreMultiplayer += 1
		animateRoundMultiplayer(outcome: .LeftSideWins)
	}
	
	func rightSideWinsMultiplayer() {
		rightSideScoreMultiplayer += 1
		animateRoundMultiplayer(outcome: .RightSideWins)
	}
	
	func finishedInAdrawMultiplayer() {
		animateRoundMultiplayer(outcome: .Draw)
	}
	
	func animateRoundMultiplayer(outcome: RoundOutcomes) {
		withAnimation(.easeOut(duration: 0.5)) {
			switch outcome {
			case .LeftSideWins:
				leftSideScoreMultiplayerBackground = .victoryBackround
				rightSideScoreMultiplayerBackground = .defeatBackground
			case .RightSideWins:
				leftSideScoreMultiplayerBackground = .defeatBackground
				rightSideScoreMultiplayerBackground = .victoryBackround
			case .Draw:
				leftSideScoreMultiplayerBackground = .drawBackground
				rightSideScoreMultiplayerBackground = .drawBackground
			default:
				leftSideScoreMultiplayerBackground = Color(red: 0.7, green: 0.7, blue: 0.7)
				rightSideScoreMultiplayerBackground = Color(red: 0.7, green: 0.7, blue: 0.7)
			}
		}

	}
	
	func battleboardAnimationsMultiplayer(playerSide: PlayerSides) {
		withAnimation(.easeOut(duration: 0.7)) {
			if playerSide == .left {
				leftObjectOffset = 0
			} else {
				rightObjectOffset = 0
			}

		}
		
		withAnimation(.easeIn(duration: 0.2)) {
			if playerSide == .left {
				leftChosenObjectScaleMultiplayer = CGSize(width: 0.85, height: 0.85)
			} else {
				rightChosenObjectScaleMultiplayer = CGSize(width: 0.85, height: 0.85)
			}
			self.buttonsShadow = 0
		}
		
		withAnimation(.easeIn(duration: 0.2).delay(animationTimerDelay)) {
			self.leftChosenObjectScaleMultiplayer = CGSize(width: 1, height: 1)
					self.rightChosenObjectScaleMultiplayer = CGSize(width: 1, height: 1)
					self.buttonsShadow = 4
		}
		
		DispatchQueue.main.asyncAfter(deadline: .now() + animationTimerDelay) {
			self.leftObjectOffset = -130
			self.rightObjectOffset = 130
			
			self.outcome = .NotStarted
			self.animateRoundMultiplayer(outcome: self.outcome)
			
		}
	}
	
}



