//
//  ObjectsStack.swift
//  RockPaperScissors
//
//  Created by Gitko Denis on 20.03.2023.
//

import SwiftUI
import WrappingStack

struct ObjectsStack: View {
	 var viewModel = ViewModel()
	var chooseAnObject: () -> Void
	
	var body: some View {
		Text("Gi")
			WrappingHStack(id: \.self, alignment: .center, horizontalSpacing: 30, verticalSpacing: 15) {
				ForEach(ChoiceOption.allCases, id: \.self) { obj in
					Button {
						chooseAnObject()
//						chooseAnObject(userObj: obj, computerObj: ChoiceOption.allCases.randomElement()!)
					} label: {
						Image(obj.rawValue)
							.resizable()
					}
					.disabled(viewModel.areChoiceButtonsDisabled)
					.frame(width: 50, height: 50)
					.padding()
					.background(LinearGradient(colors: [.blue, .mint], startPoint: .top, endPoint: .bottom))
					.clipShape(Circle())
					.shadow(radius: 3)
				}
			}
    }
}

//struct ObjectsStack_Previews: PreviewProvider {
//    static var previews: some View {
//        ObjectsStack()
//    }
//}
