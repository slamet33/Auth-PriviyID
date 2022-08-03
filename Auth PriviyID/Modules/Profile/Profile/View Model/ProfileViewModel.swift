//
//  ProfileViewModel.swift
//  Auth PriviyID
//
//  Created by Qiarra on 04/09/21.
//

import RxSwift
import RxCocoa

class ProfileViewModel: BaseViewModel {
    
    var repository = ProfileRepository()
    var request = ProfileRequest.shared
    
    private var _profile = BehaviorRelay<EditProfileUser?>(value: nil)
    private var _doLogout = BehaviorRelay<Bool?>(value: nil)
    
    var navigateToEditProfile = PublishSubject<Int>()
    
    var profile: Driver<EditProfileUser?> {
        return _profile.asDriver()
    }
    
    var doLogout: Driver<Bool?> {
        return _doLogout.asDriver()
    }
    
    func getProfile() {
        self.state.onNext(.loading)
        repository.getProfile()
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [unowned self] result in
                switch result {
                case .success(let model):
                    self._profile.accept(model.data?.user)
                    self.state.onNext(.finish)
                case .failure(let error):
                    self.error.onNext(error)
                }
                self.state.onNext(.finish)
            }, onFailure: { [unowned self] error in
                self.state.onNext(.error)
            }).disposed(by: disposeBag)
    }
    
    func logout() {
        self.state.onNext(.loading)
        repository.logout(viewModel: self)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [unowned self] result in
                switch result {
                case .success(let model):
                    self._profile.accept(model.data?.user)
                    self.state.onNext(.finish)
                case .failure(let error):
                    self.error.onNext(error)
                }
                self.state.onNext(.finish)
            }, onFailure: { [unowned self] error in
                self.state.onNext(.error)
            }).disposed(by: disposeBag)
    }
}

extension ProfileViewModel {
    // MARK: - TableDataSource
    var numberOfSections: Int {
        return 3
    }
    
    func numberOfRowInSections(_ section: Int) -> Int {
        return 1
    }
    
    func heightRowIndexPath(_ indexPath: IndexPath, tableView: UITableView) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func viewModelForProfile(at indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return createHeadSectionProfile(indexPath: indexPath, from: tableView)
        case 1:
            return createEducationCell(indexPath: indexPath, from: tableView)
        case 2:
            return creatCarrerCell(indexPath: indexPath, from: tableView)
        default:
            return UITableViewCell()
        }
    }
    
    
    private func createHeadSectionProfile(indexPath: IndexPath, from table: UITableView) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: ProfileHeadSectionTableCell.reuseIdentifier) as! ProfileHeadSectionTableCell
        cell.type = .profile
        cell.configureCell(cover: "", profile: "")
        
        cell.selectionStyle = .none
        return cell
    }
    
    private func createEducationCell(indexPath: IndexPath, from table: UITableView) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: EducationTableCell.reuseIdentifier) as! EducationTableCell
        if let data = _profile.value, let name = _profile.value?.name {
            cell.configureCell(data: data.education, name: name)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    private func creatCarrerCell(indexPath: IndexPath, from table: UITableView) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: CarrerTableCell.reuseIdentifier) as! CarrerTableCell
        if let data = _profile.value?.career {
            cell.configureCell(data: data)
        }
        cell.selectionStyle = .none
        return cell
    }
}
