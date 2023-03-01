//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Gitko Denis on 16.02.2023.
//

import SwiftUI
import WrappingStack

struct AgainstCPUView: View {
	@State var isToggleOn = false
	
	@State private var userScore = 0
	
	@State private var userChoseSomething = false
	@State private var userWon = false
	@State private var isFinishedInADraw = false
	
	@State private var usersChoice = ""
	@State private var computersChoice = ""
	
	@State private var timeRemaining = 3
	let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
	@State private var timerIsRunning = false
	
	let timerDelay: Double = 1
	
	enum ChoiceOption: String, CaseIterable {
		case rock = "rock"
		case paper = "paper"
		case scissors = "scissors"
		case lizard = "lizard"
		case spock = "spock"
	}

	
    var body: some View {
			ZStack() {
				Color.background

				ToggleButton(isToggleOn: $isToggleOn)
				
// MARK: Battle board
					VStack(spacing: 40) {
						
						Spacer()
						Spacer()

						roundOutcomeText
						
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
						.background(.ultraThinMaterial)
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
								.frame(width: 50, height: 50)
								.padding()
								.background(.linearGradient(colors: [.blue, .mint], startPoint: .bottom, endPoint: .top))
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
			.ignoresSafeArea()
			

    }
	
	
	
	@ViewBuilder var roundOutcomeText: some View {
		if userChoseSomething && userWon {
							Text("You win")
						} else if userChoseSomething && !userWon {
							Text("You lose!")
						} else if isFinishedInADraw {
							Text("It's a draw")
						} else {
							Text("No text")
								.opacity(0)
						}
	}
	
	func chooseAnObject(userObj: ChoiceOption, computerObj: ChoiceOption) {
		print("user chose \(userObj)")
		usersChoice = userObj.rawValue
		computersChoice = computerObj.rawValue
		
		switch (userObj, computerObj) {
		case (ChoiceOption.scissors, ChoiceOption.paper):
			userWins()
		case (ChoiceOption.scissors, ChoiceOption.rock):
			computerWins()
		case (ChoiceOption.scissors, ChoiceOption.lizard):
			userWins()
		case (ChoiceOption.scissors, ChoiceOption.spock):
			computerWins()
			
		case (ChoiceOption.paper, ChoiceOption.rock):
			userWins()
		case (ChoiceOption.paper, ChoiceOption.lizard):
			computerWins()
		case (ChoiceOption.paper, ChoiceOption.spock):
			userWins()
		case (ChoiceOption.paper, ChoiceOption.scissors):
			computerWins()
			
		case (ChoiceOption.rock, ChoiceOption.paper):
			computerWins()
		case (ChoiceOption.rock, ChoiceOption.lizard):
			userWins()
		case (ChoiceOption.rock, ChoiceOption.spock):
			computerWins()
		case (ChoiceOption.rock, ChoiceOption.scissors):
			userWins()
			
		case (ChoiceOption.lizard, ChoiceOption.paper):
			userWins()
		case (ChoiceOption.lizard, ChoiceOption.rock):
			computerWins()
		case (ChoiceOption.lizard, ChoiceOption.spock):
			userWins()
		case (ChoiceOption.lizard, ChoiceOption.scissors):
			computerWins()
			
		case (ChoiceOption.spock, ChoiceOption.rock):
			userWins()
		case (ChoiceOption.spock, ChoiceOption.lizard):
			computerWins()
		case (ChoiceOption.spock, ChoiceOption.scissors):
			userWins()
		case (ChoiceOption.spock, ChoiceOption.paper):
			computerWins()
			
		default:
			finishedInADraw()
		}
		
		DispatchQueue.main.asyncAfter(deadline: .now() + timerDelay) {
			computersChoice = ""
			usersChoice = ""
		}
		
	}
	
	func userWins() {
		userChoseSomething = true
		userWon = true
		
		print("you win")
		
		userScore += 1
		
		DispatchQueue.main.asyncAfter(deadline: .now() + timerDelay) {
			userChoseSomething = false
//			userWon = false
		}
	}
	
	func computerWins() {
		userChoseSomething = true
		userWon = false
		
		print("you lose")
		
		userScore -= 1
		
		DispatchQueue.main.asyncAfter(deadline: .now() + timerDelay) {
			userChoseSomething = false
		}
	}
	
	func finishedInADraw() {
		userChoseSomething = true
		isFinishedInADraw = true
		
		print("they are the same")
		
		DispatchQueue.main.asyncAfter(deadline: .now() + timerDelay) {
			isFinishedInADraw = false
			userChoseSomething = false
		}
		
	}
	
	
	func startCountdown() -> Void {
		timeRemaining = 3
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
			timerIsRunning = true
		}
	}
	}
	


struct OutcomeTitle: ViewModifier {
	func body(content: Content) -> some View {
		content
		.font(.largeTitle.weight(.black))
		.frame(minHeight: 20)
		.foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
		.transition(.opacity)
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

extension View {
	func outcomeTitleStyle() -> some View {
		modifier(OutcomeTitle())
	}
	func countdownModifier() -> some View {
		modifier(Countdown())
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
			AgainstCPUView()
    }
}

