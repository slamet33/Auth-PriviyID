//
//  AuthCoordinator.swift
//  Auth PriviyID
//
//  Created by Qiarra on 04/09/21.
//

import RxSwift

class OtpCoordinator: ReactiveCoordinator<Void> {
    
    var rootViewController: UIViewController
    private var viewModel = OtpViewModel()
    
    init(rootViewController: UIViewController, data: OtpData) {
        self.rootViewController = rootViewController
        self.viewModel.request.userId = data.userId
        self.viewModel.request.phone = data.phone
    }
    
    override func start() -> Observable<Void> {
        let viewController = OtpView()
        viewController.viewModel = viewModel
        
        viewModel.navigateToRoot
            .flatMapLatest({ [unowned self] _ in
                return self.coordinateToResetRoot()
            })
            .subscribe()
            .disposed(by: disposeBag)
        
        rootViewController.navigationController?.pushViewController(viewController, animated: true)
        return Observable.never()
    }
    
    private func coordinateToResetRoot() -> Observable<Void> {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let appCoordinator = AppCoordinator(window: appDelegate.window!)
        return coordinate(to: appCoordinator)
            .map { _ in () }
    }
    
}


