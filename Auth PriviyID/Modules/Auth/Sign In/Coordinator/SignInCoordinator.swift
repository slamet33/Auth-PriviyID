//
//  SignInCoordinator.swift
//  Auth PriviyID
//
//  Created by Qiarra on 04/09/21.
//

import RxSwift
import RxCocoa

class SignInCoordinator: ReactiveCoordinator<Void> {
    
    var rootViewController: UIViewController
    private var viewModel = SignInViewModel()
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<Void> {
        let viewController = rootViewController as! SignInView
        viewController.viewModel = viewModel
        
        viewModel.navigateToSignUp
            .flatMapLatest { _ in
                return self.coordinateToSignUp(vc: viewController)
            }.subscribe()
            .disposed(by: disposeBag)
        
        viewModel.navigateToRoot
            .flatMapLatest({ [unowned self] _ in
                return self.coordinateToResetRoot()
            })
            .subscribe()
            .disposed(by: disposeBag)
        
        return Observable.never()
    }

    private func coordinateToSignUp(vc: UIViewController) -> Observable<Void> {
        let coordinator = SignUpCoordinator(rootViewController: vc)
        return coordinate(to: coordinator)
    }
    
    private func coordinateToResetRoot() -> Observable<Void> {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let appCoordinator = AppCoordinator(window: appDelegate.window!)
        return coordinate(to: appCoordinator)
            .map { _ in () }
    }
    
}


