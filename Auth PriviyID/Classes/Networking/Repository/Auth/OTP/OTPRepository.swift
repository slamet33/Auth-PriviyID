//
//  OTPRepository.swift
//  Auth PriviyID
//
//  Created by Slamet Riyadi on 04/08/22.
//

import RxSwift

struct OTPRepository {
    
    func matchOtp(request: OTPRequest) -> Single<ApiResult<SuccessSignInModel, ErrorResponse>> {
        return APIClient.shared.requests(endPoint: SignUpEndPoint.matchOtp(request: request))
    }
    
    func requestOTP(request: OTPRequest) -> Single<ApiResult<RegisterModelData, ErrorResponse>> {
        return APIClient.shared.requests(endPoint: SignUpEndPoint.request(request: request))
    }
    
}
