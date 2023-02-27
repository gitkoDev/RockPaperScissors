//
//  CommonProperties.swift
//  RockPaperScissors
//
//  Created by Gitko Denis on 27.02.2023.
//

import Foundation
import SwiftUI

struct BackgroundColor: View {
	var body: some View {
		LinearGradient(colors: [Color(red: 0.7, green: 0.04, blue: 0.3), Color(red: 1, green: 0.98, blue: 0.84)], startPoint: .top, endPoint: .bottom)
	}
}
