//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Gitko Denis on 16.02.2023.
//

import SwiftUI
import WrappingStack

struct AgainstCPUView: View {
	@State var battleboardBG: Color = .white.opacity(0)
	
	@State var isToggleOn = false
	@State var areChoiceButtonsDisabled = false
	
	@State private var userScore = 0
	
	@State private var outcome: RoundOutcomes = .Draw
	
	@State private var usersChoice = ""
	@State private var computersChoice = ""
	
	@State var userObj = ChoiceOption.Rock
	@State var computerObj = ChoiceOption.Spock
	
	@State private var timeRemaining = 3
	let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
	@State private var timerIsRunning = false
	
	let timerDelay: Double = 1
	
    var body: some View {
			ZStack() {
				
// MARK: Toggle button

				ToggleButton(isToggleOn: $isToggleOn)
				
// MARK: Battleboard
					VStack(spacing: 40) {
						
						Spacer()
						Spacer()

//						roundOutcomeText
						
						HStack() {
							Image(usersChoice)
								.resizable()
								.frame(width: 60, height: 60)
							Spacer().frame(width: 100)
							Image(computersChoice)
								.resizable()
								.frame(width: 60, height: 60)
							
						}
						.frame(width: 350, height: 150)
						.background(.ultraThinMaterial.opacity(0.6))
						.background(battleboardBG)
						
//						.battleboardModifier(outcome: outcome)
						
						
						.clipShape(RoundedRectangle(cornerRadius: 10))
						
						Spacer().frame(height: 30)
						
//	MARK: User choice buttons
												
						WrappingHStack(id: \.self, alignment: .center, horizontalSpacing: 30, verticalSpacing: 15) {
							ForEach(ChoiceOption.allCases, id: \.self) { obj in
								Button {
									chooseAnObject(userObj: obj, computerObj: ChoiceOption.allCases.randomElement()!)
								} label: {
									Image(obj.rawValue)
										.resizable()
								}
								.disabled(areChoiceButtonsDisabled)
								.frame(width: 50, height: 50)
								.padding()

								.background(.blue)

								.clipShape(Circle())
							}
						}
						
// MARK: User score
						Text("score: \(userScore)")
							.font(.title2.weight(.medium))
							.foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
						
						Spacer()
						Spacer()
						
					}
				
			}
			.background(Color.background)
			.ignoresSafeArea()
			

    }
	
	
//	MARK: Properties and methods
	
	func chooseAnObject(userObj: ChoiceOption, computerObj: ChoiceOption) {
		print("user chose \(userObj)")
		usersChoice = userObj.rawValue
		computersChoice = computerObj.rawValue
		
		DispatchQueue.main.asyncAfter(deadline: .now() + timerDelay) {
			areChoiceButtonsDisabled = false
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
			computersChoice = ""
			usersChoice = ""
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
	
	
	func startCountdown() -> Void {
		timeRemaining = 3
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
			timerIsRunning = true
		}
	}

	func battleboardAnimation(outcome: RoundOutcomes) {
		withAnimation(.easeIn(duration: 0.4)) {
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
		}
	}
	
	func animateRound() {
		battleboardAnimation(outcome: outcome)
		
		DispatchQueue.main.asyncAfter(deadline: .now() + timerDelay) {
			outcome = .NotStarted
			battleboardAnimation(outcome: outcome)
		}
	}
	
	}

struct BattleboardModifier: ViewModifier {
	var outcome: RoundOutcomes
	
	func body(content: Content) -> some View {

		switch outcome {
		case .Draw:
			withAnimation(.easeIn(duration: 2)) {
				content
					.background(.white)
			}
		case .LeftSideWins:
			withAnimation(.easeIn(duration: 2)) {
				content
				.background(.green)
			}
		case .RightSideWins:
			withAnimation(.easeIn(duration: 2)) {
				content
				.background(.red)
			}
		default:
			withAnimation(.easeIn(duration: 2)) {
				content
				.background(.blue)
			}
		}
	}
}

struct Countdown: ViewModifier {
	func body(content: Content) -> some View {
		content
			.frame(width: 110, height: 110)
			.background(.ultraThinMaterial)
			.clipShape(Circle())
			.font(.system(size: 50, weight: .bold))
			.opacity(0.7)
			.foregroundColor(.purple)
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
			AgainstCPUView()
    }
}

