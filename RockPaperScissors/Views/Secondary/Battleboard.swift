//
//  Battleboard.swift
//  RockPaperScissors
//
//  Created by Gitko Denis on 20.03.2023.
//

import SwiftUI

struct Battleboard: View {
	@ObservedObject var viewsSettings: ViewsSettings
	
    var body: some View {
				HStack {
					Image(viewsSettings.leftSideChoice)
						.resizable()
						.frame(width: 80, height: 80)
						.offset(x: viewsSettings.leftObjectOffset)
					Spacer().frame(width: 100)
					Image(viewsSettings.rightSideChoice)
						.resizable()
						.frame(width: 80, height: 80)
						.offset(x: viewsSettings.rightObjectOffset)
				}
				.frame(width: 350, height: 170)
				.background(.ultraThinMaterial.opacity(0.8))
				.background(viewsSettings.battleboardBG)
				.clipShape(RoundedRectangle(cornerRadius: 10))
			.shadow(radius: 2)
			
    }
}

struct Battleboard_Previews: PreviewProvider {
    static var previews: some View {
        Battleboard(viewsSettings: ViewsSettings())
    }
}
