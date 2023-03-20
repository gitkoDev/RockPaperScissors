//
//  MainView.swift
//  RockPaperScissors
//
//  Created by Gitko Denis on 27.02.2023.
//

import SwiftUI

struct MainView: View {
	@State private var showCPUModal = false
	@State private var showPlayerModal = false
	
	var body: some View {
		ZStack {
//			Color.red
			BackgroundColor() 
			VStack(spacing: 60) {
				ToggleButton()
				Button(action: {
					showCPUModal.toggle()
				}) {
					Text("VS CPU")
						.buttonsModifier()
				}

			}


		}.ignoresSafeArea()
			.fullScreenCover(isPresented: $showCPUModal) {
				AgainstCPUView()
			}

	}

}

struct MenuButtons: ViewModifier {
	func body(content: Content) -> some View {
		content
		.foregroundColor(.primary)
		.padding(35)
		.padding(.horizontal, 10)
		.background(LinearGradient(colors: [.blue, .mint], startPoint: .top, endPoint: .bottom))
		.cornerRadius(10)
		.shadow(color: .secondary, radius: 3, x: 1, y: 1)
		.font(.custom("JosefinSansRoman-Medium", size: 20))
	}
}



struct MainView_Previews: PreviewProvider {
	static var previews: some View {
		MainView()
	}
}
