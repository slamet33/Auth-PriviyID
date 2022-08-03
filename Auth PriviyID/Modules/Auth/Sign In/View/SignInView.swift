//
//  SignInView.swift
//  Auth PriviyID
//
//  Created by Qiarra on 04/09/21.
//

import UIKit
import RxSwift
import CoreLocation

class SignInView: BaseView, CLLocationManagerDelegate {

    @IBOutlet weak var phoneTf: UITextField! {
        didSet {
            phoneTf.rx
                .controlEvent(.allEditingEvents)
                .withLatestFrom(phoneTf.rx.text.orEmpty)
                .subscribe(onNext: { text in
                    let isValidNumber = text.isValidNumber()
                    
                    if isValidNumber && text.count >= 7 && text.count <= 13 {
                        self.viewModel.request.phone = text
                    }
                }).disposed(by: disposeBag)
        }
    }
    
    @IBOutlet weak var passwordTf: UITextField! {
        didSet {
            passwordTf.rx
                .controlEvent(.allEditingEvents)
                .withLatestFrom(passwordTf.rx.text.orEmpty)
                .subscribe(onNext: { text in
                    
                    if text.count >= 6 {
                        self.viewModel.request.password = text
                    }
                }).disposed(by: disposeBag)
        }
    }
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var signUpBtn: UILabel!
    
    var viewModel: SignInViewModel!
    
    var manager = CLLocationManager()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        components()
        bindView()
        locationManagerSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func components()  {
        signUpBtn.isUserInteractionEnabled = true
        signUpBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didSelectSignUp(_:))))
        
        self.btnLogin.disabledButton()
        
        let passwordValidation = passwordTf
            .rx
            .controlEvent(.allEditingEvents)
            .withLatestFrom(self.passwordTf.rx.text.orEmpty)
            .map ({
                !$0.isEmpty && $0.count >= 6
            }).share(replay: 1)
        
        let phoneValidation = phoneTf
            .rx
            .controlEvent(.allEditingEvents)
            .withLatestFrom(self.phoneTf.rx.text.orEmpty)
            .map ({
                !$0.isEmpty && $0.isValidNumber() && $0.count >= 7 && $0.count <= 13
            }).share(replay: 1)
        
        let signInStateButton = Observable.combineLatest(passwordValidation, phoneValidation) { (password, phone) in
            return password && phone}
        
        signInStateButton.bind(to: self.btnLogin.rx.valid).disposed(by: disposeBag)
    }
    
    private func bindView() {
        viewModel
            .state
            .bind { [unowned self] state in
                DispatchQueue.main.async {
                    switch state {
                    case .loading:
                        self.loading.startAnimating()
                    default:
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                            self.loading.stopAnimating()
                        }
                    }
                }
            }.disposed(by: disposeBag)
        
        viewModel.error
            .subscribe(onNext: { [weak self] error in
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                    self?.loading.stopAnimating()
                    self?.showAlert(error.error?.errors?[0] ?? "error found", nil)
                }
            }).disposed(by: disposeBag)
        
        btnLogin
            .rx
            .tap
            .bind {[unowned self] in
                self.prepareSignIn()
            }.disposed(by: disposeBag)
        
    }
    
    private func prepareSignIn() {
        let lat = manager.location?.coordinate.latitude
        let long = manager.location?.coordinate.longitude
        viewModel.request.latLong = "\(lat ?? 0),\(long ?? 0)"
        viewModel.signIn()
    }
    
    private func locationManagerSetup() {
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        switch manager.authorizationStatus {
        case .denied, .notDetermined, .restricted:
            manager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
    }
    
    @objc func didSelectSignUp(_ tap: UITapGestureRecognizer) {
        viewModel.navigateToSignUp.onNext(())
    }
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {}
}

extension SignInView: AlertPresentable {}
