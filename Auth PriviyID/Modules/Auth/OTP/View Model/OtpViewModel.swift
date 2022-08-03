//
//  OtpViewModel.swift
//  Auth PriviyID
//
//  Created by Qiarra on 04/09/21.
//

import RxSwift
import RxRelay

class OtpViewModel: BaseViewModel {
    
    var repository = OTPRepository()
    
    var data = BehaviorRelay<SuccessSignInData?>(value: nil)
    var dataOTP = BehaviorRelay<RegisterModelData?>(value: nil)
    
    var otpCodes: [String] = ["", "", "", ""]
    var request = OTPRequest.shared
    var navigateToRoot = PublishSubject<Void>()
    
    func matchOtp() {
        self.state.onNext(.loading)
        repository.matchOtp(request: self.request)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [unowned self] result in
                switch result {
                case .success(let model):
                    if let token =  model.data?.user?.accessToken {
                        AuthManager.shared.saveAuth(token: token)
                        self.navigateToRoot.onNext(())
                        self.state.onNext(.finish)
                    }
                case .failure(let error):
                    self.error.onNext(error)
                }
                self.state.onNext(.finish)
            }, onFailure: { [unowned self] error in
                self.state.onNext(.error)
            }).disposed(by: disposeBag)
    }
    
    func requestOtp() {
        self.state.onNext(.loading)
        repository.requestOTP(request: self.request)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [unowned self] result in
                switch result {
                case .success(let model):
                    self.dataOTP.accept(model)
                case .failure(let error):
                    self.error.onNext(error)
                }
                self.state.onNext(.finish)
            }, onFailure: { [unowned self] error in
                self.state.onNext(.error)
            }).disposed(by: disposeBag)
    }
}

