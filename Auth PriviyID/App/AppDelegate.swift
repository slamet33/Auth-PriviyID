//
//  AppDelegate.swift
//  Auth PrivyID
//
//  Created by Qiarra on 28/08/21.
//

import UIKit
import RxSwift
import Wormholy
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var appCoordinator: AppCoordinator!
    private let disposeBag = DisposeBag()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Wormholy.limit = 20
        IQKeyboardManager.shared.enable = true
        
        AppManager.shared.initial()
        
        window = UIWindow()
        appCoordinator = AppCoordinator(window: window!)
        appCoordinator.start()
            .subscribe()
            .disposed(by: disposeBag)
        
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
                
        return true
    }
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.reduce("") { $0 + String(format: "%.2x", $1)}
        AuthManager.shared.saveDeviceToken(token: token)
    }
}

