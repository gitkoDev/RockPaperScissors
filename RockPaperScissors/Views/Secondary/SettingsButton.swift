//
//  SettingsButton.swift
//  RockPaperScissors
//
//  Created by Gitko Denis on 28.03.2023.
//

import SwiftUI

struct SettingsButton: View {
	@State private var showSettings = false
	var body: some View {
		Button {
			showSettings.toggle()
		} label: {
			Image(systemName: "gearshape.fill")
				.font(.title2)
				.foregroundColor(.white)
				.frame(width: 40, height: 40)
				.background(
					Circle().fill(Color.buttonsBackground)
						.shadow(radius: 4)
				)
		}
		.fullScreenCover(isPresented: $showSettings) {
			SettingsView()
		}
		
	}
	
	struct SettingsButton_Previews: PreviewProvider {
		static var previews: some View {
			SettingsButton()
		}
	}
}
