//
//  SignInRepository.swift
//  Post Here
//
//  Created by Qiarra on 31/08/21.
//

import RxSwift

struct SignInRepository {
    
    func signIn(request: SignInRequest) -> Single<ApiResult<SuccessSignInModel, ErrorResponse>> {
        return APIClient.shared.requests(endPoint: SignInEndPoint.doLogin(request: request))
    }
    
}
