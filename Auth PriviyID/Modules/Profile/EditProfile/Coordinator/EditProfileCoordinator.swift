//
//  EditProfileCoordinator.swift
//  Auth PriviyID
//
//  Created by Qiarra on 07/09/21.
//

import RxSwift
import RxCocoa

class EditProfileCoordinator: ReactiveCoordinator<Void> {
    
    var rootViewController: UIViewController
    private var viewModel = EditProfileViewModel()
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<Void> {
        let viewController = EditProfileView()
        viewController.viewModel = viewModel
        
//        viewModel
//            .didMiniTutorialTap
//            .subscribe(onNext: { [weak self] tutorial in
//                self?.coordinateMiniTutorial(tutorial)
//            }).disposed(by: disposeBag)
        
        rootViewController.navigationController?.pushViewController(viewController, animated: true)
//
        return Observable.never()
    }
    
//    private func coordinateToNotification() -> Observable<Void> {
//        let coordinator = NotificationViewCoordinator(rootViewController: rootViewController)
//        return coordinate(to: coordinator)
//    }
    
}
