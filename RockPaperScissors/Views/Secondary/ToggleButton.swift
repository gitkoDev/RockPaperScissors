//
//  ToggleButton.swift
//  RockPaperScissors
//
//  Created by Gitko Denis on 28.02.2023.
//

import SwiftUI

struct ToggleButton: View {
	@Binding var isToggleOn: Bool
	
    var body: some View {
			Toggle(isOn: $isToggleOn) {
				
			}
			.tint(.blue)
//			.position(x: -100, y: 15)
    }
}

struct ToggleButton_Previews: PreviewProvider {
    static var previews: some View {
			ToggleButton(isToggleOn: .constant(false))
    }
}
