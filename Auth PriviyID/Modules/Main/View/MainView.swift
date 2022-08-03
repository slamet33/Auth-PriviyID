//
//  MainView.swift
//  Auth PriviyID
//
//  Created by Qiarra on 04/09/21.
//

import UIKit

class MainView: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.layer.masksToBounds = true
        self.tabBar.barStyle = .black
        self.tabBar.barTintColor = .white
        self.tabBar.tintColor = .red
        
        self.tabBar.layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        self.tabBar.layer.shadowOffset = CGSize(width: 0.0, height: 0.1)
        self.tabBar.layer.shadowRadius = 2
        self.tabBar.layer.shadowOpacity = 1
        self.tabBar.layer.masksToBounds = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    var coordinator: MainViewCoordinator?
}

