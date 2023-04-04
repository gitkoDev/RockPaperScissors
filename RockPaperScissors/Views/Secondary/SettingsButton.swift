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
				.font(.title3)
				.foregroundColor(.gray)
				.frame(width: 34, height: 34)
				.background(
					Circle().fill(Color.drawBackground)
				)
				.frame(width: 42, height: 42)
				.background(
					Circle().fill(Color.accentPrimary)
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
