//
//  GeneralProperties.swift
//  RockPaperScissors
//
//  Created by Gitko Denis on 13.03.2023.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
	@Published var leftSideChoice: String = ""
	@Published var rightSideChoice: String = ""
}



