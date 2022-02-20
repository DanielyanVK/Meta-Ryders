//
//  Category.swift
//  Meta Ryders
//
//  Created by Vladislav on 16.02.2022.
//

import Foundation

struct Category: Codable {
    let name: String
}


extension Category: Equatable {
    static func == (lhs: Category, rhs: Category) -> Bool {
        lhs.name == rhs.name
    }
}
