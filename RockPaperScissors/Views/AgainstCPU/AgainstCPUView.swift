//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Gitko Denis on 16.02.2023.
//

import SwiftUI
import WrappingStack

struct AgainstCPUView: View {
	@AppStorage("isToggleOn") private var isToggleOn: Bool = false
	@ObservedObject var viewsSettings = ViewsSettings()
	@State private var gameMode: ViewsSettings.GameModes = .againstCPU
	
    var body: some View {
			ZStack() {
				BackgroundColor(viewsSettings: viewsSettings)
				
				VStack(spacing: 20) {
					
					Spacer().frame(height: 35)
					HStack {
						DismissButton()
						Spacer()
						SettingsButton()
					}
					.padding(30)
		// MARK: Battleboard
					
					Spacer().frame(height: 15)
					
					Battleboard(viewsSettings: viewsSettings, gameMode: $gameMode)
					
					
					//	MARK: User choice buttons
					
					ObjectsStack(viewsSettings: viewsSettings, gameMode: $gameMode)
					
					Spacer()
				}
				
			}
			.ignoresSafeArea()
    }
	
//	init() {
//		for fontFamily in UIFont.familyNames {
//			print(fontFamily)
//			for fontName in UIFont.fontNames(forFamilyName: fontFamily) {
//				print("-- \(fontName)")
//			}
//		}
//	}
	
	}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
			AgainstCPUView()
    }
}

