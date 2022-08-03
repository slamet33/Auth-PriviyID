//
//  EditProfileRepository.swift
//  Auth PriviyID
//
//  Created by Slamet Riyadi on 04/08/22.
//

import RxSwift
import RxAlamofire

struct EditProfileRepository {
    
    func career(request: EditProfileRequest) -> Single<ApiResult<EditProfileModel, ErrorResponse>> {
        return APIClient.shared.requests(endPoint: EditProfileEndPoint.editCarrer(request: request))
    }
    
    func education(request: EditProfileRequest) -> Single<ApiResult<EditProfileModel, ErrorResponse>> {
        return APIClient.shared.requests(endPoint: EditProfileEndPoint.editEducation(request: request))
    }
    
    func editProfile(request: EditProfileRequest) -> Single<ApiResult<EditProfileModel, ErrorResponse>> {
        return APIClient.shared.requests(endPoint: EditProfileEndPoint.editBio(request: request))
    }
    
}
