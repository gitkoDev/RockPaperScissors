//
//  DismissButton.swift
//  RockPaperScissors
//
//  Created by Gitko Denis on 07.03.2023.
//

import SwiftUI

struct DismissButton: View {
	@Environment(\.dismiss) var dismiss
	
    var body: some View {
			Button {
				self.dismiss()
			} label: {
					Image(systemName: "xmark")
						.font(.title)
						.foregroundColor(.drawBackground)
						.background(
							Circle()
								.fill(LinearGradient(colors: [.blue, .mint], startPoint: .top, endPoint: .bottom))
								.frame(width: 40, height: 40)
						)
			}
//			.position(x: 350, y: 50)
    }
}

struct DismissButton_Previews: PreviewProvider {
    static var previews: some View {
        DismissButton()
    }
}
