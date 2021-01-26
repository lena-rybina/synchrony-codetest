//
//  Experience.swift
//  Profile
//
//  Created by Ielena R. on 1/25/21.
//

import Foundation

enum ExperienceType: String, Codable {
    case work
    case projects
    case education
}

struct Experience: Codable {
    let id: UUID
    let companyName: String
    let type: ExperienceType
    let position: String
    let startDate: String
    let endDate: String?
    let details: [String]

    enum CodingKeys: String, CodingKey {
        case id
        case type
        case details
        case position
        case endDate = "end_date"
        case startDate = "start_date"
        case companyName = "company_name"
    }
}
