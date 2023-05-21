//
//  UniversityService.swift
//  SourceryHacking
//
//  Created by Bohdan Savych on 16/05/2023.
//

import Foundation

final class UniversityService: NSObject, Service {
    static let identifier = "UniversityService"

    @DependancyWrapper
    var authTokenService: AuthTokenService
    @DependancyWrapper
    var userService: UserService
}
