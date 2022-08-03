//
//  HomeViewViewController.swift
//  Auth PriviyID
//
//  Created by Qiarra on 04/09/21.
//

import UIKit

class HomeView: UIViewController {

    @IBOutlet weak var debugLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if AuthManager.shared.isAuth {
            debugLbl.text = "Selamat Datang Anda Sudah Login"
        } else {
            debugLbl.text = "Silahkan Login dulu"
        }
    }

}
