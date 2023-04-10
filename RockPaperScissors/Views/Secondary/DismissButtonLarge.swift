//
//  DismissButtonLarge.swift
//  RockPaperScissors
//
//  Created by Gitko Denis on 04.04.2023.
//

import SwiftUI

struct DismissButtonLarge: View {
	@ObservedObject var viewsSettings = ViewsSettings()
	@Environment (\.dismiss) var dismiss
	
    var body: some View {
			Button {
				self.dismiss()
				print("closed")
			} label: {
				Image(systemName: "xmark")
					.foregroundColor(.white)
					.font(.largeTitle)
					.background(
						RoundedRectangle(cornerRadius: 10)
							.fill(viewsSettings.isToggleOn ?
										Color.accentPrimary
										: Color.buttonsBackground)
							.frame(width: 65, height: 65)
							.shadow(radius: 3)
					)
			}
			.padding(.top, 30)
    }
}

struct DismissButtonLarge_Previews: PreviewProvider {
    static var previews: some View {
        DismissButtonLarge()
    }
}
