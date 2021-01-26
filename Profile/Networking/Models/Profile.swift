//
//  Profile.swift
//  Profile
//
//  Created by Ielena R. on 1/25/21.
//

import Foundation

struct Profile: Codable {
    let id: UUID
    let name: String
    private let profileURLString: String

    let socialList: [Social]
    let experienceList: [Experience]

    var profileURL: URL? {
        URL(string: profileURLString)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case socialList = "social_list"
        case profileURLString = "profile_url"
        case experienceList = "experience_list"
    }
}
