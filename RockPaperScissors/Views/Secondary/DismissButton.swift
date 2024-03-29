//
//  DismissButton.swift
//  RockPaperScissors
//
//  Created by Gitko Denis on 07.03.2023.
//

import SwiftUI

struct DismissButton: View {
	@Environment(\.dismiss) var dismiss
	@ObservedObject var viewsSettings = ViewsSettings()
	
    var body: some View {
			Button {
				self.dismiss()
//				Code to revert orientation back to portrait mode
				AppDelegate.orientationLock = UIInterfaceOrientationMask.portrait
				UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
				UIViewController.attemptRotationToDeviceOrientation()

			} label: {
					Image(systemName: "xmark")
					.font(.title2.bold())
					.foregroundColor(.white)
						.background(
							ZStack {
								Circle()
//									.fill(
//										viewsSettings.isToggleOn ?
//										Color.buttonsBackground
//										: Color.buttonsBackground
//									)
									.fill(Color.buttonsBackground)
							
									.frame(width: 40, height: 40)
								
							}
								.shadow(radius: 4)

						)
			}
    }
}

struct DismissButton_Previews: PreviewProvider {
    static var previews: some View {
        DismissButton()
    }
}
