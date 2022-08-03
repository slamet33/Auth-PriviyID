//
//  AppCoordinator.swift
//  Auth PrivyID
//
//  Created by Qiarra on 28/08/21.
//

import RxSwift

class AppCoordinator: ReactiveCoordinator<Void> {
    
    var window: UIWindow
    var isFromResetPassword: Bool = false
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let mainCoordinator = MainViewCoordinator(window: window)
        return coordinate(to: mainCoordinator)
    }
    
}
