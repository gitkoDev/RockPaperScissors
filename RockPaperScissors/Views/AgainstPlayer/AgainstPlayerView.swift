//
//  AgainstPlayerView.swift
//  RockPaperScissors
//
//  Created by Gitko Denis on 27.02.2023.
//

import SwiftUI

struct AgainstPlayerView: View {

    var body: some View {
			ZStack {
				BackgroundColor()

				VStack(spacing: 20) {

					Spacer().frame(height: 35)
					HStack {
						ToggleButton()
						Spacer()
						DismissButton()
					}
					.padding(30)
					Spacer()
					Text("HI")
					Spacer()
				}
				

				

				
				
			}
			.ignoresSafeArea()
    }
}

struct AgainstPlayerView_Previews: PreviewProvider {
    static var previews: some View {
			MainView()
    }
}
