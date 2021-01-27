//
//  ProfileRows.swift
//  Profile
//
//  Created by Ielena R. on 1/25/21.
//

import Foundation

struct ExperienceRow {
    let companyName: String
    let position: String
    let startDate: String
    let endDate: String
    let details: [String]
}

struct SocialRow {
    let name: String
    let path: String
}

enum ProfileRows {
    case profileImage(URL?)
    case name(String)
    case experience(ExperienceRow)
    case social(SocialRow)
}
