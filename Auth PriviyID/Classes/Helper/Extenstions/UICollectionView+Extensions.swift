//
//  UICollectionView+Extensions.swift
//  Post Here
//
//  Created by Qiarra on 31/08/21.
//

import UIKit

extension UICollectionView {
    
    func registerReusableCell<T: UICollectionViewCell>(_: T.Type) where T: ReusableCell {
        if let nib = T.nib {
            self.register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T where T: ReusableCell {
        return self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    func registerSupplementaryView<T: UICollectionReusableView>(_: T.Type) where T: ReusableCell {
        if let nib = T.nib {
            self.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    func dequeueSupplementaryView<T: UICollectionReusableView>(kind: String, indexPath: IndexPath) -> T where T: ReusableCell {
        return self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    func centerContentHorizontalyByInsetIfNeeded(minimumInset: UIEdgeInsets) {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout,
            layout.scrollDirection == .vertical else {
                return
        }
        
        if layout.collectionViewContentSize.width > frame.size.width {
            contentInset = minimumInset
        } else {
            contentInset = UIEdgeInsets(top: minimumInset.top, left: (frame.size.width - layout.collectionViewContentSize.width) / 2, bottom: minimumInset.bottom, right: 0)
        }
    }
    
    func reloadWithoutAnimation(){
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        self.reloadData()
        CATransaction.commit()
    }
    
    
}
