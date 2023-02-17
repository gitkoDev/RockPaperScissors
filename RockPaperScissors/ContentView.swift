//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Gitko Denis on 16.02.2023.
//

import SwiftUI

struct ContentView: View {
	@State private var userScore = 0
	
	@State private var userChoseSomething = false
	@State private var userWon = false
	@State private var isFinishedInADraw = false
	
	@State private var usersChoice = ""
	@State private var computersChoice = ""
	
	let imagesNames = ["rock", "paper", "scissors"]
	
	let timerDelay: Double = 2

	
    var body: some View {
			ZStack {
				LinearGradient(colors: [Color(red: 0.7, green: 0.04, blue: 0.3), Color(red: 1, green: 0.98, blue: 0.84)], startPoint: .top, endPoint: .bottom)
				
					VStack(spacing: 60) {
						
						VStack (spacing: 20) {
							//					Change the text to an empty string after the choice was made
//							Text(userChoseSomething ? "" : "Make your choice")
//										.font(.title.weight(.semibold))
//										.foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))

				//					Let the text appear after the round is finished to tell the player who won
									

							if userChoseSomething && isFinishedInADraw {
								Text("It's a draw")
									.outcomeTitleStyle()
							} else if userChoseSomething && userWon {
								Text("You won")
									.outcomeTitleStyle()
							} else if userChoseSomething && !userWon {
								Text("You lost")
									.outcomeTitleStyle()
							} else {
								Text("Make your choice")
									.opacity(0)
									.outcomeTitleStyle()
							}


						}

						Image(computersChoice)
							.resizable()
							.frame(width: 80, height: 80)
							
							.animation(.easeInOut(duration: timerDelay))
						
							.padding()
							.background(.regularMaterial)
							.clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
						
						
	//					Create a frame to store the picture of the computer's choice
						
						HStack (spacing: 30){
							ForEach(imagesNames, id: \.self) { obj in
								
								Button {
									chooseAnObject(userObj: obj, computerObj: imagesNames.randomElement()!)

								} label: {
									Image(obj)
										.resizable()
								}


								
								.frame(width: 50, height: 50)
								.padding()
								.background(.ultraThinMaterial)
								.clipShape(Circle())
				
								
							}
						}
						
						Text("score: \(userScore)")
							.font(.title2.weight(.medium))
							.foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
						
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

extension View {
	func outcomeTitleStyle() -> some View {
		modifier(OutcomeTitle())
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

