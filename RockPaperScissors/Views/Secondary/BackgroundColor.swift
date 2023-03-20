//
//  BackgroundColor.swift
//  RockPaperScissors
//
//  Created by Gitko Denis on 13.03.2023.
//

import SwiftUI

struct BackgroundColor: View {
	@AppStorage("isToggleOn") private var isToggleOn: Bool = false
	
    var body: some View {
			if isToggleOn {
				Color.background
			} else {
				Color.backgroundAlt
			}
				
    }
}

struct BackgroundColor_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundColor()
    }
}
