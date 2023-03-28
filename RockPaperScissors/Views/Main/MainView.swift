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
	@ObservedObject var viewsSettings = ViewsSettings()
	
	var body: some View {
		
		ZStack {
			BackgroundColor(viewsSettings: viewsSettings)

			VStack(spacing: 60) {
				
					HStack(alignment: .center) {
						ToggleButton(viewsSettings: viewsSettings)

						Spacer()
						
						Button {
							
						} label: {
							Image(systemName: "gearshape.fill")
								.font(.title)
								.foregroundColor(.white)
								.shadow(radius: 3)
						}
					}
					.padding(.top, 80)
					.padding(.horizontal, 30)
				
				Spacer()
				
				Button(action: {
					showCPUModal.toggle()

				}) {
					Text("VS CPU")
						.buttonsModifier()
				}
				.fullScreenCover(isPresented: $showCPUModal) {
					AgainstCPUView()
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
				
				Spacer()
				Spacer()
				
				.fullScreenCover(isPresented: $showPlayerModal) {
					AgainstPlayerView()
					}

			}


		}
		.ignoresSafeArea()

	}

}

struct MenuButtons: ViewModifier {
	@ObservedObject var viewsSettings = ViewsSettings()
	
	func body(content: Content) -> some View {
		content
		.foregroundColor(.white)
		.padding(35)
		.padding(.horizontal, 10)
		.background(viewsSettings.isToggleOn ? Color.dismissButtonsBackgroundAlt : Color.dismissButtonsBackground)
		.background(Rectangle().fill(.black))
		.cornerRadius(10)
		.shadow(color: .secondary, radius: 3, x: 1, y: 1)
		.font(.custom("JosefinSansRoman-Medium", size: 22))
	}
}



struct MainView_Previews: PreviewProvider {
	static var previews: some View {
		MainView()
	}
}
