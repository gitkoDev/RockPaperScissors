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
	
	var body: some View {
		WrappingHStack(
			id: \.self, alignment: .center,
			horizontalSpacing: gameMode == .againstPlayer ? 15 : 30, verticalSpacing: 15) {
			ForEach(ChoiceOptions.allCases, id: \.self) { obj in
				Button {
					viewsSettings.chooseAnObject(userObj: obj, computerObj: ChoiceOptions.allCases.randomElement()!)
					print(obj)
				} label: {
// Change the buttons styling depending on where the toggle is on
					Image(viewsSettings.isToggleOn ? obj.rawValue + "Alt" : obj.rawValue)
						.resizable()
				}
				.disabled(viewsSettings.areChoiceButtonsDisabled)
				.frame(width:
								gameMode == .againstPlayer ? 40 : 45)
				.frame(height: gameMode == .againstPlayer ? 40 : 45)
				.padding()
				.background(
					Circle()
						.fill(viewsSettings.areChoiceButtonsDisabled ? Color("Background2") : Color("Background1"))
				)
				.frame(width: gameMode == .againstCPU ? 83 : 78)
				.frame(height: gameMode == .againstCPU ? 83 : 78)
				.background(
					Circle().fill(.white)
				)
				.shadow(radius: 5)
				.scaleEffect(obj.rawValue == viewsSettings.leftSideChoice ? viewsSettings.chosenObjectScale : CGSize(width: 1, height: 1))
			}
				
		}
		
				
			}
    }


struct ObjectsStack_Previews: PreviewProvider {
    static var previews: some View {
			ObjectsStack(viewsSettings: ViewsSettings(), gameMode: .constant(.againstPlayer))
    }
}
