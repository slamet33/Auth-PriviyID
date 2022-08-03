//
//  CarrerTableCell.swift
//  Auth PriviyID
//
//  Created by Slamet Riyadi on 04/08/22.
//

import UIKit

class CarrerTableCell: UITableViewCell, ReusableCell {

    @IBOutlet weak var companyNameLbl: UILabel!
    @IBOutlet weak var startFromLbl: UILabel!
    @IBOutlet weak var endLbl: UILabel!
    @IBOutlet weak var positionLbl: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 10
        containerView.addShadow(offset: CGSize(width: 0, height: 1), color: UIColor.black.withAlphaComponent(0.6), borderColor: UIColor.lightGray, radius: 2, opacity: 0.6)
    }
    
    func configureCell(data: Career) {
        companyNameLbl.text = data.company_name
        startFromLbl.text = data.start
        endLbl.text = data.end
    }
    
}
