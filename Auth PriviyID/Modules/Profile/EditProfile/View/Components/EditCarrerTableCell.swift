//
//  EditCarrerTableCell.swift
//  Auth PriviyID
//
//  Created by Qiarra on 07/09/21.
//

import UIKit
import RxSwift

class EditCarrerTableCell: UITableViewCell, ReusableCell {

    @IBOutlet weak var positionTf: UITextField! {
        didSet {
            
        }
    }
    
    @IBOutlet weak var companyNameTf: UITextField! {
        didSet {
            
        }
    }
    
    @IBOutlet weak var startDateTf: UITextField! {
        didSet {
            startDateTf.placeholder = "dd/mm/yyyy"
        }
    }
    
    @IBOutlet weak var endDateTf: UITextField! {
        didSet {
            endDateTf.placeholder = "dd/mm/yyyy"
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
        positionTf.rx
            .controlEvent(.allEditingEvents)
            .withLatestFrom(positionTf.rx.text.orEmpty)
            .subscribe(onNext: { text in
                self.editDelegate?.setValueBioe(type: .posisi, text: text)
            }).disposed(by: disposeBag)
        
        companyNameTf.rx
            .controlEvent(.allEditingEvents)
            .withLatestFrom(companyNameTf.rx.text.orEmpty)
            .subscribe(onNext: { text in
                self.editDelegate?.setValueBioe(type: .namaPerusahaan, text: text)
            }).disposed(by: disposeBag)
        
        startDateTf.rx
            .controlEvent(.allEditingEvents)
            .withLatestFrom(startDateTf.rx.text.orEmpty)
            .subscribe(onNext: { text in
                self.editDelegate?.setValueBioe(type: .from, text: text)
            }).disposed(by: disposeBag)
        
        endDateTf.rx
            .controlEvent(.allEditingEvents)
            .withLatestFrom(endDateTf.rx.text.orEmpty)
            .subscribe(onNext: { text in
                self.editDelegate?.setValueBioe(type: .to, text: text)
            }).disposed(by: disposeBag)
    }
    
}
