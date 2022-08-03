//
//  EducationTableCell.swift
//  Auth PriviyID
//
//  Created by Slamet Riyadi on 04/08/22.
//

import UIKit

class EducationTableCell: UITableViewCell, ReusableCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var schoolLbl: UILabel!
    @IBOutlet weak var yeardGraduatedLbl: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 10
        containerView.addShadow(offset: CGSize(width: 0, height: 1), color: UIColor.black.withAlphaComponent(0.6), borderColor: UIColor.lightGray, radius: 2, opacity: 0.6)
    }
    
    func configureCell(data: Education?, name: String) {
        nameLbl.text = name
        if let education = data {
            schoolLbl.text = education.school_name
            yeardGraduatedLbl.text = education.gradDate
        }
    }
    
}
