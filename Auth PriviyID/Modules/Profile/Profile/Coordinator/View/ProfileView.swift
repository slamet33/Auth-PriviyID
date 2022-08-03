//
//  ProfileView.swift
//  Auth PriviyID
//
//  Created by Qiarra on 04/09/21.
//

import UIKit

class ProfileView: BaseView {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ProfileViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        components()
        setupTableView()
        bindView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func components() {
        navigationItem.setRightBarButton(UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(didSelectEdit(_:))), animated: true)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(EducationTableCell.self)
        tableView.register(CarrerTableCell.self)
        tableView.register(ProfileHeadSectionTableCell.self)
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
        
        viewModel.profile
            .asDriver()
            .drive(onNext: {[unowned self] (_) in
                self.tableView.reloadData()
            }).disposed(by: disposeBag)
        
        viewModel.getProfile()
    }
    
    @objc func didSelectEdit(_ tap: UITapGestureRecognizer) {
        viewModel.navigateToEditProfile.onNext(0)
    }
    
    @IBAction func logOut(_ sender: UIButton) {
        viewModel.logout()
    }
}

extension ProfileView: AlertPresentable {}
