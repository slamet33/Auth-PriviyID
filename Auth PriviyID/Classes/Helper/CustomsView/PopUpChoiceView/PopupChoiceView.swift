//
//  PopupChoiceView.swift
//  Auth PriviyID
//
//  Created by Qiarra on 08/09/21.
//

import UIKit
import BottomPopup
import RxSwift

struct ChoiseData {
    var id: Int
    var name: String
}

protocol PopupChoiceViewDelegate: NSObject {
    func didSelectedChoice(_ id: Int, data: String, image: UIImage?, index: Int)
}

class PopupChoiceView: BottomPopupViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleChoise: UILabel!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    var height: CGFloat?
    var topCornerRadius: CGFloat?
    var presentDuration: Double?
    var dismissDuration: Double?
    var shouldDismissInteractivelty: Bool?
    
    override var popupHeight: CGFloat { return height ?? CGFloat(400) }
    
    override var popupTopCornerRadius: CGFloat { return topCornerRadius ?? CGFloat(14) }
    
    override var popupPresentDuration: Double { return presentDuration ?? 0.3 }
    
    override var popupDismissDuration: Double { return dismissDuration ?? 0.3 }
    
    override var popupShouldDismissInteractivelty: Bool { return shouldDismissInteractivelty ?? true }
    
    var disposeBag = DisposeBag()
    var choiseData = [ChoiseData]()
    var selectedIndex: Int = 0
    weak var delegate: PopupChoiceViewDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        bindViewModel()
    }
    
    func setView() {
//        self.loading.isHidden = true
        self.view.frame =  CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.popupHeight)
        
        tableView.register(PopupChoiceTableCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        
        self.titleChoise.text = "Gender"
        self.tableView.selectRow(at: IndexPath(row: selectedIndex, section: 0), animated: true, scrollPosition: .none)
    }
    
    func bindViewModel() {}

}

extension PopupChoiceView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return choiseData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PopupChoiceTableCell = tableView.dequeueReusableCell(for: indexPath)
        
        cell.hideImg()
        cell.countLbl.text = choiseData[indexPath.row].name
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = choiseData[indexPath.row]
        self.selectedIndex = indexPath.row
        self.delegate?.didSelectedChoice(data.id, data: data.name, image: nil, index: self.selectedIndex)
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
