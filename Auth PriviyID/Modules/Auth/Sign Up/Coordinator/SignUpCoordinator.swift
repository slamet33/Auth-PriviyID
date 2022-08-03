//
//  SignUpCoordinator.swift
//  Auth PriviyID
//
//  Created by Qiarra on 04/09/21.
//

import RxSwift

class SignUpCoordinator: ReactiveCoordinator<Void> {
    
    var rootViewController: UIViewController
    private var viewModel = SignUpViewModel()
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<Void> {
        let viewController = SignUpView()
        viewController.viewModel = viewModel
        
        viewModel.navigateToOTP
            .flatMapLatest { data in
                return self.coordinateToOTP(vc: viewController, data: data)
            }.subscribe()
            .disposed(by: disposeBag)
        
        rootViewController.navigationController?.pushViewController(viewController, animated: true)
        return Observable.never()
    }
    
    private func coordinateToOTP(vc: UIViewController, data: OtpData) -> Observable<Void> {
        let coordinator = OtpCoordinator(rootViewController: vc, data: data)
        return coordinate(to: coordinator)
    }

}


