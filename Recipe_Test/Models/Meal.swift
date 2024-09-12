//
//  Meal.swift
//  Recipe_Test
//
//  Created by Brian Novie on 9/12/24.
//

import Foundation

struct MealList:Decodable {
    let meals: [Meal]
}

struct Meal: Decodable, Identifiable, Hashable, Comparable {
    static func < (lhs: Meal, rhs: Meal) -> Bool {
        lhs.name < rhs.name
    }
    
    let id: String
    let name: String
    let thumbURL: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumbURL = "strMealThumb"
    }
}
