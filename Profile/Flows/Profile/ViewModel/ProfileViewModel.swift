//
//  ProfileViewModel.swift
//  Profile
//
//  Created by Ielena R. on 1/25/21.
//

import Foundation

class ProfileViewModel {
    let model: ProfileModel

    init(model: ProfileModel) {
        self.model = model
    }

    func fetchProfile(completed: @escaping (Result<[ProfileRows], Error>)->()) {
        model.fetchProfile(completed: { [weak self] result in
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

    private func processProfileToRows(_ profile: Profile)-> [ProfileRows] {
        /// Flat data structure, 1 dimentional array
        var result: [ProfileRows] = [.profileImage(profile.profileURL),
                                     .name(profile.name)]

     /// Appending experience rows

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

//        /// 1. Iterate through each element
//        /// 2. Transform current element to row
//        let mapSocialToRow = profile.socialList.map { social in
//            return SocialRow(name: social.type.rawValue, path: social.path)
//        }
//
//        /// 3. Append row to result
//        result.append(contentsOf: mapSocialToRow)

        profile.socialList.forEach { social in
            let socialPath = social.path
            let socialName = social.type.rawValue.capitalized

            let row = SocialRow(name: socialName,
                                path: socialPath)
            result.append(.social(row))
        }


        return result
    }
}


