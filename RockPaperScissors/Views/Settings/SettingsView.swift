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
	
	var body: some View {
		ZStack {
			BackgroundColor(viewsSettings: viewsSettings)
			RoundedRectangle(cornerRadius: 10)
				.fill(.white)
				.padding(.top, topPadding)
				.padding(.bottom, bottomPadding)
				.padding(.horizontal, horizontalPadding)
				.background(
					RoundedRectangle(cornerRadius: 10)
						.fill(.black).opacity(0.1)
						.padding(.top, topPadding - 5)
						.padding(.bottom, bottomPadding - 5)
						.padding(.horizontal, horizontalPadding - 5)
				)
			
//			Button("Hi") {
//				print("clicked")
//			}.frame(maxHeight: .infinity, alignment: .bottom)
//				.offset(y: -100)
			Group {
									Spacer()
			
									Button {
										self.dismiss()
										print("done")
									} label: {
										Image(systemName: "xmark")
											.foregroundColor(.drawBackground)
											.font(.largeTitle)
											.background(
												RoundedRectangle(cornerRadius: 10)
													.fill(										viewsSettings.isToggleOn ?
																Color.dismissButtonsBackgroundAlt
																	: Color.dismissButtonsBackground)
													.frame(width: 65, height: 65)
													.shadow(radius: 3)
											)
											.frame(maxHeight: .infinity, alignment: .bottom)
											.offset(y: -50)
								}
				}
		}
		.ignoresSafeArea()
//
//
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
