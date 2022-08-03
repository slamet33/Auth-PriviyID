//
//  BaseViewModel.swift
//  Post Here
//
//  Created by Qiarra on 29/08/21.
//

import RxSwift
import RxCocoa

enum NetworkState {
    case loading
    case finish
    case error
}

class BaseViewModel {
    
    let disposeBag = DisposeBag()
    var state = PublishSubject<NetworkState>()
    var hudState = PublishSubject<NetworkState>()
    var error = PublishSubject<ErrorResponse>()
    var success = PublishSubject<Bool>()
    
}
