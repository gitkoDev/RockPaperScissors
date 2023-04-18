//
//  ObjectsStack.swift
//  RockPaperScissors
//
//  Created by Gitko Denis on 20.03.2023.
//

import SwiftUI
import WrappingStack

struct ObjectsStack: View {
	@ObservedObject var viewsSettings: ViewsSettings
	@Binding var gameMode: ViewsSettings.GameModes
	
	var playerSide: Binding<ViewsSettings.PlayerSides>?
	
	var body: some View {
		if gameMode == .againstCPU {
			WrappingHStack(
				id: \.self, alignment: .center,
				horizontalSpacing: 30, verticalSpacing: 15) {
				ForEach(ChoiceOptions.allCases, id: \.self) { obj in
					Button {
							viewsSettings.chooseAnObjectAgainstCPUMode(leftObj: obj, rightObj: ChoiceOptions.allCases.randomElement()!)
					} label: {
	// Change the buttons styling depending on whether the toggle is on
						Image(viewsSettings.isToggleOn ? obj.rawValue + "Alt" : obj.rawValue)
							.resizable()
					}
					.disabled(viewsSettings.areChoiceButtonsDisabled)
					.frame(width: 45, height: 45)
					.padding()
					.background(
						Circle()
							.fill(viewsSettings.areChoiceButtonsDisabled ? Color("Background2") : Color("Background1"))
					)
					.frame(width: 83, height: 83)
					.background(
						Circle().fill(.white)
					)

	//				Animate the button that was tapped just now (e.g. if it's the choice of the player, then it's the button that was tapped and it needs to be animated
					
					.shadow(radius: obj.rawValue == viewsSettings.leftSideChoice ? viewsSettings.buttonsShadow : 4)
					.scaleEffect(obj.rawValue == viewsSettings.leftSideChoice ? viewsSettings.chosenObjectScale : CGSize(width: 1, height: 1))
				}
					
			}
		} else {
			WrappingHStack(
				id: \.self, alignment: .center,
				horizontalSpacing: 10, verticalSpacing: 15) {
				ForEach(ChoiceOptions.allCases, id: \.self) { obj in
					Button {
						viewsSettings.chooseObjectsAgainstPlayerMode(playerSide: playerSide!.wrappedValue, chosenObject: obj)
						print(playerSide!.wrappedValue)
					} label: {
	// Change the buttons styling depending on whether the toggle is on
						Image(viewsSettings.isToggleOn ? obj.rawValue + "Alt" : obj.rawValue)
							.resizable()
					}
					.disabled(viewsSettings.areChoiceButtonsDisabled)
					.frame(width: 40, height: 40)
					.padding()
					.background(
						Circle()
							.fill(viewsSettings.areChoiceButtonsDisabled ? Color("Background2") : Color("Background1"))
					)
					.frame(width: 78, height: 78)
					.background(
						Circle().fill(.white)
					)

	//				Animate the button that was tapped just now (e.g. if it's the choice of the player, then it's the button that was tapped and it needs to be animated
					
//					Left side animation
					.shadow(radius: playerSide!.wrappedValue == .left && obj.rawValue == viewsSettings.leftSideChoice ? viewsSettings.buttonsShadow : 4)
					.scaleEffect(playerSide!.wrappedValue == .left && obj.rawValue == viewsSettings.leftSideChoice ? viewsSettings.chosenObjectScale : CGSize(width: 1, height: 1))
					
//					Right side animation
					.shadow(radius: playerSide!.wrappedValue == .right && obj.rawValue == viewsSettings.rightSideChoice ? viewsSettings.buttonsShadow : 4)
					.scaleEffect(playerSide!.wrappedValue == .right && obj.rawValue == viewsSettings.rightSideChoice ? viewsSettings.chosenObjectScale : CGSize(width: 1, height: 1))
				}
					
			}
		}
		

			}
    }


struct ObjectsStack_Previews: PreviewProvider {
    static var previews: some View {
			ObjectsStack(viewsSettings: ViewsSettings(), gameMode: .constant(.againstPlayer))
    }
}
