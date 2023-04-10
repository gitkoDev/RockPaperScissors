//
//  SettingsView.swift
//  RockPaperScissors
//
//  Created by Gitko Denis on 29.03.2023.
//

import SwiftUI

struct SettingsView: View {
	@AppStorage("isToggleOn") private var isToggleOn: Bool = false
	@ObservedObject var viewsSettings = ViewsSettings()
	@Environment(\.dismiss) var dismiss
	
	private let topPadding: CGFloat = 80
	private let bottomPadding: CGFloat = 70
	private let horizontalPadding: CGFloat = 15
	private let textHorizontalPadding: CGFloat = 30
	
	var body: some View {
		ZStack {
			BackgroundColor(viewsSettings: viewsSettings)
			
//			MARK: Inner white rectangle
			RoundedRectangle(cornerRadius: 10)
				.fill(.white)
				.padding(.top, topPadding)
				.padding(.bottom, bottomPadding)
				.padding(.horizontal, horizontalPadding)
//			 MARK: Outer thin rim
				.background(
					RoundedRectangle(cornerRadius: 10)
						.fill(Color.accentPrimary).opacity(0.5)
						.padding(.top, topPadding - 5)
						.padding(.bottom, bottomPadding - 5)
						.padding(.horizontal, horizontalPadding - 5)
				)
			
				VStack(spacing: 17) {
						Text("Settings")
						.padding(.top, topPadding + 30)
							.modifier(settingsTitleModifier())
					
					Image("spock")
								 .resizable()
								 .frame(idealWidth: 140, maxWidth: 140, idealHeight: 140, maxHeight: 140)

					Spacer()
					
//					MARK: Top buttons
					
					Button {
						print("rules opened")
					} label: {
						HStack {
							Text("How to play")
								.modifier(settingsButtonsLightModifier())
							Spacer()
							Image(systemName: "arrow.right.circle.fill")
								.foregroundColor(.blue)
								.font(.title2)
							
						}
						.padding(.horizontal, textHorizontalPadding)
					}

					HStack {
						Text("Alternative mode")
							.modifier(settingsButtonsLightModifier())
						Spacer()
						ToggleButton(viewsSettings: viewsSettings)
					}
					.padding(.horizontal, textHorizontalPadding)
					
					Spacer()
					
//					MARK: Referral buttons
						
						HStack {
							Button("Rate the App") {
								print("Rated")
							}
							.modifier(settingsButtonsDarkModifier())
							Spacer()
						}
						.padding(.leading, textHorizontalPadding + 5)
						
						HStack {
							Button("Share with friends") {
								print("shared")
							}
							.modifier(settingsButtonsDarkModifier())
							Spacer()
						}
						.padding(.leading, textHorizontalPadding + 5)
						
						HStack {
							Button("Report a problem") {
								print("Reported")
							}
							.modifier(settingsButtonsDarkModifier())
							Spacer()
						}
						.padding(.leading, textHorizontalPadding + 5)
					
//					MARK: Dismiss button
					
					DismissButtonLarge()
						
					}
				.padding(.bottom, bottomPadding - 18)
				
		}
		.ignoresSafeArea()

    }
}



struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
