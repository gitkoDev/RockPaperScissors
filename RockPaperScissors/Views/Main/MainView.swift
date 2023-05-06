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
	@State private var showHowToPlayModal = false
	@ObservedObject var viewsSettings = ViewsSettings()
	
	var body: some View {
		
		ZStack {
			BackgroundColor(viewsSettings: viewsSettings)

			VStack(spacing: 50) {
				HStack(alignment: .center) {
					Spacer()
					SettingsButton()
				}
				.padding(.top, 80)
				.padding(.horizontal, 20)
				
				GeometryReader { geo in
					Image("mainViewImage")
						.resizable()
						.scaledToFit()
						.frame(width: geo.size.width * 0.7)
						.frame(width: geo.size.width)
				}
//				.background(.red)
				
//				MARK: Game mode buttons
				
				Button(action: {
					showCPUModal.toggle()
					
				}) {
					Text("VS CPU")
						.buttonsModifier()
				}
				.fullScreenCover(isPresented: $showCPUModal) {
					SingleplayerView()
				}
				
				Button(action: {
					showPlayerModal.toggle()
					
					//					Lock the view into landscape mode
					AppDelegate.orientationLock = UIInterfaceOrientationMask.landscape
					UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
					UIViewController.attemptRotationToDeviceOrientation()
				}) {
					Text("VS Player")
						.buttonsModifier()
				}
				.padding(.bottom)
								
					.fullScreenCover(isPresented: $showPlayerModal) {
						MultiplayerView()
					}
				
				Spacer()
	
				
//				MARK: How to play button
				Button {
					showHowToPlayModal.toggle()
				} label: {
					Text("How to play")
						.font(.custom("JosefinSansRoman-Medium", size: 19))
						.foregroundColor(.white)
				}
				.fullScreenCover(isPresented: $showHowToPlayModal) {
					HowToPlayView()
				}
				
				Spacer()
				
			}
		}
		.ignoresSafeArea()

	}

}

struct MenuButtons: ViewModifier {
	@ObservedObject var viewsSettings = ViewsSettings()
	
	func body(content: Content) -> some View {
		content
			.foregroundColor(Color(red: 1, green: 1, blue: 1))
		.padding(32)
		.padding(.horizontal, 10)
		.background(Color.buttonsBackground)
		.background(Rectangle().fill(.black))
		.cornerRadius(10)

		.font(.custom("JosefinSansRoman-Bold", size: 20))
		.padding(.all, 2.5)

		.background(
			RoundedRectangle(cornerRadius: 10)
				.fill(Color.drawBackground)
				.shadow(color: .secondary, radius: 3, x: 1, y: 1)
		)

	}
}



struct MainView_Previews: PreviewProvider {
	static var previews: some View {
		MainView()
	}
}
