//
//  AppDelegate.swift
//  Classifieds
//
//  Created by kamran on 08/02/2021.
//

import UIKit
import Swinject

@main
class AppDelegate: UIResponder {
    
    var window: UIWindow?
    private lazy var assembler: Assembler = Assembler(assemblies)
    
    private let assemblies: [Assembly] = [
        homeAssembly()]
    
}

extension AppDelegate: UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        setupInitialization()
        return true
    }
    
    private func setupInitialization() {
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else { return }
        guard let router = self.assembler.resolver.resolve(homeRouterType.self) as? homeRouter else { return }
        router.presentHomeViewController(in: window)
        
    }
    
}
