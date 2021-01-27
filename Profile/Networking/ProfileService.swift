//
//  ProfileService.swift
//  Profile
//
//  Created by Ielena R. on 1/25/21.
//

import Foundation

enum ProfileServiceError: Error {
    case missingData
}

class ProfileService {
    class func getUserProfile(completed: @escaping (Result<Profile, Error>)-> ()) {
        let url = URL(string: "https://s3.amazonaws.com/ielena.codetest/lenochka-profile.json")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            /// Forcing main thread, UI will crash on background
            DispatchQueue.main.async {
                /// Error check
                if let error = error {
                    completed(.failure(error))
                    return
                }

                /// Check if data exists
                guard let data = data else {
                    completed(.failure(ProfileServiceError.missingData))
                    return
                }

                /// Try to decode
                do {
                    let decoder = JSONDecoder()
                    let profile = try decoder.decode(Profile.self,
                                                     from: data)

                    completed(.success(profile))

                } catch let error {
                    completed(.failure(error))
                }
            }
        }.resume()
    }
}
