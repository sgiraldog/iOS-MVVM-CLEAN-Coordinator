//
//  FetchPeopleListResponse.swift
//  MVVM-Clean-Coordinator
//
//  Created by Sebastian on 10/12/24.
//

import Foundation

struct FetchPeopleListResponse: Codable {
    let count: Int
    let results: [People]
}
