//
//  ProfileRepository.swift
//  Auth PriviyID
//
//  Created by Slamet Riyadi on 04/08/22.
//

import RxSwift

struct ProfileRepository {
    
    func getProfile() -> Single<ApiResult<EditProfileModel, ErrorResponse>> {
        return APIClient.shared.requests(endPoint: ProfileEndPoint.profile)
    }
    
    func logout(viewModel: ProfileViewModel) -> Single<ApiResult<EditProfileModel, ErrorResponse>> {
        return APIClient.shared.requests(endPoint: ProfileEndPoint.logout(request: viewModel.request))
    }
    
}
