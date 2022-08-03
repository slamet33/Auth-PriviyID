//
//  EditBioProfileTableCell.swift
//  Auth PriviyID
//
//  Created by Qiarra on 07/09/21.
//

import UIKit
import RxSwift

protocol EditBioProfileTableCellDelegate: NSObject {
    func didSelectGender()
}

class EditBioProfileTableCell: UITableViewCell, ReusableCell {

    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var genderTf: UITextField!
    @IBOutlet weak var birthDayTf: UITextField!
    @IBOutlet weak var homeTownTf: UITextField!
    @IBOutlet weak var bioTv: UITextView!
    
    var viewModel: EditProfileViewModel?
    var delegate: EditBioProfileTableCellDelegate?
    var editDelegate: EditProfileDelegate?
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        components()
    }
    
    private func components() {
        bioTv.layer.cornerRadius = 5
        bioTv.layer.borderWidth = 1
        bioTv.layer.borderColor = Colors.lightGray.cgColor
        
        genderTf.isUserInteractionEnabled = true
        genderTf.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didSelectGender(_:))))
        
        bioTv.rx.text
            .subscribe(onNext: { text in
                guard let value = text else { return }
                self.editDelegate?.setValueBioe(type: .bio, text: value)
            }).disposed(by: disposeBag)
        
        homeTownTf.rx
            .controlEvent(.allEditingEvents)
            .withLatestFrom(homeTownTf.rx.text.orEmpty)
            .subscribe(onNext: { text in
                self.editDelegate?.setValueBioe(type: .hometown, text: text)
            }).disposed(by: disposeBag)
        
        birthDayTf.rx
            .controlEvent(.allEditingEvents)
            .withLatestFrom(birthDayTf.rx.text.orEmpty)
            .subscribe(onNext: { text in
                self.editDelegate?.setValueBioe(type: .birthDay, text: text)
            }).disposed(by: disposeBag)
        
        nameTf.rx
            .controlEvent(.allEditingEvents)
            .withLatestFrom(nameTf.rx.text.orEmpty)
            .subscribe(onNext: { text in
                self.editDelegate?.setValueBioe(type: .name, text: text)
            }).disposed(by: disposeBag)
    }
    
    @objc func didSelectGender(_ tap: UITapGestureRecognizer) {
        delegate?.didSelectGender()
    }
    
    func configureCell(data: EditProfileUser?) {
        self.genderTf.text = data?.gender == "0" ? "Male" : "Female"
    }
    
    func configureCell(value: String, targetTextFiled: UITextField) {
        targetTextFiled.text = value
    }
}
