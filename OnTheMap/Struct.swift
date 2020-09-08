//
//  LoginRequest.swift
//  OnTheMap
//
//  Created by Haoran Li on 2020-09-08.
//  Copyright © 2020 Haoran Li. All rights reserved.
//

import Foundation

struct LoginRequest: Codable {
    
    let username: String
    let password: String
    
    enum CodingKeys: String, CodingKey{
        case username
        case password
    }
}
    /******************/

struct LoginResponseAccount: Codable {
    let registered: Bool
    let key: String
    
    enum CodingKeys: String, CodingKey {
        case registered
        case key
    }
}

struct LoginResponseSession: Codable {
    let id: String
    let expiration: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case expiration
    }
}

struct LoginResponse: Codable {
    let account: LoginResponseAccount
    let session: LoginResponseSession
    
    enum CodingKeys: String, CodingKey{
        case account
        case session
    }
    
}
    /******************/


