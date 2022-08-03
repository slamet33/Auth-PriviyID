//
//  SignUpView.swift
//  Auth PriviyID
//
//  Created by Qiarra on 04/09/21.
//

import RxSwift
import RxCocoa
import CoreLocation

class SignUpView: BaseView, CLLocationManagerDelegate, AlertPresentable {

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
    
    @IBOutlet weak var countryTf: UITextField! {
        didSet {
            countryTf.rx
                .controlEvent(.allEditingEvents)
                .withLatestFrom(countryTf.rx.text.orEmpty)
                .subscribe(onNext: { text in
                    
                    if text.count >= 2 {
                        self.viewModel.request.country = text
                    }
                    
                }).disposed(by: disposeBag)
        }
    }
    
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var signInBtn: UILabel!
    
    var viewModel: SignUpViewModel!
    
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        components()
        bindView()
        locationManagerSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func components() {
        signInBtn.isUserInteractionEnabled = true
        signInBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapSignIn(_:))))
        
        self.btnRegister.disabledButton()
        
        let passwordValidation = passwordTf
            .rx
            .controlEvent(.allEditingEvents)
            .withLatestFrom(self.passwordTf.rx.text.orEmpty)
            .map ({
                !$0.isEmpty && $0.count >= 6
            }).share(replay: 1)
        
        let countryValidation = countryTf
            .rx
            .controlEvent(.allEditingEvents)
            .withLatestFrom(self.countryTf.rx.text.orEmpty)
            .map ({
                !$0.isEmpty && $0.count >= 2
            }).share(replay: 1)
        
        let phoneValidation = phoneTf
            .rx
            .controlEvent(.allEditingEvents)
            .withLatestFrom(self.phoneTf.rx.text.orEmpty)
            .map ({
                !$0.isEmpty && $0.isValidNumber() && $0.count >= 7 && $0.count <= 13
            }).share(replay: 1)
        
        let registerStateButton = Observable.combineLatest(passwordValidation, countryValidation, phoneValidation) { (password, country, phone) in
            return password && country && phone
        }
        
        registerStateButton.bind(to: self.btnRegister.rx.valid).disposed(by: disposeBag)
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
        
        viewModel.data
            .subscribe(onNext: { [weak self] data in
                guard data != nil else { return }
                self?.viewModel.prepareToNavigateToOTP()
            }).disposed(by: disposeBag)
        
        viewModel.dataOTP
            .subscribe(onNext: { [weak self] data in
                guard data != nil else { return }
                self?.viewModel.prepareToNavigateToOTP()
            }).disposed(by: disposeBag)
        
        btnRegister
            .rx
            .tap
            .bind{ [unowned self] in
                prepareSignUp()
            }.disposed(by: disposeBag)
        
    }
    
    @objc func didTapSignIn(_ tap: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func prepareSignUp() {
        let lat = manager.location?.coordinate.latitude
        let long = manager.location?.coordinate.longitude
        viewModel.request.latLong = "\(lat ?? 0),\(long ?? 0)"
        viewModel.signUp()
    }

}
