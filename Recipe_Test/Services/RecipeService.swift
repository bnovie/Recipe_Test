//
//  RecipeService.swift
//  Recipe_Test
//
//  Created by Brian Novie on 9/11/24.
//

import Foundation

enum MyError: Error {
    case noDetails
}

final class RecipeService {
    private let dessert = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    private let mealDetail = "https://themealdb.com/api/json/v1/1/lookup.php?i="
    private let mealCategory = "https://themealdb.com/api/json/v1/1/filter.php?c=" // Not used but if we wanted to get more than just Desserts this could be used
    private let mealCategories = "https://www.themealdb.com/api/json/v1/1/categories.php" // Not used but if we want to expand application to handle all food categories then use this

    func fetch<T: Decodable>(from url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let httpResponse = response as? HTTPURLResponse {
            print(response)
            if httpResponse.statusCode != 200 {
                // This is where we could handle error or throw it
            }
        }
        // Debugging code
        let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
        print(json)
        // End debuggingn code
        
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }

    func fetchDessertList() async throws -> MealList {
        let url = URL(string: dessert)!
        
        return try await fetch(from: url)
    }
    
    func fetchDetail(_ mealId: String) async throws -> MealDetail {
        let url = URL(string: mealDetail+"\(mealId)")!
        
        let mealDetails: MealDetailList = try await fetch(from: url)
        
        // Expectation is an array of 1 meal detail, so lets grab the 1st
        guard let mealDetail = mealDetails.meals.first else {
            throw MyError.noDetails
        }
        return mealDetail
    }
}
