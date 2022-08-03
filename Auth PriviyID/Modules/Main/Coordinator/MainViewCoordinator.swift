//
//  MainCoordinator.swift
//  Auth PriviyID
//
//  Created by Qiarra on 04/09/21.
//

import RxSwift

class MainViewCoordinator: ReactiveCoordinator<Void> {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        
        let homeCoordinator = HomeViewCoordinator(rootViewController: homeView.viewControllers[0])
        let profileCoordinator = AuthManager.shared.isAuth ? ProfileCoordinator(rootViewController: profileView.viewControllers[0]) : SignInCoordinator(rootViewController: signInView.viewControllers[0])
        
        _ = [homeCoordinator, profileCoordinator].map {
            coordinate(to: $0)
        }
        
        setupTabBar()
        
        return Observable.never()
    }
    
    private func setupTabBar() {
        
        let viewController = MainView()
        
        viewController.viewControllers = [
            homeView,
            (AuthManager.shared.isAuth ? profileView : signInView)
        ]
        
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
    
    private var homeView: UINavigationController = {
        let controller = HomeView()
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.navigationBar.isHidden = false
        navigationController.tabBarItem =  UITabBarItem(title: Constants.tabBarHomeTitle, image: Constants.tabBarHomeIcon, tag: 0)
        return navigationController
    }()
    
    private var profileView: UINavigationController = {
        let controller = ProfileView()
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.navigationBar.isHidden = false
        navigationController.tabBarItem =  UITabBarItem(title: Constants.tabBarProfileTitle, image: Constants.tabBarProfileIcon, tag: 4)
        return navigationController
    }()
    
    private var signInView: UINavigationController = {
        let controller = SignInView()
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.navigationBar.isHidden = false
        navigationController.tabBarItem =  UITabBarItem(title: Constants.tabBarProfileTitle, image: Constants.tabBarProfileIcon, tag: 4)
        return navigationController
    }()
    
}

