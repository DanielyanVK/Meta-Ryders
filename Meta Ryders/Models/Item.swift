//
//  Item.swift
//  Meta Ryders
//
//  Created by Vladislav on 12.02.2022.
//

import Foundation

struct Item: Codable {
    let name: String
    let imageName: String
    let description: String
    let price: Double
    let growth: Double
    let modelName: String
}
