//
//  RoomTypeTableViewCell.swift
//  tenantapp
//
//  Created by Agus RoomMe on 10/06/20.
//  Copyright © 2020 RoomMe. All rights reserved.
//

import UIKit

class PopupChoiceTableCell: UITableViewCell, ReusableCell {
    
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var checkImg: UIImageView!
    @IBOutlet weak var img: UIImageView!
    
//    var data: BankListModelData?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell() {
//        countLbl.text = data?.bankName
    }
    
    func hideCheckList() {
        checkImg.isHidden = true
    }
    
    func unhideCheckList() {
        checkImg.isHidden = false
    }

    func hideImg() {
        img.isHidden = true
    }
    
    func unhideImg() {
        img.isHidden = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selected ? unhideCheckList() : hideCheckList()
    }
    
}
