//
//  Battleboard.swift
//  RockPaperScissors
//
//  Created by Gitko Denis on 20.03.2023.
//

import SwiftUI

struct Battleboard: View {
	@ObservedObject var viewModel: ViewModel
	
    var body: some View {
				HStack {
	//				Image(leftSideChoice)
					Image("rock")
						.resizable()
						.frame(width: 80, height: 80)
						.offset(x: viewModel.leftObjectOffset)
					Spacer().frame(width: 100)
	//				Image(rightSideChoice)
					Image("scissorsAlt")
						.resizable()
						.frame(width: 80, height: 80)
						.offset(x: viewModel.rightObjectOffset)
				}
				.frame(width: 350, height: 170)
				.background(.ultraThinMaterial.opacity(0.8))
				.background(viewModel.battleboardBG)
				.clipShape(RoundedRectangle(cornerRadius: 10))
			.shadow(radius: 2)
			
    }
}

struct Battleboard_Previews: PreviewProvider {
    static var previews: some View {
        Battleboard(viewModel: ViewModel())
    }
}
