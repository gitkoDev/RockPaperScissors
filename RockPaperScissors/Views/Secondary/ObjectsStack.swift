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
				} label: {
// Change the buttons styling depending on where the toggle is on
					Image(viewsSettings.isToggleOn ? obj.rawValue : obj.rawValue + "Alt")
						.resizable()
				}
				.disabled(viewsSettings.areChoiceButtonsDisabled)
				.frame(width:
								gameMode == .againstPlayer ? 45 : 50)
				.frame(height: gameMode == .againstPlayer ? 45 : 50)
				.padding()
				.background(LinearGradient(colors: [.blue, .mint], startPoint: .top, endPoint: .bottom))
				.clipShape(Circle())
				.shadow(radius: 3)
			}
		}
		
				
			}
    }


struct ObjectsStack_Previews: PreviewProvider {
    static var previews: some View {
			ObjectsStack(viewsSettings: ViewsSettings(), gameMode: .constant(.againstPlayer))
    }
}
