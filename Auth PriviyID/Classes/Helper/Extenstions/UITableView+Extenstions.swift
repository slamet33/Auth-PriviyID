//
//  UITableView+Extenstions.swift
//  Post Here
//
//  Created by Qiarra on 30/08/21.
//

import UIKit
import RxSwift

// MARK: - Table View Registration and Dequeue
extension UITableView {
    
    public var removeEmptyCell: Bool {
        get { return false }
        set {
            tableFooterView = UIView()
        }
    }
    
    public var isJustContent: Bool {
        get { return false }
        set {
            allowsSelection = !newValue
            separatorStyle = .none
        }
    }
    
    func reloadRow(_ row: Int, section: Int) {
        let indexPathRow:Int = row
        let indexPosition = IndexPath(row: indexPathRow, section: section)
        self.beginUpdates()
        self.reloadRows(at: [indexPosition], with: .none)
        self.endUpdates()
    }
    /// Register a cell from external xib into a table instance.
    ///
    /// - Parameter _: cell class
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableCell {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.reuseIdentifier, bundle: bundle)
        self.register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    /// Dequeue a cell instance strongly typed.
    ///
    /// - Parameter indexPath: index path
    /// - Returns: instance
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: ReusableCell {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Cannot dequeue: \(T.self) with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}

protocol ReusableCell {
    static var reuseIdentifier: String { get }
    static var nib: UINib? { get }
    static var height: CGFloat { get }
}

extension ReusableCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib? {
        
        guard let _ = Bundle.main.path(forResource: reuseIdentifier, ofType: "nib") else { return nil }
        
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    static var height: CGFloat {
        return 0.0
    }
}
