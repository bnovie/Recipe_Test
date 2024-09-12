//
//  MealView.swift
//  Recipe_Test
//
//  Created by Brian Novie on 9/12/24.
//

import SwiftUI

struct MealListView: View {
    @StateObject var viewModel: MealListViewModel = MealListViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.state {
                case .initial:
                    Text("Initial State")
                case .loading:
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                case .loaded(let meals):
                    List(meals.sorted()) { meal in
                        mealNavigationRow(meal)
                    }
                    .navigationDestination(for: Meal.self) { meal in
                        MealDetailView(meal: meal)
                    }
                case .error(let error):
                    Text(error.localizedDescription)
                }
            }
            .navigationTitle("Dessert")
            .padding()
            .task {
                await viewModel.fetchDessert()
            }
        }
    }
    
    private func mealNavigationRow(_ meal: Meal) -> some View {
        NavigationLink(value: meal) {
            HStack {
                AsyncThumbnail(url: URL(string:meal.thumbURL)!, size: 44)
                Text(meal.name)
                    .font(.headline)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical)
        }
    }
}

final class MealListViewModel: ObservableObject {
    enum State {
        case initial
        case loading
        case loaded([Meal])
        case error(Error)
    }

    @Published private(set) var state: State = .initial
    private let service = RecipeService()

    @MainActor
    func fetchDessert() async {
        state = .loading
        do {
            let mealList = try await service.fetchDessertList()
            state = .loaded(mealList.meals)
        } catch {
            state = .error(error)
        }
    }
}

#Preview {
    MealListView()
}
