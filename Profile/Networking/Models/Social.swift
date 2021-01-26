//
//  Social.swift
//  Profile
//
//  Created by Ielena R. on 1/25/21.
//

import Foundation

enum SocialType: String,
                 Codable {
    case linkedIn
    case gitHub
    case phone
    case email
}

struct Social: Codable {
    let id: UUID
    let type: SocialType
    let path: String

    enum CodingKeys: String, CodingKey {
        case id
        case type
        case path
    }
}
