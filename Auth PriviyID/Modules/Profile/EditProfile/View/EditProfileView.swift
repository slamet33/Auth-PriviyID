//
//  EditProfileView.swift
//  Auth PriviyID
//
//  Created by Qiarra on 07/09/21.
//

import UIKit

class EditProfileView: BaseView {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: EditProfileViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        components()
        setupTableView()
        bindView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
    
    private func components() {
        
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(EditCarrerTableCell.self)
        tableView.register(ProfileHeadSectionTableCell.self)
        tableView.register(EditBioProfileTableCell.self)
        tableView.register(EditEducationTableCell.self)
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
        
        viewModel.successUpdate
            .subscribe(onNext: { [weak self] isSuccess in
                guard let isSuccess = isSuccess else { return }
                if isSuccess {
                    self?.showCustomToast("Success", subTitle: "Successfully update data!", alertType: .success)
                    self?.navigationController?.popViewController(animated: true)
                } else {
                    self?.showCustomToast("Failed", subTitle: "Failed update data, Try Again!", alertType: .error)
                }
            }).disposed(by: disposeBag)
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        viewModel.postBio()
    }
}

extension EditProfileView: PopupChoiceViewDelegate {
    
    func didSelectedChoice(_ id: Int, data: String, image: UIImage?, index: Int) {
        self.viewModel.gender = data
        self.viewModel.request.selectedIndex = index
        self.tableView.reloadData()
    }
}

extension EditProfileView: EditBioProfileTableCellDelegate {
    
    func didSelectGender() {
        let choise = PopupChoiceView()
        choise.delegate = self
        choise.selectedIndex = viewModel.request.selectedIndex
//        choise.choiseType = .gender
        choise.choiseData = viewModel.request.genderData
        present(choise, animated: true, completion: nil)
    }
    
}
