//
//  BackgroundColor.swift
//  RockPaperScissors
//
//  Created by Gitko Denis on 13.03.2023.
//

import SwiftUI

struct BackgroundColor: View {
	@ObservedObject var viewsSettings: ViewsSettings
	
    var body: some View {
			if viewsSettings.isToggleOn {
					Image("grid")
					.resizable(resizingMode: .tile)
			} else {
				Color.background
			}
				
    }
}

struct BackgroundColor_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundColor(viewsSettings: ViewsSettings())
    }
}
