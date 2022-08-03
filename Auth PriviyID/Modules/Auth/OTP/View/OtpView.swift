//
//  OTPView.swift
//  Auth PriviyID
//
//  Created by Qiarra on 04/09/21.
//

import UIKit

class OtpView: BaseView {
    
    @IBOutlet weak var verificationCodeOne: UITextField!
    @IBOutlet weak var verificationCodeTwo: UITextField!
    @IBOutlet weak var verificationCodeThree: UITextField!
    @IBOutlet weak var verificationCodeFour: UITextField!
    @IBOutlet weak var verificationBtn: UIButton!
    @IBOutlet weak var resendBtn: UILabel!
    
    var viewModel: OtpViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        components()
        bindView()
    }
    
    private func components() {
        resendBtn.isUserInteractionEnabled = true
        resendBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapResend(_:))))
        
        verificationCodeOne.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        verificationCodeTwo.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        verificationCodeThree.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        verificationCodeFour.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        verificationCodeOne.delegate = self
        verificationCodeTwo.delegate = self
        verificationCodeThree.delegate = self
        verificationCodeFour.delegate = self
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
                    self?.wrongOTPState()
                }
            }).disposed(by: disposeBag)
        
        
        verificationBtn
            .rx
            .tap
            .bind { [unowned self] in
                self.viewModel.matchOtp()
            }.disposed(by: disposeBag)
        
    }
    
    private func wrongOTPState() {
        self.verificationCodeOne.text = ""
        self.verificationCodeTwo.text = ""
        self.verificationCodeThree.text = ""
        self.verificationCodeFour.text = ""
        self.verificationCodeOne.becomeFirstResponder()
    }
    
    // MARK: PRIVATE FUNCTION
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if text.count == 1 {
            switch textField {
            case verificationCodeOne:
                viewModel.otpCodes[0] = text
                verificationCodeTwo.becomeFirstResponder()
                break
                
            case verificationCodeTwo:
                viewModel.otpCodes[1] = text
                verificationCodeThree.becomeFirstResponder()
                break
                
            case verificationCodeThree:
                viewModel.otpCodes[2] = text
                verificationCodeFour.becomeFirstResponder()
                break
                
            case verificationCodeFour:
                viewModel.otpCodes[3] = text
                if viewModel.otpCodes.count == 4 {
                    let otpCode = viewModel.otpCodes.joined()
                    self.viewModel.request.otp = otpCode
                }
                break
                
            default:
                return
            }
        }
    }
    
    @objc func didTapResend(_ tap: UITapGestureRecognizer) {
        viewModel.requestOtp()
    }
}

extension OtpView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let textFieldText = textField.text,
              let rangeOfTextToReplace = Range(range, in: textFieldText) else { return false }
        let subStringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - subStringToReplace.count + string.count
        return count <= 1
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension OtpView: AlertPresentable{}
