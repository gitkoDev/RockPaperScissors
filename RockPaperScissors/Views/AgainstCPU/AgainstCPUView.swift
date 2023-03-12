//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Gitko Denis on 16.02.2023.
//

import SwiftUI
import WrappingStack

struct AgainstCPUView: View {
	@State private var battleboardBG: Color = .white.opacity(0)
	@State private var leftObjectOffset: CGFloat = -120
	@State private var rightObjectOffset: CGFloat = 120
	@State private var isLeftSideWinner = false
	@State private var isRightSideWinner = false
	
	@State var isToggleOn = false
	@State private var areChoiceButtonsDisabled = false
	
	@State private var userScore = 0
	
	@State private var outcome: RoundOutcomes = .Draw
	
	@State private var usersChoice = ""
	@State private var computersChoice = ""
	
	@State var userObj = ChoiceOption.Rock
	@State var computerObj = ChoiceOption.Spock
	
	let timerDelay: Double = 2
	
    var body: some View {
			ZStack() {
				Color.background
				
// MARK: Toggle button
				

// MARK: Dismiss view button
				VStack(spacing: 20) {
					
					Spacer().frame(height: 35)
					HStack {
						ToggleButton(isToggleOn: $isToggleOn)
						Spacer()
						DismissButton()
					}
					.padding(30)
		// MARK: Battleboard
					
					Spacer().frame(height: 15)
					
					HStack() {
						Image(usersChoice)
							.resizable()
							.frame(width: 60, height: 60)
							.offset(x: leftObjectOffset)
							.scaleEffect(isLeftSideWinner ? 1.5 : 1)
						Spacer().frame(width: 100)
						Image(computersChoice)
							.resizable()
							.frame(width: 60, height: 60)
							.offset(x: rightObjectOffset)
							.scaleEffect(isRightSideWinner ? 1.5 : 1)
					}
					
					.frame(width: 350, height: 200)
					.background(.ultraThinMaterial.opacity(0.8))
					.background(battleboardBG)
					.clipShape(RoundedRectangle(cornerRadius: 10))
					.shadow(radius: 2)
					
					Spacer().frame(height: 20)
					
					// MARK: User score
					Text("score: \(userScore)")
						.font(.custom("JosefinSansRoman-Light", size: 50))
						.foregroundColor(Color(red: 0.25, green: 0.25, blue: 0.25))
					
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
							.background(LinearGradient(colors: [.blue, .mint], startPoint: .top, endPoint: .bottom))
							.clipShape(Circle())
							.shadow(radius: 3)
						}
					}
					
					Spacer()
				}
				
			}
			.ignoresSafeArea()
    }
	
	init() {
		for fontFamily in UIFont.familyNames {
			print(fontFamily)
			for fontName in UIFont.fontNames(forFamilyName: fontFamily) {
				print("-- \(fontName)")
			}
		}
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
		isLeftSideWinner = true
		animateRound()
	}
	
	func computerWins() {
		outcome = .RightSideWins
		userScore -= 1
		isRightSideWinner = true
		animateRound()
	}
	
	func finishedInADraw() {
		outcome = .Draw
		animateRound()
	}
	
	func battleboardAnimation(outcome: RoundOutcomes) {
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
	
	func animateRound() {
		battleboardAnimation(outcome: outcome)

		DispatchQueue.main.asyncAfter(deadline: .now() + timerDelay) {
			outcome = .NotStarted
			
			battleboardAnimation(outcome: outcome)
			
			leftObjectOffset = -130
			rightObjectOffset = 130
			
			isLeftSideWinner = false
			isRightSideWinner = false
		}
	}
	
	}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
			AgainstCPUView()
    }
}

