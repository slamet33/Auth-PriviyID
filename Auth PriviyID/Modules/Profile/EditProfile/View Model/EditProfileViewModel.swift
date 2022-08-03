//
//  EditProfileViewModel.swift
//  Auth PriviyID
//
//  Created by Qiarra on 07/09/21.
//

import RxSwift
import RxCocoa

class EditProfileViewModel: BaseViewModel {
    
    var repository = EditProfileRepository()
    var request = EditProfileRequest.shared
    
    var gender: String?
    
    var dataBio = BehaviorRelay<EditProfileUser?>(value: nil)
    var dataEducation = BehaviorRelay<Education?>(value: nil)
    var dataCarrer = BehaviorRelay<Career?>(value: nil)
    var successUpdate = BehaviorRelay<Bool?>(value: nil)
    
    static var shared = EditProfileViewModel()
    
    func postBio() {
        self.state.onNext(.loading)
        repository.editProfile(request: request)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [unowned self] result in
                switch result {
                case .success(let model):
                    self.dataBio.accept(model.data?.user)
                    self.education()
                    return
                case .failure(let error):
                    self.error.onNext(error)
                }
                self.state.onNext(.finish)
                self.successUpdate.accept(false)
            }, onFailure: { [unowned self] error in
                self.state.onNext(.error)
                self.successUpdate.accept(false)
            }).disposed(by: disposeBag)
    }
    
    func education() {
        self.state.onNext(.loading)
        repository.education(request: request)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [unowned self] result in
                switch result {
                case .success(let model):
                    self.dataEducation.accept(model.data?.user?.education)
                    self.carrer()
                    return
                case .failure(let error):
                    self.error.onNext(error)
                }
                self.state.onNext(.finish)
                self.successUpdate.accept(false)
            }, onFailure: { [unowned self] error in
                self.state.onNext(.error)
                self.successUpdate.accept(false)
            }).disposed(by: disposeBag)
    }

    func carrer() {
        self.state.onNext(.loading)
        repository.career(request: request)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [unowned self] result in
                switch result {
                case .success(let model):
                    self.dataCarrer.accept(model.data?.user?.career)
                    self.successUpdate.accept(true)
                    self.state.onNext(.finish)
                    return
                case .failure(let error):
                    self.error.onNext(error)
                }
                self.state.onNext(.finish)
                self.successUpdate.accept(false)
            }, onFailure: { [unowned self] error in
                self.state.onNext(.error)
                self.successUpdate.accept(false)
            }).disposed(by: disposeBag)
    }

}

extension EditProfileViewModel {
    // MARK: - TableDataSource
    var numberOfSections: Int {
        return 4
    }
    
    func numberOfRowInSections(_ section: Int) -> Int {
        return 1
    }
    
    func heightRowIndexPath(_ indexPath: IndexPath, tableView: UITableView) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func viewModelForEditProfile(at indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return createHeadSectionProfile(indexPath: indexPath, from: tableView)
        case 1:
            return createBiodataCell(indexPath: indexPath, from: tableView)
        case 2:
            return createEducationCell(indexPath: indexPath, from: tableView)
        case 3:
            return creatCarrerCell(indexPath: indexPath, from: tableView)
        default:
            return UITableViewCell()
        }
    }
    
    
    private func createHeadSectionProfile(indexPath: IndexPath, from table: UITableView) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: ProfileHeadSectionTableCell.reuseIdentifier) as! ProfileHeadSectionTableCell
        cell.type = .edit
        cell.configureCell(cover: "", profile: "")
        cell.selectionStyle = .none
        return cell
    }
    
    private func createBiodataCell(indexPath: IndexPath, from table: UITableView) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: EditBioProfileTableCell.reuseIdentifier) as! EditBioProfileTableCell
        cell.viewModel = EditProfileViewModel.shared
        cell.configureCell(data: dataBio.value)
        cell.editDelegate = self
        if let gender = gender {
            cell.configureCell(value: gender, targetTextFiled: cell.genderTf)
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    private func createEducationCell(indexPath: IndexPath, from table: UITableView) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: EditEducationTableCell.reuseIdentifier) as! EditEducationTableCell
        cell.viewModel = EditProfileViewModel.shared
        cell.editDelegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    private func creatCarrerCell(indexPath: IndexPath, from table: UITableView) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: EditCarrerTableCell.reuseIdentifier) as! EditCarrerTableCell
        cell.viewModel = EditProfileViewModel.shared
        cell.editDelegate = self
        cell.selectionStyle = .none
        return cell
    }
}

extension EditProfileViewModel: EditProfileDelegate {
    
    func setValueBioe(type: EditProfileType, text: String) {
        switch type {
        case .name:
            request.name = text
        case .gender:
            request.gender = text == "Male" ? 1 : 0
        case .hometown:
            request.homeTown = text
        case .bio:
            request.bio = text
        case .sekolah:
            request.schoolName = text
        case .tahunLulus:
            request.graduatedTime = text
        case .posisi:
            request.position = text
        case .namaPerusahaan:
            request.companyName = text
        case .from:
            request.startDate = text
        case .to:
            request.endDate = text
        case .birthDay:
            request.birthDay = text
        }
    }
    
}

enum EditProfileType {
    case name
    case gender
    case hometown
    case bio
    case sekolah
    case tahunLulus
    case posisi
    case namaPerusahaan
    case from
    case to
    case birthDay
}

protocol EditProfileDelegate {
    
    func setValueBioe(type: EditProfileType, text: String)
    
}
