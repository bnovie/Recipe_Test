//
//  MealDetail.swift
//  Recipe_Test
//
//  Created by Brian Novie on 9/11/24.
//

import SwiftUI
import AVKit

struct MealDetailView: View {
    let meal: Meal
    @StateObject var viewModel: MealDeatailViewModel = MealDeatailViewModel(state: .initial)

    var body: some View {
        VStack {
            switch viewModel.state {
            case .initial:
                Text("Initial State")
            case .loading:
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            case .loaded(let mealDetailModel):
                ScrollView {
                    VStack {
                        AsyncThumbnail(url: URL(string: mealDetailModel.thumbURL), size:240)
                        Text("Ingredients")
                            .font(.headline)
                        VStack {
                            ForEach(mealDetailModel.ingredients) { ingredient in
                                ingredientRow(ingredient: ingredient)
                            }
                        }
                        .padding()
                        Text(mealDetailModel.instructions)
                        Spacer()
                    }
                    .padding(.horizontal)
                }
            case .error(let error):
                Text(error.localizedDescription)
            }
        }
        .navigationTitle(meal.name)
        .navigationBarTitleDisplayMode(.inline)
        .padding()
        .task {
            await viewModel.fetchMeal( meal)
        }
    }
    
    private func ingredientRow(ingredient: Ingredient) -> some View {
        HStack {
            Text(ingredient.name)
            Spacer()
            Text(ingredient.measure)
        }
    }
}

#Preview {
    MealDetailView(meal: Meal(id: "", name: "", thumbURL: "")) }

final class MealDeatailViewModel: ObservableObject {
    enum State {
        case initial
        case loading
        case loaded(MealDetail)
        case error(Error)
    }

    @Published private(set) var state: State
    private let service = RecipeService()
    
    init(state: State) {
        self.state = state
    }

    @MainActor
    func fetchMeal(_ meal: Meal) async {
        state = .loading
        do {
            let detail = try await service.fetchDetail(meal.id)
            state = .loaded(detail)
        } catch {
            state = .error(error)
        }
    }
}
