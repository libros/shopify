//
//  AppDelegate.swift
//  ShopifyRepo
//
//  Created by Joel Meng on 1/16/19.
//  Copyright © 2019 Joel Meng. All rights reserved.
//

import UIKit
import ReSwift


/// Create the store in the global namespace before anything else created.
/// Store is basically the combination of state of the app, and reducers embraces actions and update states.
let store = Store<AppState>(reducer: appReducer, state: nil)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let shopifyRepoTableView = ShopifyRepoTableViewController(nibName: "\(ShopifyRepoTableViewController.self)", bundle: nil)
        window?.rootViewController = UINavigationController(rootViewController: shopifyRepoTableView)
        window?.makeKeyAndVisible()
        
        // NOTE: - Extending point
        // Should have some router object that handles global navigation actions
        store.subscribe(self)
        return true
    }
}

extension AppDelegate: StoreSubscriber {
    func newState(state: AppState) {
        guard let htmlURL = state.openURL else {
            return
        }
        UIApplication.shared.open(htmlURL, options: [:], completionHandler: nil)
    }
}
