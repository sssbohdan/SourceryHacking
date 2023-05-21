//
//  UserService.swift
//  SourceryHacking
//
//  Created by Bohdan Savych on 15/05/2023.
//

import Foundation

final class UserService: NSObject, Service {
    static let identifier = "UserService"

    @DependancyWrapper
    var authTokenService: AuthTokenService
    @DependancyWrapper
    var universityService: UniversityService
}
