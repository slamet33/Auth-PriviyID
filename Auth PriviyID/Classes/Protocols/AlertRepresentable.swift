//
//  AlertRepresentable.swift
//  Auth PriviyID
//
//  Created by Qiarra on 04/08/22.
//

import UIKit

protocol AlertPresentable where Self: UIViewController {
    func showAlert(_ message: String, _ title: String?)
}


extension AlertPresentable {
    
    func showAlert(_ message: String, _ title: String?) {
        let alert = UIAlertController(title: title ?? "", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

