//
//  SignInViewModel.swift
//  Auth PriviyID
//
//  Created by Qiarra on 04/09/21.
//

import RxRelay
import RxSwift

class SignInViewModel: BaseViewModel {
    
    var repository = SignInRepository()
    
    var navigateToSignUp = PublishSubject<Void>()
    var navigateToRoot = PublishSubject<Void>()
   
    var request = SignInRequest.shared
    
    func signIn() {
        self.state.onNext(.loading)
        repository.signIn(request: request)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [unowned self] result in
                switch result {
                case .success(let model):
                    if let token =  model.data?.user?.accessToken {
                        AuthManager.shared.saveAuth(token: token)
                        self.navigateToRoot.onNext(())
                        self.state.onNext(.finish)
                    }
                    self.state.onNext(.finish)
                case .failure(let error):
                    self.error.onNext(error)
                }
                self.state.onNext(.finish)
            }, onFailure: { [unowned self] error in
                self.state.onNext(.error)
            }).disposed(by: disposeBag)
    }
}
