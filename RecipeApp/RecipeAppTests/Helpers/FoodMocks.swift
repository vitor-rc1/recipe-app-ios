//
//  FoodMocks.swift
//  RecipeAppTests
//
//  Created by Vitor Conceicao on 23/04/22.
//

import Foundation
@testable import RecipeApp

final class FoodMocks {
    static let shared: FoodMocks = FoodMocks()
    
    func mockMeals() -> [Meal] {
        var meal: [Meal] = []
        meal.append(Meal(id: "52772",
                         name: "Teriyaki Chicken Casserole",
                         thumb: "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg",
                         category: "Chicken",
                         videoURL: "https://www.youtube.com/watch?v=4aZr5hZXP_s"))
        meal.append(Meal(id: "52977",
                         name: "Corba",
                         thumb: "https://www.themealdb.com/images/media/meals/58oia61564916529.jpg",
                         category: "Side",
                         videoURL: "https://www.youtube.com/watch?v=VVnZd8A84z4"))
        meal.append(Meal(id: "53060",
                         name: "Burek",
                         thumb: "https://www.themealdb.com/images/media/meals/tkxquw1628771028.jpg",
                         category: "Side",
                         videoURL: "https://www.youtube.com/watch?v=YsJXZwE5pdY"))
        meal.append(Meal(id: "52977",
                         name: "Kumpir",
                         thumb: "https://www.themealdb.com/images/media/meals/58oia61564916529.jpg",
                         category: "Side",
                         videoURL: "https://www.youtube.com/watch?v=IEDEtZ4UVtI"))
        return meal
    }
    
    func mockMeal() -> Meal {
        return Meal(id: "52772",
                    name: "Teriyaki Chicken Casserole",
                    thumb: "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg",
                    category: "Chicken",
                    videoURL: "https://www.youtube.com/watch?v=4aZr5hZXP_s")
    }
}
