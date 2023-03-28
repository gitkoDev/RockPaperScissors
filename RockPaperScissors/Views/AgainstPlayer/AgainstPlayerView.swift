//
//  AgainstPlayerView.swift
//  RockPaperScissors
//
//  Created by Gitko Denis on 27.02.2023.
//

import SwiftUI
import WrappingStack

struct AgainstPlayerView: View {
	@StateObject var viewsSettings = ViewsSettings()
	@State private var gameMode: ViewsSettings.GameModes = .againstPlayer

    var body: some View {
			ZStack {
				BackgroundColor(viewsSettings: viewsSettings)

				VStack(spacing: 0) {

					HStack {
						DismissButton()
						
						Spacer()
					}
					.padding(.horizontal, 50)
					.padding(.top, 20)
					
					Spacer()
					
					HStack {
						ObjectsStack(viewsSettings: viewsSettings, gameMode: $gameMode)
						
						Battleboard(viewsSettings: ViewsSettings(), gameMode: $gameMode)
						
						ObjectsStack(viewsSettings: viewsSettings, gameMode: $gameMode)
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
