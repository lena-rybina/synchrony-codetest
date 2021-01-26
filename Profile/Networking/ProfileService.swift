//
//  ProfileService.swift
//  Profile
//
//  Created by Ielena R. on 1/25/21.
//

import Foundation

class ProfileService {
    class func getUserProfile(completed: @escaping (Profile)-> ()) {
        let bundle = Bundle.main
        let dataPath = bundle.path(forResource: "lenochka-profile",
                                   ofType: "json")!

        let data = try! Data(contentsOf: URL(fileURLWithPath: dataPath))

        let decoder = JSONDecoder()
        let result = try! decoder.decode(Profile.self,
                                         from: data)

        completed(result)
    }
}
