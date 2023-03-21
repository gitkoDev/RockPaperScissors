//
//  AppDelegate.swift
//  RockPaperScissors
//
//  Created by Gitko Denis on 21.03.2023.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
		func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
				return true
		}
	
//	Code to turn the AgainstPlayerView into landscape mode
	static var orientationLock = UIInterfaceOrientationMask.portrait

	func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
			return AppDelegate.orientationLock
	}
}



