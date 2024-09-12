//
//  Category.swift
//  Recipe_Test
//
//  Created by Brian Novie on 9/11/24.
//

import Foundation

// Not used this could be used for meal categories

struct MealCategory: Decodable, Identifiable {
    let id: String
    let name: String
    let thumbURL: String
    let details: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case name = "strCategory"
        case thumbURL = "strCategoryThumb"
        case details = "strCategoryDescription"
    }
}
