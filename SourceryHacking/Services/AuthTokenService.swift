//
//  AuthTokenService.swift
//  SourceryHacking
//
//  Created by Bohdan Savych on 15/05/2023.
//

import Foundation

final class AuthTokenService: NSObject, Service {
    static let identifier = "AuthTokenService"

    var encryptionService: EncryptionService!
}
