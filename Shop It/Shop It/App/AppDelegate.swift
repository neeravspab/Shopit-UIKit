//
//  AppDelegate.swift
//  Shop It
//
//  Created by niravkumar patel on 3/3/22.
//

import UIKit
import IQKeyboardManager
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared().isEnabled = true
        Util.copyDatabase("Shopitdb.db")
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

    func adminScreen()
     {
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let navigationController = UINavigationController()
         let Controller = storyboard.instantiateViewController(withIdentifier: "HomeAdminVC") as! HomeAdminVC
         navigationController.setViewControllers([Controller], animated: false)
         navigationController.navigationBar.isHidden = true
         navigationController.navigationBar.barStyle = .black
         UIApplication.shared.connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.first { $0.isKeyWindow }?.rootViewController = navigationController
         UIApplication.shared.connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.first { $0.isKeyWindow }?.makeKeyAndVisible()
     }
     
     func resetDefaults() {
         let defaults = UserDefaults.standard
         let dictionary = defaults.dictionaryRepresentation()
         dictionary.keys.forEach { key in
             defaults.removeObject(forKey: key)
         }
     }
    
    func StartsScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = UINavigationController()
        let Controller = storyboard.instantiateViewController(withIdentifier: "MainVC") as! MainVC
        navigationController.setViewControllers([Controller], animated: false)
        navigationController.navigationBar.isHidden = false
        UIApplication.shared.connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.first { $0.isKeyWindow }?.rootViewController = navigationController
        UIApplication.shared.connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.first { $0.isKeyWindow }?.makeKeyAndVisible()
    }
    
    func adminTabScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = UINavigationController()
        let Controller = storyboard.instantiateViewController(withIdentifier: "AdminTabVC") as! AdminTabVC
        navigationController.setViewControllers([Controller], animated: false)
        navigationController.navigationBar.isHidden = true
        UIApplication.shared.connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.first { $0.isKeyWindow }?.rootViewController = navigationController
        UIApplication.shared.connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.first { $0.isKeyWindow }?.makeKeyAndVisible()
    }
    
    func userTabScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = UINavigationController()
        let Controller = storyboard.instantiateViewController(withIdentifier: "UserTabVC") as! UserTabVC
        navigationController.setViewControllers([Controller], animated: false)
        navigationController.navigationBar.isHidden = true
        UIApplication.shared.connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.first { $0.isKeyWindow }?.rootViewController = navigationController
        UIApplication.shared.connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.first { $0.isKeyWindow }?.makeKeyAndVisible()
    }
    
    func vendorTabScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = UINavigationController()
        let Controller = storyboard.instantiateViewController(withIdentifier: "VendorTabVC") as! VendorTabVC
        navigationController.setViewControllers([Controller], animated: false)
        navigationController.navigationBar.isHidden = true
        UIApplication.shared.connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.first { $0.isKeyWindow }?.rootViewController = navigationController
        UIApplication.shared.connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.first { $0.isKeyWindow }?.makeKeyAndVisible()
    }
}

