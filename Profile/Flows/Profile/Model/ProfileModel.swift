//
//  ProfileModel.swift
//  Profile
//
//  Created by Ielena R. on 1/25/21.
//

import Foundation

/// Responsible for fetching profile and mapping to rows
/// that's going to be used down the line
class ProfileModel {
    /// Fetching profile and mapping to rows
    func fetchProfileAndMapToRows(completed: @escaping (Result<[ProfileRows], Error>)->()) {
        ProfileService.getUserProfile(completed: { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let profile):
                let processedRows = self.processProfileToRows(profile)
                completed(.success(processedRows))
            case .failure(let error):
                completed(.failure(error))
            }
        })
    }

    /// Map profile to rows
    private func processProfileToRows(_ profile: Profile)-> [ProfileRows] {
        /// Flat data structure, 1 dimentional array
        var result: [ProfileRows] = [.profileImage(profile.profileURL),
                                     .name(profile.name)]

        /// Appending experience rows
        /// Iterate and create row from experience list
        profile.experienceList.forEach { experience in
            let companyName = experience.companyName
            let position = experience.position
            let startDate = experience.startDate
            let endDate = experience.endDate ?? "Present"
            let details = experience.details

            let row = ExperienceRow(companyName: companyName,
                                    position: position,
                                    startDate: startDate,
                                    endDate: endDate,
                                    details: details)

            result.append(.experience(row))
        }

        /// Appending social rows
        /// Iterate and create row from social list
        profile.socialList.forEach { social in
            let socialType = social.type
            let socialPath = social.path
            let socialName = social.type.rawValue.capitalized

            let row = SocialRow(name: socialName,
                                path: socialPath,
                                type: socialType)
            result.append(.social(row))
        }

        return result
    }
}
