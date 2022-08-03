//
//  UIButton+Extenstions.swift
//  Auth PriviyID
//
//  Created by Qiarra on 04/09/21.
//

import RxSwift

extension UIButton {
    func disabledButton() {
        self.isEnabled = false
        self.titleLabel?.textColor = .white
        self.backgroundColor = UIColor.darkGray
    }
    
    func enabledButton(_ bgColor: UIColor = Colors.purple) {
        self.isEnabled = true
        self.titleLabel?.textColor = .white
        self.backgroundColor = bgColor
    }
    
}

extension Reactive where Base: UIButton {
    
    var isCheckBoxSelected: Binder<Bool> {
        return Binder(self.base) { button, selected in
            if selected {
                button.setImage(UIImage.init(named: "check_box"), for: .normal)
            } else {
                button.setImage(UIImage.init(named: "uncheck_box"), for: .normal)
            }
        }
    }
    
    var valid: AnyObserver<Bool> {
        return Binder(base, binding: { (button: UIButton, valid: Bool) in
            valid ? button.enabledButton() : button.disabledButton()
        }).asObserver()
    }
}
