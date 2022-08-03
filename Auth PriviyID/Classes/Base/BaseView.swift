//
//  BaseView.swift
//  Post Here
//
//  Created by Qiarra on 29/08/21.
//

import UIKit
import RxSwift
import MKProgress
import NVActivityIndicatorView

open class BaseView: UIViewController, UIGestureRecognizerDelegate {
    
    open var disposeBag = DisposeBag()
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 12.0, *) {
            if traitCollection.userInterfaceStyle == .light {
                if #available(iOS 13.0, *) {
                    return .darkContent
                } else {
                    return .default
                }
            } else {
                return .lightContent
            }
        } else {
            return .default
        }
    }
    
    let loading = NVActivityIndicatorView(frame: .zero, type: .circleStrokeSpin, color: Colors.darkGray, padding: 0)
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        MKProgress.config.hudType = .radial
        MKProgress.config.width = 80.0
        MKProgress.config.height = 80.0
        MKProgress.config.circleRadius = 30.0
        MKProgress.config.circleBorderWidth = 3.0
        MKProgress.config.circleBorderColor = .darkGray
        MKProgress.config.logoImageSize = CGSize(width: 26.0, height: 26.0)
        startAnimation()
        
        // Enable swipe gesture back
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func addNavigationTitle(_ title: String, textColor: UIColor = .lightGray, textSize: CGFloat = 16, alpha: CGFloat = 1.0) {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = title
        titleLabel.textColor = textColor.withAlphaComponent(alpha)
        titleLabel.textAlignment = .left
        navigationItem.titleView = titleLabel
    }
    
    internal func setNavigationBar (
        barTintColor: UIColor = .white,
        imgArrow: UIImage? = UIImage(named: "ic_back"),
        forModal: Bool = false,
        isTransparent: Bool = false) {
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.setHidesBackButton(true, animated: false)
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 8, width: 24, height: 24))
        imageView.contentMode = .scaleAspectFill
        
        if forModal {
            imageView.image = #imageLiteral(resourceName: "icBackDark")
            let backTap = UITapGestureRecognizer(target: self, action: #selector(didTapDismissGesture(_:)))
            view.addGestureRecognizer(backTap)
        } else {
            imageView.image = imgArrow
            let backTap = UITapGestureRecognizer(target: self, action: #selector(didTapBackGesture(_:)))
            view.addGestureRecognizer(backTap)
        }
        
        view.addSubview(imageView)
        
        let leftBarButtonItem = UIBarButtonItem(customView: view)
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationController?.navigationBar.shadowImage = UIImage()
        
        if isTransparent {
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            navigationController?.navigationBar.isTranslucent = true
        } else {
            navigationController?.navigationBar.barTintColor = barTintColor
            navigationController?.navigationBar.tintColor = barTintColor
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.shadowImage = UIImage()
        }
        
    }
    
    
    @objc func didTapBackGesture(_ tapGesture: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapDismissGesture(_ tapGesture: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func shadowNavigationBarDidScroll(_ scrollView: UIScrollView, useHeader: Bool = false, headerHeight: CGFloat = 300) {
        
        guard let navBar = navigationController?.navigationBar else {
            return
        }
        
        if useHeader {
            if scrollView.contentOffset.y - (-headerHeight) > navBar.frame.height {
                addShadow(navBar)
            } else {
                deleteShadow(navBar)
            }
        } else {
            if scrollView.contentOffset.y > navBar.frame.height {
                addShadow(navBar)
            } else {
                deleteShadow(navBar)
            }
        }
        
        
    }
    
    @objc func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.shadowNavigationBarDidScroll(scrollView)
    }
    
    func addShadow(_ view: UIView) {
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        view.layer.masksToBounds = false
        view.layer.shadowRadius = 6.0
        view.layer.shadowOpacity = 0.5
    }
    
    func deleteShadow(_ view: UIView) {
        view.layer.shadowOffset = CGSize(width: 0, height: 0.0)
        view.layer.shadowRadius = 0
        view.layer.shadowOpacity = 0
    }
    
    fileprivate func startAnimation() {
        
        loading.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loading)
        
        NSLayoutConstraint.activate([
            loading.widthAnchor.constraint(equalToConstant: 40),
            loading.heightAnchor.constraint(equalToConstant: 40),
            loading.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loading.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
    
    func showCustomToast(_ title: String, subTitle: String, alertType: CustomSwiftAlertType = .success) {
        // show toast
        var bgColor: UIColor = .blue
        var borderColor: UIColor = .blue
        var textColor: UIColor = .white
        
        if alertType == .error {
            bgColor = .red
            borderColor = .red
            textColor = .white
        }
        
        let toast = CustomSwiftToast(
            duration: 4.0,
            minimumHeight: nil,
            aboveStatusBar: true,
            statusBarStyle: .lightContent,
            isUserInteractionEnabled: true,
            target: nil,
            style: .bottomToTop,
            title: title,
            subtitle: subTitle,
            backgroundColor: bgColor,
            borderColor: borderColor,
            textColor: textColor,
            bottomConstraint : 90.0
        )
        self.present(toast, withCustomSwiftToastView: RMToastView(), animated: true)
    }
    
    func present(_ toast: SwiftToastProtocol, withCustomSwiftToastView customToastView: SwiftToastViewProtocol, animated: Bool) {
        SwiftToastController.shared.present(toast, swiftToastView: customToastView, animated: animated)
    }
}

