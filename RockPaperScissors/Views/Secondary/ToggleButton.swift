//
//  ToggleButton.swift
//  RockPaperScissors
//
//  Created by Gitko Denis on 28.02.2023.
//

import SwiftUI

struct ToggleButton: View {
	@ObservedObject var viewsSettings: ViewsSettings
	
	var body: some View {
			ZStack {
				Capsule()
					.fill(Color.toggleButtonsBackground)
					.frame(width: 100, height: 45)
					.shadow(radius: 3)

				HStack {
					if viewsSettings.isToggleOn {
						Spacer()
						Image("scissors")
							.resizable()
							.frame(width: 30, height: 30)
					}
					
					ZStack {
						Capsule().fill(LinearGradient(colors: [.blue, .mint], startPoint: .top, endPoint: .bottom))
							.frame(width: 50, height: 50)
						Image(systemName: "switch.2")
							.foregroundColor(.white)
					}
					
					if !viewsSettings.isToggleOn {
						Spacer()
						Image("scissorsAlt")
							.resizable()
							.frame(width: 30, height: 30)
						Spacer()
					}

				}
				.animation(.default, value: viewsSettings.isToggleOn)
				.frame(width: 100, height: 50)
				.onTapGesture {
					viewsSettings.isToggleOn.toggle()
					print(viewsSettings.isToggleOn)
				}
			}
    }
}

struct ToggleButton_Previews: PreviewProvider {
    static var previews: some View {
			ToggleButton(viewsSettings: ViewsSettings())
    }
}
