//
//  AppDelegate.swift
//  CheckmarkDemo
//
//  Created by Guilherme Rambo on 07/11/18.
//  Copyright © 2018 Guilherme Rambo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private lazy var onboardingController = OnboardingFlowController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.rootViewController = onboardingController
        window?.makeKeyAndVisible()

        return true
    }

}

