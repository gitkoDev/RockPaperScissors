//
//  MainView.swift
//  RockPaperScissors
//
//  Created by Gitko Denis on 27.02.2023.
//

import SwiftUI

struct MainView: View {
	var body: some View {
		if #available(iOS 16.0, *) {
			NavigationStack {
				ZStack {
					BackgroundColor()
						.ignoresSafeArea()
					VStack {
						NavigationLink(destination: AgainstCPUView()) {
							Text("VS CPU")
						}
						Spacer().frame(height: 50)
						NavigationLink(destination: AgainstPlayerView()) {
							Text("VS Player")
						}.navigationTitle("Navigation")
					
					}
				}
			}
		} else {
			// Fallback on earlier versions
		}
	}
	
	struct MainView_Previews: PreviewProvider {
		static var previews: some View {
			MainView()
		}
	}
}
