//
//  ProfileView+UITableViewDelegate.swift
//  Auth PriviyID
//
//  Created by Slamet Riyadi on 04/08/22.
//

import UIKit

extension ProfileView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowInSections(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.viewModelForProfile(at: indexPath, tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.heightRowIndexPath(indexPath, tableView: tableView)
    }
}

extension ProfileView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        viewModel.didSelectRowAt(tableView, didSelectRowAt: indexPath)
    }
}

//extension ProfileView: SkeletonTableViewDataSource {
//
//    func numSections(in collectionSkeletonView: UITableView) -> Int {
//        viewModel.numberOfSections
//    }
//
//    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5
//    }
//
//    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
//        return PostTableCell.reuseIdentifier
//    }
//}
//
