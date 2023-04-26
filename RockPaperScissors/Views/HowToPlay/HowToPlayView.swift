//
//  HowToPlayView.swift
//  RockPaperScissors
//
//  Created by Gitko Denis on 04.04.2023.
//

import SwiftUI

struct HowToPlayView: View {
	@ObservedObject var viewsSettings = ViewsSettings()
	
	private let topPadding: CGFloat = 80
	private let bottomPadding: CGFloat = 70
	private let horizontalPadding: CGFloat = 15
	private let textHorizontalPadding: CGFloat = 30
	
    var body: some View {
			ZStack {
				BackgroundColor(viewsSettings: viewsSettings)
				
//				MARK: Inner white rectangle
				RoundedRectangle(cornerRadius: 10)
					.fill(.white)
					.padding(.top, topPadding)
					.padding(.bottom, bottomPadding)
					.padding(.horizontal, horizontalPadding)
					.background(
						RoundedRectangle(cornerRadius: 10)
							.fill(Color.accentPrimary).opacity(0.5)
							.padding(.top, topPadding - 5)
							.padding(.bottom, bottomPadding - 5)
							.padding(.horizontal, horizontalPadding - 5)
					)
				
				VStack {
					
					ScrollView(showsIndicators: false) {
						Group {
							Image("crossedOutRPS")
								.resizable()
								.scaledToFit()
								.frame(width: 200)
							Text("This is not the rock, paper, scissors game that everybody knows. Instead, you will be given 2 more objects to choose from, which means twice the fun!")
								.multilineTextAlignment(.center)
								.modifier(settingsButtonsLightModifier())
								.lineSpacing(6)
						}
						.padding(.bottom)
						
						Group {
							Image("allObjects")
								.resizable()
								.scaledToFit()
								.padding(.horizontal, 15)
							Text("Play alone or with friends in order to resolve your disputes and enjoy a fresh twist to the original game.")
								.multilineTextAlignment(.center)
								.modifier(settingsButtonsLightModifier())
								.lineSpacing(6)
						}
						.padding(.bottom)
						
						
						Group {
							Image("chart")
								.resizable()
								.frame(width: 340, height: 250)
						}
					}
					.padding(.top, topPadding + 30)
					.padding(.horizontal, horizontalPadding + 10)

					Spacer()
					
//					MARK: Dismiss button
					
					DismissButtonLarge()
				}
				.padding(.bottom, bottomPadding - 18)

				
				
			}.ignoresSafeArea()
			
			
    }
}

struct HowToPlayView_Previews: PreviewProvider {
    static var previews: some View {
        HowToPlayView()
    }
}
