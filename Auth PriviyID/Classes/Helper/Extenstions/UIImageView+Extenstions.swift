//
//  UIImageView+Extenstions.swift
//  Post Here
//
//  Created by Qiarra on 01/09/21.
//

import Kingfisher
import UIKit

extension UIImageView {
    
    func setImage(_ url: String, placeholder: String? = "placeholder-image") {
        
        let generateSupportImageURL = url
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        self.kf.setImage(with: URL(string: generateSupportImageURL), placeholder: placeholder != nil ? UIImage(named: placeholder!) : nil, options: [.cacheOriginalImage, .transition(.fade(0.6))])
    }
}

extension UIImageView {
  func enableZoom() {
    let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
    isUserInteractionEnabled = true
    addGestureRecognizer(pinchGesture)
  }

  @objc
  private func startZooming(_ sender: UIPinchGestureRecognizer) {
    let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
    guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
    sender.view?.transform = scale
    sender.scale = 1
  }
}
