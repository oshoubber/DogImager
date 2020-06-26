//
//  BreedsListResponse.swift
//  DogImager
//
//  Created by Osama on 6/25/20.
//  Copyright © 2020 Osama. All rights reserved.
//

import Foundation

struct BreedsListResponse: Codable {
    let status: String
    let message: [String:[String]]
}
