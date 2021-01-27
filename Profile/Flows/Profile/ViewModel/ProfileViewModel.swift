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

    func fetchRows(completed: @escaping (Result<[ProfileRows], Error>)->()) {
        model.fetchProfileAndMapToRows(completed: completed)
    }
}
