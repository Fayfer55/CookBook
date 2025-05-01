//
//  AppDelegate.swift
//  CookBook
//
//  Created by Kirill Faifer on 25.03.2025.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate, ObservableObject {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        fetchIngredients()
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}

// MARK: - Core Data support

extension AppDelegate {
    
    private func fetchIngredients() {
        do {
            let context = CoreDataStack.shared.newBackgroundContext
            
            let jsonDecoder = JSONDecoder(context: context)
            let data = try Data(contentsOf: URL.ingredientsDirectory)
            _ = try jsonDecoder.decode(Set<Ingredient>.self, from: data)
            
            try CoreDataStack.shared.saveContext(with: context)
        } catch {
            print(error)
        }
    }
    
}
