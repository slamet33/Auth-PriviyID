//
//  UIView+Extenstions.swift
//  Post Here
//
//  Created by Qiarra on 02/09/21.
//

import UIKit

extension UIView {
    
    func addShadow(offset: CGSize, color: UIColor, borderColor: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.borderColor = borderColor.cgColor
        
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
    
}
