//
//  SignUpViewModel.swift
//  Auth PriviyID
//
//  Created by Qiarra on 04/09/21.
//

import RxSwift
import RxRelay

struct OtpData {
    var phone: String
    var userId: String
}

class SignUpViewModel: BaseViewModel {
    
    var repository = SignUpRepository()
    
    var phone = BehaviorRelay<String?>(value: nil)
    var password = BehaviorRelay<String?>(value: nil)
    var country = BehaviorRelay<String?>(value: nil)
    var data = BehaviorRelay<RegisterModelData?>(value: nil)
    var dataOTP = BehaviorRelay<RegisterModelData?>(value: nil)
    
    var request = SignUpRequest.shared
    
    var navigateToOTP = PublishSubject<OtpData>()
    
    func signUp() {
        self.state.onNext(.loading)
        repository.signUp(request: request)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [unowned self] result in
                switch result {
                case .success(let model):
                    self.data.accept(model.data)
                    self.state.onNext(.finish)
                case .failure(let error):
                    self.error.onNext(error)
                }
                self.state.onNext(.finish)
            }, onFailure: { [unowned self] error in
                self.state.onNext(.error)
            }).disposed(by: disposeBag)
    }
    
    func requestOTP() {
        self.state.onNext(.loading)
        repository.otp(request: request)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [unowned self] result in
                switch result {
                case .success(let model):
                    self.dataOTP.accept(model.data)
                    self.state.onNext(.finish)
                case .failure(let error):
                    self.error.onNext(error)
                }
                self.state.onNext(.finish)
            }, onFailure: { [unowned self] error in
                self.state.onNext(.error)
            }).disposed(by: disposeBag)
    }
    
    func prepareToNavigateToOTP() {
        guard let _userId = data.value?.user?.id  else { return }
        guard let _phone = data.value?.user?.phone  else { return }
        let otpData = OtpData(phone: _phone, userId: _userId)
        navigateToOTP.onNext(otpData)
    }
    
}
