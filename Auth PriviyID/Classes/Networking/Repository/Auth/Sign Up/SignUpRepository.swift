//
//  SignUpRepository.swift
//  Auth PriviyID
//
//  Created by Qiarra on 04/09/21.
//

import RxSwift

struct SignUpRepository {
    
    func signUp(request: SignUpRequest) -> Single<ApiResult<RegisterModel, ErrorResponse>> {
        return APIClient.shared.requests(endPoint: SignUpEndPoint.doRegister(request: request))
    }
    
    func otp(request: SignUpRequest) -> Single<ApiResult<RegisterModel, ErrorResponse>> {
        return APIClient.shared.requests(endPoint: SignUpEndPoint.otp(request: request))
    }
    
}
