//
//  ProfileCoordinator.swift
//  Auth PriviyID
//
//  Created by Qiarra on 04/09/21.
//

import RxSwift

class ProfileCoordinator: ReactiveCoordinator<Void> {
    
    var rootViewController: UIViewController
    private var viewModel = ProfileViewModel()
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<Void> {
        let viewController = rootViewController as! ProfileView
        viewController.viewModel = viewModel
        
        viewModel.navigateToEditProfile
            .flatMapLatest { _ in
                return self.coordinateToEditProfile(viewController: viewController)
            }.subscribe()
            .disposed(by: disposeBag)
        
//
        return Observable.never()
    }
    
    private func coordinateToEditProfile(viewController: UIViewController) -> Observable<Void> {
        let coordinator = EditProfileCoordinator(rootViewController: rootViewController)
        return coordinate(to: coordinator)
    }
    
}


