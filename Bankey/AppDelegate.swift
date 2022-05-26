//
//  AppDelegate.swift
//  Bankey
//
//  Created by Karina on 09/05/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let loginController = LoginViewController()
    let onboardingViewController = OnboardingContainerViewController()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        loginController.delegate = self
        window?.rootViewController = loginController

        return true
    }

}

extension AppDelegate: LoginViewControllerDelegate {
    func didLogin() {
        setRootViewController(onboardingViewController)
    }
}

extension AppDelegate: OnboardingContainerViewControllerDelegate {
    func didFinishOnboarding() {
    }
}

extension AppDelegate {
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.8, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}

