//
//  EditProfileView+UITableViewDelegate.swift
//  Auth PriviyID
//
//  Created by Qiarra on 07/09/21.
//

import UIKit

extension EditProfileView: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowInSections(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = viewModel.viewModelForEditProfile(at: indexPath, tableView: tableView)
        
        (cell as? EditBioProfileTableCell)?.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.heightRowIndexPath(indexPath, tableView: tableView)
    }
    
}
