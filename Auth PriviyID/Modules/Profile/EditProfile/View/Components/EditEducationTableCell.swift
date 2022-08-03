//
//  EditEducationTableCell.swift
//  Auth PriviyID
//
//  Created by Qiarra on 07/09/21.
//

import UIKit
import RxSwift

class EditEducationTableCell: UITableViewCell, ReusableCell {
    
    @IBOutlet weak var schoolTf: UITextField! {
        didSet {
            schoolTf.rx
                .controlEvent(.allEditingEvents)
                .withLatestFrom(schoolTf.rx.text.orEmpty)
                .subscribe(onNext: { text in
                    self.viewModel.request.schoolName = text
                }).disposed(by: disposeBag)
        }
    }
    
    @IBOutlet weak var graduatedDateTf: UITextField! {
        didSet {
            graduatedDateTf.placeholder = "dd/mm/yyyy"
        }
    }
    
    var editDelegate: EditProfileDelegate?
    var viewModel: EditProfileViewModel!
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        components()
    }
    
    private func components() {
        graduatedDateTf.rx
            .controlEvent(.allEditingEvents)
            .withLatestFrom(graduatedDateTf.rx.text.orEmpty)
            .subscribe(onNext: { text in
                self.editDelegate?.setValueBioe(type: .tahunLulus, text: text)
            }).disposed(by: disposeBag)
        
        schoolTf.rx
            .controlEvent(.allEditingEvents)
            .withLatestFrom(schoolTf.rx.text.orEmpty)
            .subscribe(onNext: { text in
                self.editDelegate?.setValueBioe(type: .sekolah, text: text)
            }).disposed(by: disposeBag)
    }
}
