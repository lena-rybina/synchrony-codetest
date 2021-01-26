//
//  ProfileModel.swift
//  Profile
//
//  Created by Ielena R. on 1/25/21.
//

import Foundation

class ProfileModel {
    func fetchProfile(completed: @escaping (Profile)->()) {
        ProfileService.getUserProfile(completed: completed)
    }
}
