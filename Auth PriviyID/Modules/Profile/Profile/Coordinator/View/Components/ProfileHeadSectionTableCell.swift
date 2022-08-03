//
//  ProfileHeadSectionTableCell.swift
//  Auth PriviyID
//
//  Created by Slamet Riyadi on 04/08/22.
//

import UIKit
import RxSwift

protocol ProfileHeadSectionTableCellDelegate: NSObject{
    func didTapProfileImg()
    func didTapCoverImg()
}

enum ProfileHeaderType {
    case profile
    case edit
}

class ProfileHeadSectionTableCell: UITableViewCell, ReusableCell {

    @IBOutlet weak var coverImg: UIImageView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var containerProfileImage: UIView!
    @IBOutlet weak var shadowProfileImg: UIView!
    @IBOutlet weak var addProfileImgButton: UIButton!
    @IBOutlet weak var shadowCoverImg: UIView!
    @IBOutlet weak var addCoverButton: UIButton!
    @IBOutlet weak var containerCoverImage: UIView!
    
    weak var delegate: ProfileHeadSectionTableCellDelegate?
    var disposeBag = DisposeBag()
    var type: ProfileHeaderType = .profile
    
    override func awakeFromNib() {
        super.awakeFromNib()
        components()
    }
    
    private func components() {
        containerProfileImage.addShadow(offset: CGSize(width: 0, height: 1), color: UIColor.black.withAlphaComponent(0.6), borderColor: UIColor.lightGray, radius: 2, opacity: 0.6)
        containerCoverImage.addShadow(offset: CGSize(width: 0, height: 1), color: UIColor.black.withAlphaComponent(0.6), borderColor: UIColor.lightGray, radius: 2, opacity: 0.6)
    }
    
    func setupForProfile() {
        shadowCoverImg.isHidden = true
        shadowProfileImg.isHidden = true
        addCoverButton.isHidden = true
        addProfileImgButton.isHidden = true
        
        profileImg.isHidden = false
        coverImg.isHidden = false
    }
    
    func setupForEditProfile() {
        shadowCoverImg.isHidden = false
        shadowProfileImg.isHidden = false
        addCoverButton.isHidden = false
        addProfileImgButton.isHidden = false
        
        profileImg.isHidden = true
        coverImg.isHidden = false
    }
    
    func configureCell(cover: String, profile: String) {
        switch type {
        case .profile:
            self.setupForProfile()
        case .edit:
            self.setupForEditProfile()
        }
        
        coverImg.setImage(cover)
        profileImg.setImage(cover)
    }

}
