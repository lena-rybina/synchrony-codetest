//
//  EntityDecodingTests.swift
//  EntityDecodingTests
//
//  Created by Ielena R. on 1/25/21.
//

import XCTest
@testable import Profile

class EntityDecodingTests: XCTestCase {
    func testEntityDecoding() {
        /// Having a bundle
        let bundle = Bundle.main

        /// With resource for given path
        let dataPath = bundle.path(forResource: "lenochka-profile",
                                   ofType: "json")!

        /// Get data
        let data = try! Data(contentsOf: URL(fileURLWithPath: dataPath))

        /// Having decoder
        let decoder = JSONDecoder()

        /// Decode profile
        XCTAssertNoThrow(try decoder.decode(Profile.self,
                                            from: data))
    }
}
