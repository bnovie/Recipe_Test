//
//  MealDetail.swift
//  Recipe_Test
//
//  Created by Brian Novie on 9/12/24.
//

import Foundation

struct MealDetailList:Decodable {
    let meals: [MealDetail]
}

struct MealDetail: Decodable {

    let id: String
    let name: String
    let thumbURL: String
    let category: String
    let area: String?
    let instructions: String
//    let tags: [String]?
    let youTube: String?
    let ingredients: [Ingredient]

    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumbURL = "strMealThumb"
        case category = "strCategory"
        case area = "strArea"
//        case tags = "strTags"
        case youTube = "strYoutube"
        case instructions = "strInstructions"
        case ingredient1 = "strIngredient1"
        case measure1 = "strMeasure1"
        case ingredient2 = "strIngredient2"
        case measure2 = "strMeasure2"
        case ingredient3 = "strIngredient3"
        case measure3 = "strMeasure3"
        case ingredient4 = "strIngredient4"
        case measure4 = "strMeasure4"
        case ingredient5 = "strIngredient5"
        case measure5 = "strMeasure5"
        case ingredient6 = "strIngredient6"
        case measure6 = "strMeasure6"
        case ingredient7 = "strIngredient7"
        case measure7 = "strMeasure7"
        case ingredient8 = "strIngredient8"
        case measure8 = "strMeasure8"
        case ingredient9 = "strIngredient9"
        case measure9 = "strMeasure9"
        case ingredient10 = "strIngredient10"
        case measure10 = "strMeasure10"
        case ingredient11 = "strIngredient11"
        case measure11 = "strMeasure11"
        case ingredient12 = "strIngredient12"
        case measure12 = "strMeasure12"
        case ingredient13 = "strIngredient13"
        case measure13 = "strMeasure13"
        case ingredient14 = "strIngredient14"
        case measure14 = "strMeasure14"
        case ingredient15 = "strIngredient15"
        case measure15 = "strMeasure15"
        case ingredient16 = "strIngredient16"
        case measure16 = "strMeasure16"
        case ingredient17 = "strIngredient17"
        case measure17 = "strMeasure17"
        case ingredient18 = "strIngredient18"
        case measure18 = "strMeasure18"
        case ingredient19 = "strIngredient19"
        case measure19 = "strMeasure19"
        case ingredient20 = "strIngredient20"
        case measure20 = "strMeasure20"
    }
    typealias IngredientKeys = (ingredient: CodingKeys, measure: CodingKeys)

    let ingredientKeys: [IngredientKeys] = [(.ingredient1, .measure1),
                                            (.ingredient2, .measure2),
                                            (.ingredient3, .measure3),
                                            (.ingredient4, .measure4),
                                            (.ingredient5, .measure5),
                                            (.ingredient6, .measure6),
                                            (.ingredient7, .measure7),
                                            (.ingredient8, .measure8),
                                            (.ingredient9, .measure9),
                                            (.ingredient10, .measure10),
                                            (.ingredient11, .measure11),
                                            (.ingredient12, .measure12),
                                            (.ingredient13, .measure13),
                                            (.ingredient14, .measure14),
                                            (.ingredient15, .measure15),
                                            (.ingredient16, .measure16),
                                            (.ingredient17, .measure17),
                                            (.ingredient18, .measure18),
                                            (.ingredient19, .measure19),
                                            (.ingredient20, .measure20),
    ]

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.thumbURL = try container.decode(String.self, forKey: .thumbURL)
        self.category = try container.decode(String.self, forKey: .category)
        self.area = try container.decodeIfPresent(String.self, forKey: .area)
        self.youTube = try container.decodeIfPresent(String.self, forKey: .youTube)
        self.instructions = try container.decode(String.self, forKey: .instructions)
        
        // ingredients and measure
        var ingredients: [Ingredient] = []
        var ingredient: String?
        var measure: String?
        for codingKeyTuple in ingredientKeys {
            ingredient = try? container.decode(String.self, forKey: codingKeyTuple.ingredient)
            measure = try? container.decode(String.self, forKey: codingKeyTuple.measure)
            if let ingredient, let measure, !ingredient.isEmpty {
                ingredients.append(Ingredient(name: ingredient.capitalized, measure: measure))
            }
        }

        self.ingredients = ingredients
    }
}

struct Ingredient: Identifiable {
    let name: String
    let measure: String
    let id: String = UUID().uuidString // was going to use name as id but saw duplicate ingredients
}
