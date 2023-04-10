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
