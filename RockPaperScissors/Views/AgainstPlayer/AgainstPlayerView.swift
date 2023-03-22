//
//  AgainstPlayerView.swift
//  RockPaperScissors
//
//  Created by Gitko Denis on 27.02.2023.
//

import SwiftUI
import WrappingStack

struct AgainstPlayerView: View {
	@State private var leftSideChoice = ViewsSettings().leftSideChoice
	@State private var rightSideChoice = ViewsSettings().rightSideChoice

    var body: some View {
			ZStack {
				BackgroundColor()

				VStack(spacing: 20) {

					HStack {
						ToggleButton()
						Spacer()
						DismissButton()
					}
					.padding(.horizontal, 40)
					.padding(.vertical, 10)
					
					Spacer()
					
					HStack {
						WrappingHStack(id: \.self, alignment: .center, horizontalSpacing: 30, verticalSpacing: 15) {
							ForEach(ChoiceOption.allCases, id: \.self) { obj in
								Button {
//									chooseAnObject(userObj: obj, computerObj: ChoiceOption.allCases.randomElement()!)
//									isAnimated.toggle()
								} label: {
									Image(obj.rawValue)
										.resizable()
								}
	//							.disabled(areChoiceButtonsDisabled)
								.frame(width: 40, height: 40)
								.padding()
								.background(LinearGradient(colors: [.blue, .mint], startPoint: .top, endPoint: .bottom))
								.clipShape(Circle())
								.shadow(radius: 3)
							}
						}
						
						
						Battleboard(viewsSettings: ViewsSettings())
						
						WrappingHStack(id: \.self, alignment: .center, horizontalSpacing: 30, verticalSpacing: 15) {
							ForEach(ChoiceOption.allCases, id: \.self) { obj in
								Button {
	//								chooseAnObject(userObj: obj, computerObj: ChoiceOption.allCases.randomElement()!)
	//								isAnimated.toggle()
								} label: {
									Image(obj.rawValue)
										.resizable()
								}
	//							.disabled(areChoiceButtonsDisabled)
								.frame(width: 40, height: 40)
								.padding()
								.background(LinearGradient(colors: [.blue, .mint], startPoint: .top, endPoint: .bottom))
								.clipShape(Circle())
								.shadow(radius: 3)
							}
						}
					}
					.padding(.horizontal, 50)

				Spacer()
					
				}
				

				

				
				
			}
			.ignoresSafeArea()
    }
	
	//	MARK: Properties and methods
		
//		func chooseAnObject(userObj: ChoiceOption, computerObj: ChoiceOption) {
//			print("user chose \(userObj)")
//			usersChoice = userObj.rawValue
//			computersChoice = computerObj.rawValue
//			
//			DispatchQueue.main.asyncAfter(deadline: .now() + timerDelay) {
//				areChoiceButtonsDisabled = false
//			}
//			areChoiceButtonsDisabled = true
//			
//			if userObj == computerObj {
//				finishedInADraw()
//			} else if userObj == .Rock {
//				if computerObj == .Lizard || computerObj == .Scissors {
//					userWins()
//				} else {
//					computerWins()
//				}
//			} else if userObj == .Paper {
//				if computerObj == .Paper || computerObj == .Spock {
//					userWins()
//				} else {
//					computerWins()
//				}
//			} else if userObj == .Scissors {
//				if computerObj == .Paper || computerObj == .Lizard {
//					userWins()
//				} else {
//					computerWins()
//				}
//			} else if userObj == .Lizard {
//				if computerObj == .Spock || computerObj == .Paper {
//					userWins()
//				} else {
//					computerWins()
//				}
//			} else if userObj == .Spock {
//				if computerObj == .Scissors || computerObj == .Rock {
//					userWins()
//				} else {
//					computerWins()
//				}
//			}
//			
//			
//			DispatchQueue.main.asyncAfter(deadline: .now() + timerDelay) {
//				computersChoice = ""
//				usersChoice = ""
//			}
//		}
	
}

struct AgainstPlayerView_Previews: PreviewProvider {
    static var previews: some View {
			AgainstPlayerView()
    }
}
