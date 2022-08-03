//
//  HomeCoordinator.swift
//  Auth PriviyID
//
//  Created by Qiarra on 04/09/21.
//

import RxSwift

class HomeViewCoordinator: ReactiveCoordinator<Void> {
    
    var rootViewController: UIViewController
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<Void> {
        let viewController = rootViewController as! HomeView
        
//        viewController.isUserWannaSetupPass = AuthManager.shared.isPasswordEmpty
        
        
        return Observable.never()
    }
    
}
