//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Gitko Denis on 16.02.2023.
//

import SwiftUI
import WrappingStack

struct ContentView: View {
	@State private var userScore = 0
	
	@State private var userChoseSomething = false
	@State private var userWon = false
	@State private var isFinishedInADraw = false
	
	@State private var usersChoice = ""
	@State private var computersChoice = ""
	
	@State private var timeRemaining = 3
	let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
	@State private var timerIsRunning = false
	
	let imagesNames = ["rock", "paper", "scissors", "lizard", "spock"]
	
	let timerDelay: Double = 1

	
    var body: some View {
			ZStack {
				LinearGradient(colors: [Color(red: 0.7, green: 0.04, blue: 0.3), Color(red: 1, green: 0.98, blue: 0.84)], startPoint: .top, endPoint: .bottom)
				
					VStack(spacing: 40) {
											
						Group {
							Spacer()
							Spacer()
						}

						Button {
							startCountdown()
						} label: {
							Text(timeRemaining > 0 ? String(timeRemaining) : "GO!")
								.onChange(of: timeRemaining) { _ in
//										Apply changes to the text view during every second of the countdown

								}
								.onReceive(timer) { _ in

									if timerIsRunning && timeRemaining >= 0 {
										timeRemaining -= 1
									} else {
										timerIsRunning = false
									}
								}
								.countdownModifier()
						}
						
						
						if timeRemaining > 0 && userChoseSomething {
							Text("too early")
								.opacity(1)
								.animation(.easeInOut(duration: 1))
								.outcomeTitleStyle()
						} else if timeRemaining == 0 && userChoseSomething {
							Text("Choice made")
								.outcomeTitleStyle()
						} else {
							Text("stopped")
								.outcomeTitleStyle()
						}
						
						Image(computersChoice)
							.resizable()
							.frame(width: 80, height: 80)
							
							.animation(.easeInOut(duration: 0.5))
						
							.padding()
							.background(.regularMaterial)
							.clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
						
						
	//					Create a frame to store the picture of the computer's choice
						
						WrappingHStack(id: \.self, alignment: .center, horizontalSpacing: 30, verticalSpacing: 15) {
							ForEach(imagesNames, id: \.self) { obj in
								Button {
									chooseAnObject(userObj: obj, computerObj: imagesNames.randomElement()!)
								} label: {
									Image(obj)
										.resizable()
								}
								.frame(width: 50, height: 50)
								.padding()
								.background(.linearGradient(colors: [.blue, .mint], startPoint: .bottom, endPoint: .top))
								.clipShape(Circle())
							}
						
						
						}
						
						
						Text("score: \(userScore)")
							.font(.title2.weight(.medium))
							.foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
						
						Spacer()
						
					}
				
			}
			.ignoresSafeArea()

    }
	
	func chooseAnObject(userObj: String, computerObj: String) {
		computersChoice = computerObj
		
		if userObj == computerObj {
			finishedInADraw()
		} else if userObj == "rock" {
			if computerObj == "paper" {
				computerWins()
			} else {
				userWins()
			}
		} else if userObj == "paper" {
			if computerObj == "rock" {
				userWins()
			} else {
				computerWins()
			}
		} else if userObj == "scissors" {
			if computerObj == "rock" {
				computerWins()
			} else {
				userWins()
			}
		}
		
		DispatchQueue.main.asyncAfter(deadline: .now() + timerDelay) {
			computersChoice = ""
		}
		
	}
	
	func userWins() {
		userChoseSomething = true
		userWon = true
		
		print("you win")
		
		userScore += 1
		
		DispatchQueue.main.asyncAfter(deadline: .now() + timerDelay) {
			userChoseSomething = false
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
		
		print(userScore)
		
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
        ContentView()
    }
}

