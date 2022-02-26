//
//  News.swift
//  Meta Ryders
//
//  Created by Vladislav on 26.02.2022.
//

import Foundation

struct News: Codable {
    let title: String
    let imageName: String
    let article: String?
    // Creating this as string for the sake of tasting. We'll swap to correct type later on
    let timePosted: String
    let sourceName: String
}
